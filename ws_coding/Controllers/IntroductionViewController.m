//
//  IntroductionViewController.m
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "IntroductionViewController.h"
#import "SMPageControl.h"
#import <NYXImagesKit.h>
#import "LoginViewController.h"

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
    [self configAnimations];
}


- (NSString *)imageKeyForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld_image", (long)index];
}

- (NSString *)viewKeyForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld_view", (long)index];
}


#pragma mark - Orientations
- (BOOL)shouldAutorotate{//转动屏幕时调用 返回yes 代表能旋转，返回no代表不能旋转
    
    NSLog(@"-----%d",UIInterfaceOrientationIsLandscape(self.interfaceOrientation));
    
    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{//界面优选方向  //??旋转屏幕有问题
    
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}


- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
}

#pragma mark Super
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self animateCurrentFrame];
    NSInteger nearestPage = floorf(self.pageOffset + 0.5);
    self.pageControl.currentPage = nearestPage;
}

#pragma mark Views
- (void)configViews{
    //配置登录、注册按钮和pageControl
    [self configButtonAndPageControl];
    
    CGFloat scaleFactor = 1.0;
    CGFloat desginHeight = 667;//iPhone6 的设计尺寸
    if (!kDevice_Is_iPhone6 && !kDevice_Is_iPhone6Plus) {
        scaleFactor = kScreen_Height/desginHeight;
    }
    
    for (int i = 0; i < self.numberOfPages; i ++) {
        NSString *imageKey = [self imageKeyForIndex:i];
        NSString *viewKey = [self viewKeyForIndex:i];
        NSString *iconImageName = [self.iconsDict objectForKey:imageKey];
        NSString *tipImageName = [self.tipsDict objectForKey:imageKey];
        
        if (iconImageName) {
            UIImage * iconImage = [UIImage imageNamed:iconImageName];
            if (iconImage) {
                iconImage = scaleFactor != 1.0? [iconImage scaleByFactor:scaleFactor] : iconImage;
                UIImageView *iconView = [[UIImageView alloc] initWithImage:iconImage];
                [self.contentView addSubview:iconView];
                [self.iconsDict setObject:iconView forKey:viewKey];
            }
        }
        
        if (tipImageName) {
            UIImage *tipImage = [UIImage imageNamed:tipImageName];
            if (tipImage) {
                tipImage = scaleFactor != 1.0? [tipImage scaleByFactor:scaleFactor] : tipImage;
                UIImageView *tipView = [[UIImageView alloc] initWithImage:tipImage];
                [self.contentView addSubview:tipView];
                [self.tipsDict setObject:tipView forKey:viewKey];
            }
        }
        
    }
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
    
    if (!kDevice_Is_iPhone6 && !kDevice_Is_iPhone6Plus) {
        CGFloat desginWidth = 375;//iphone 6 的设计尺寸
        CGFloat scaleFactor = kScreen_Width/desginWidth;
        pageIndicatorImage = [pageIndicatorImage scaleByFactor:scaleFactor];
        currentPageIndicatorImage = [currentPageIndicatorImage scaleByFactor:scaleFactor];
    }
    
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
- (void)configAnimations{
    
    [self configureTipAndTitleViewAnitions];
}

- (void)configureTipAndTitleViewAnitions{
    
    for (int i = 0; i < self.numberOfPages; i ++) {
        NSString *viewKey = [self viewKeyForIndex:i];
        UIView *iconView = [self.iconsDict objectForKey:viewKey];
        UIView *tipView = [self.tipsDict objectForKey:viewKey];
        if (iconView) {
            if (i == 0) {
//                [self keepView:iconView onPages:@[@(i + 1),@(i)] atTimes:@[@(i - 1),@(i)]]; //??
                [self keepView:iconView onPage:i];
                [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(kScreen_Height / 7);
                }];
            }else{
                [self keepView:iconView onPage:i];
                [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(-kScreen_Height / 6);
                }];
            }
            IFTTTAlphaAnimation *iconAlphaAnimation = [[IFTTTAlphaAnimation alloc] initWithView:iconView];
            [iconAlphaAnimation addKeyframeForTime:i - 0.5f alpha:0.0f];
            [iconAlphaAnimation addKeyframeForTime:i alpha:1.0f];
            [iconAlphaAnimation addKeyframeForTime:i + 0.5f alpha:0.0f];
            [self.animator addAnimation:iconAlphaAnimation];
        }
        
        if (tipView) {
            
            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(iconView.mas_bottom).offset(kScaleFrom_iPhone5_Desgin(45));
            }];
            
            [self keepView:tipView onPages:@[@(i +1), @(i), @(i-1)] atTimes:@[@(i - 1), @(i), @(i +1)]];
            IFTTTAlphaAnimation *tipViewAnimation = [[IFTTTAlphaAnimation alloc] initWithView:tipView];
            [tipViewAnimation addKeyframeForTime:i - 0.5f alpha:0.0f];
            [tipViewAnimation addKeyframeForTime:i alpha:1.0f];
            [tipViewAnimation addKeyframeForTime:i + 0.5f alpha:0.0f];
            [self.animator addAnimation:tipViewAnimation];
        }
    }
}


#pragma mark Action
- (void)registerBtnClicked{
//    RegisterViewController *vc = [RegisterViewController vcWithMethodType:RegisterMethodPhone registerObj:nil];
//    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)loginBtnClicked{
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.showDismissButton = YES;
    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
