//
//  AppDelegate.m
//  ws_coding
//
//  Created by ws on 16/8/24.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabViewController.h"
#import "EaseStartView.h"
#import "Login.h"
#import "IntroductionViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //设置导航条样式
    [self customizeInterface];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    if ([Login isLogin]) {//已经登录过
        [self setupTabViewController];
    }else{
        [self setupIntroductionViewController];
    }
    [self.window makeKeyAndVisible];
    
    EaseStartView *startView = [EaseStartView startView];
    
    [startView startAnimationWithCompletionBlock:^(EaseStartView *easeStartView) {
        
    }];
    
    return YES;
}

- (void)customizeInterface{
    
    UINavigationBar *navBarAppearance = [UINavigationBar appearance];
    [navBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:[NSObject baseURLStrIsTest]? @"0x3bbd79" : @"0x28303b"]] forBarMetrics: UIBarMetricsDefault];
    [navBarAppearance setTintColor:[UIColor whiteColor]];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     };
    [navBarAppearance setTitleTextAttributes:textAttributes];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"3bbc97"]];
    [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"3bbc97"]];
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorTableSectionBg] forBarPosition:0 barMetrics:UIBarMetricsDefault];
    
}


//登录过后的主控制器
- (void)setupTabViewController{
    
    RootTabViewController *rootVC = [[RootTabViewController alloc] init];
    rootVC.tabBar.translucent = YES;
    
    [self.window setRootViewController:rootVC];
}

//启动页面
- (void)setupIntroductionViewController{
    IntroductionViewController *introductVC = [[IntroductionViewController alloc] init];
    [self.window setRootViewController:introductVC];
}

- (void)setupLoginViewController{
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.window setRootViewController:loginVC];
}

@end
