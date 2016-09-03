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
#import "ViewController.h"
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

//登录过后的主控制器
- (void)setupTabViewController{
    
    RootTabViewController *rootVC = [[RootTabViewController alloc] init];
    rootVC.tabBar.translucent = YES;
    
    ViewController *vc = [[ViewController alloc] init];
    
    [self.window setRootViewController:vc];
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
