//
//  IntroductionViewController.m
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "IntroductionViewController.h"
#import "SMPageControl.h"

@interface IntroductionViewController ()

@property (strong, nonatomic) UIButton *registerBtn, *loginBtn;
@property (strong, nonatomic) NSMutableDictionary *iconsDict, *tipsDict;
@property (nonatomic, strong) SMPageControl *pageControl;

@end

@implementation IntroductionViewController


- (instancetype)init
{
    if ((self = [super init])) {
        self.numberOfPages = 7;
        
        
        _iconsDict = [@{
                        @"0_image" : @"intro_icon_6",
                        @"1_image" : @"intro_icon_0",
                        @"2_image" : @"intro_icon_1",
                        @"3_image" : @"intro_icon_2",
                        @"4_image" : @"intro_icon_3",
                        @"5_image" : @"intro_icon_4",
                        @"6_image" : @"intro_icon_5",
                        } mutableCopy];
        _tipsDict = [@{
                       @"1_image" : @"intro_tip_0",
                       @"2_image" : @"intro_tip_1",
                       @"3_image" : @"intro_tip_2",
                       @"4_image" : @"intro_tip_3",
                       @"5_image" : @"intro_tip_4",
                       @"6_image" : @"intro_tip_5",
                       } mutableCopy];
        
        //        _iconsDict = [NSMutableDictionary new];
        //        _tipsDict = [NSMutableDictionary new];
        //        for (int i = 0; i < self.numberOfPages; i++) {
        //            NSString *imageKey = [self imageKeyForIndex:i];
        //            [_iconsDict setObject:[NSString stringWithFormat:@"intro_icon_%d", i] forKey:imageKey];
        //            [_tipsDict setObject:[NSString stringWithFormat:@"intro_tip_%d", i] forKey:imageKey];
        //        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
    [self configViews];
}

- (void)configViews{
    //配置登录、注册按钮和pageControl
    [self configButtonAndPageControl];
    
}

//配置登录、注册按钮和pageControl
- (void)configButtonAndPageControl{
    
    //button
    UIColor *darkColor = [UIColor colorWithHexString:@"0x28303b"];
    CGFloat buttonWidth = kScreen_Width * 0.4;
    CGFloat buttonHeight = kScaleFrom_iPhone5_Desgin(38);
    CGFloat paddingToCenter = kScaleFrom_iPhone5_Desgin(10);
    CGFloat paddingToBottom = kScaleFrom_iPhone5_Desgin(20);
    
    
    self.registerBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = darkColor;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        button;
    });
    self.loginBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setTitleColor:darkColor forState:UIControlStateNormal];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = darkColor.CGColor;
        button;
    });
    
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.loginBtn];
    
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.right.equalTo(self.view.mas_centerX).offset(-paddingToCenter);
        make.bottom.equalTo(self.view.mas_bottom).offset(-paddingToBottom);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.left.equalTo(self.view.mas_centerX).offset(paddingToCenter);
        make.bottom.equalTo(self.view).offset(-paddingToBottom);
    }];
    
    //pageControl
    
    UIImage *pageIndicatorImage = [UIImage imageNamed:@"intro_dot_unselected"];
    UIImage *currentPageIndicatorImage = [UIImage imageNamed:@"intro_dot_selected"];
    self.pageControl = ({
        
        SMPageControl *pageControl = [[SMPageControl alloc] init];
        pageControl.numberOfPages = self.numberOfPages;
        pageControl.userInteractionEnabled = NO;
        pageControl.pageIndicatorImage = pageIndicatorImage;
        pageControl.currentPageIndicatorImage = currentPageIndicatorImage;
        [pageControl sizeToFit];
        pageControl.currentPage = 0;
        pageControl;
    });
    
    [self.view addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kScaleFrom_iPhone5_Desgin(20)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.registerBtn.mas_top).offset(-kScaleFrom_iPhone5_Desgin(20));
    }];
}

#pragma mark Animations


#pragma mark Action
- (void)registerBtnClicked{
//    RegisterViewController *vc = [RegisterViewController vcWithMethodType:RegisterMethodPhone registerObj:nil];
//    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)loginBtnClicked{
//    LoginViewController *vc = [[LoginViewController alloc] init];
//    vc.showDismissButton = YES;
//    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
}

@end
