//  LoginViewController.m
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "LoginViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "StartImageManager.h"
#import <NYXImagesKit.h>
#import <UIImage+BlurredFrame/UIImage+BlurredFrame.h>
#import "Login.h"
#import "Login2FATipCell.h"
#import "Input_OnlyText_Cell.h"
#import "EaseInputTipsView.h"
#import "User.h"

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) BOOL captchaNeeded;//是否需要验证码
@property (nonatomic, strong) Login *myLogin;//登录的类
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;//主view
@property (nonatomic, strong) UIImageView *bgBlurredView;//主view的背景
@property (strong, nonatomic) UIImageView *iconUserView;//头部的logo
@property (strong, nonatomic) UIButton *loginBtn, *cannotLoginBtn;//登录按钮, 找回密码按钮
@property (strong, nonatomic) EaseInputTipsView *inputTipsView;
@property (strong, nonatomic) UIButton *dismissButton;


@property (assign, nonatomic) BOOL is2FAUI;//二次验证
@property (strong, nonatomic) NSString *otpCode;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLogin = [[Login alloc] init];
    self.tableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[Login2FATipCell class] forCellReuseIdentifier:kCellIdentifier_Login2FATipCell];
        [tableView registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Text];
        [tableView registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Captcha];
        
        tableView.backgroundView = self.bgBlurredView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView.tableHeaderView = [self customHeaderView];
        tableView.tableFooterView = [self customFooterView];
        tableView;
    });
    
    [self refreshIconUserImage];
    [self showdismissButton:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!_inputTipsView) {
        _inputTipsView = ({
            EaseInputTipsView *tipsView = [EaseInputTipsView tipsViewWithType:EaseInputTipsViewTypeLogin];
            tipsView.valueStr = nil;
            @weakify(self);
            tipsView.selectedStringBlock = ^(NSString *valueStr){
                @strongify(self);
                [self.view endEditing:YES];
                self.myLogin.email = valueStr;
                [self refreshIconUserImage];
                [self.tableView reloadData];
            };
            UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [tipsView setY:CGRectGetMaxY(cell.frame) - 0.5];
            [_tableView addSubview:tipsView];
            tipsView;
        });
    }
}

- (void)refreshIconUserImage{
    NSString *textStr = self.myLogin.email;
    if (textStr) {
        User *curUser = [Login userWithGlobaykeyOrEmail:textStr];//??后边都不太懂
        if (curUser && curUser.avatar) {
            //??缩放可以
            [self.iconUserView sd_setImageWithURL:[curUser.avatar urlImageWithCodePathResizeToView:self.iconUserView] placeholderImage:[UIImage imageNamed:@"icon_user_monkey"]];
        }
    }
}

- (void)showdismissButton:(BOOL)willShow{
    self.dismissButton.hidden = !willShow;
    if (!self.dismissButton && willShow) {
        self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
        [self.dismissButton setImage:[UIImage imageNamed:@"dismissBtn_Nav"] forState:UIControlStateNormal];
        [self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.dismissButton];
    }
}

#pragma mark TableView Header Footer
- (UIView *)customHeaderView{
    CGFloat iconUserViewWidth;
    if (kDevice_Is_iPhone6Plus) {
        iconUserViewWidth = 100;
    }else if (kDevice_Is_iPhone6){
        iconUserViewWidth = 90;
    }else{
        iconUserViewWidth = 75;
    }
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/3)];
    
    _iconUserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconUserViewWidth, iconUserViewWidth)];
    _iconUserView.contentMode = UIViewContentModeScaleAspectFit;
    _iconUserView.layer.masksToBounds = YES;
    _iconUserView.layer.cornerRadius = _iconUserView.bounds.size.width/2;
    _iconUserView.layer.borderWidth = 2;
    _iconUserView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [headerV addSubview:_iconUserView];
    [_iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconUserViewWidth, iconUserViewWidth));
        make.center.equalTo(headerV);
    }];
    [_iconUserView setImage:[UIImage imageNamed:@"icon_user_monkey"]];
    
    return headerV;
}


- (UIView *)customFooterView{
    
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    _loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(kLoginPaddingLeftWidth, 20, kScreen_Width - 2*kLoginPaddingLeftWidth, 45) target:self action:@selector(sendLogin:)];
    [footerV addSubview:_loginBtn];
    RAC(self, loginBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, myLogin.email),
                                                             RACObserve(self, myLogin.password)]
                                                    reduce:^id(NSString *email,
                                                               NSString *passWord){
                                                        return @((email && email.length > 0) && (passWord && passWord.length > 0));
    }];
    
    _cannotLoginBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [button setTitle:@"找回密码" forState:UIControlStateNormal];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(button.bounds.size.width, button.bounds.size.height));
            make.centerX.equalTo(footerV);
            make.top.equalTo(self.loginBtn.mas_bottom).offset(20);
        }];
        [button addTarget:self action:@selector(cannotLoginBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    
    
    return footerV;
}

#pragma mark btn Chick
//登录点击事件
- (void)sendLogin:(UIButton *)loginBtn{
    
    
}

//找回密码的点击事件
- (void)cannotLoginBtnChick:(UIButton *)cannotLoginBtn{
    
    
}

- (void)dismissButtonClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark UITableViewDelegate


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _is2FAUI? 2: _captchaNeeded? 3: 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.is2FAUI && indexPath.row == 0) {
        Login2FATipCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Login2FATipCell];
        cell.tipLabel.text = @"  您的账户开启了两步验证，请输入动态验证码登录  ";
        return cell;
    }
    
    Input_OnlyText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:(indexPath.row > 1?kCellIdentifier_Input_OnlyText_Cell_Captcha : kCellIdentifier_Input_OnlyText_Cell_Text) forIndexPath:indexPath];
    cell.isForLoginVC = YES;
    @weakify(self);
    if (self.is2FAUI) {
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell setPlaceholder:@" 动态验证码" value:self.otpCode];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            @strongify(self);
            self.otpCode = valueStr;
        };
    }else{
        if (indexPath.row == 0) {
            cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
            [cell setPlaceholder:@" 手机号码/电子邮箱/个性后缀" value:self.myLogin.email];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                @strongify(self);
                self.inputTipsView.valueStr = valueStr;
                self.inputTipsView.active = YES;
                self.myLogin.email = valueStr;
                [self refreshIconUserImage];
            };
            cell.editDidBeginBlock = ^(NSString *valueStr){
                @strongify(self);
                self.inputTipsView.valueStr = valueStr;
                self.inputTipsView.active = YES;
            };
            
            cell.editDidEndBlock = ^(NSString *textStr){
                @strongify(self);
                self.inputTipsView.active = NO;
            };
        }else if (indexPath.row == 1){
            [cell setPlaceholder:@" 密码" value:self.myLogin.password];
            cell.textField.secureTextEntry = YES;
            cell.textValueChangedBlock = ^(NSString *valueStr){
                @strongify(self);
                self.myLogin.password = valueStr;
            };
        }else{
            [cell setPlaceholder:@" 验证码" value:self.myLogin.j_captcha];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                @strongify(self);
                self.myLogin.j_captcha = valueStr;
            };
        }
    }
    
    return cell;
}

#pragma mark 懒加载
- (UIImageView *)bgBlurredView{
    
    if (!_bgBlurredView) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:kScreen_Bounds];
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *bgImage = [[StartImageManager shardManager] curImage].image;
        
        CGSize bgImageSize = bgImage.size, bgViewSize = bgView.bounds.size;
        if (bgImageSize.width > bgViewSize.width && bgImageSize.height > bgViewSize.height) {
            bgImage = [bgImage scaleToSize:bgViewSize usingMode:NYXResizeModeAspectFill];
        }
        bgImage = [bgImage applyLightEffectAtFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];//毛玻璃效果!!
        bgView.image = bgImage;
        //黑色遮盖
        UIColor *blackColor = [UIColor blackColor];
        [bgView addGradientLayerWithColors:@[(id)[blackColor colorWithAlphaComponent:0.3].CGColor,
                                             (id)[blackColor colorWithAlphaComponent:0.3].CGColor]
                                 locations:nil startPoint:CGPointMake(0.5, 0.0)
                                  endPoint:CGPointMake(0.5, 1.0)];//一个渐变的遮盖!!
        _bgBlurredView = bgView;
        
    }
    return _bgBlurredView;
}

@end
