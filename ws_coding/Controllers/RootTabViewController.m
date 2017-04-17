
//
//  RootTabViewController.m
//  ws_coding
//
//  Created by ws on 16/8/24.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "RootTabViewController.h"
#import "Me_RootViewController.h"
#import "Tweet_RootViewController.h"
#import "Message_RootViewController.h"
#import "Project_RootViewController.h"
#import "MyTask_RootViewController.h"
#import "BaseNavigationController.h"
#import "RDVTabBarItem.h"
#import "RKSwipeBetweenViewControllers.h"


@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewControllers];
}


- (void)setupViewControllers{
    Project_RootViewController *project = [[Project_RootViewController alloc] init];
    UINavigationController *nav_project = [[BaseNavigationController alloc] initWithRootViewController:project];
    
    MyTask_RootViewController *mytask = [[MyTask_RootViewController alloc] init];
    UINavigationController *nav_mytask = [[BaseNavigationController alloc] initWithRootViewController:mytask];
    
    RKSwipeBetweenViewControllers *nav_tweet = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
    [nav_tweet.viewControllerArray addObjectsFromArray:@[[Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeAll],
                                                         [Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeFriend],
                                                         [Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeHot]]];
    nav_tweet.buttonText = @[@"冒泡广场",@"朋友圈",@"热门冒泡"];
    
    Message_RootViewController *message = [[Message_RootViewController alloc] init];
    UINavigationController *nav_message = [[BaseNavigationController alloc] initWithRootViewController:message];
    
    Me_RootViewController *me = [[Me_RootViewController alloc] init];
    UINavigationController *nav_me = [[BaseNavigationController alloc] initWithRootViewController:me];
    
    [self setViewControllers:@[nav_project,nav_mytask,nav_tweet,nav_message,nav_me]];
    [self customizeTabBarForControllers];
    self.delegate = self;
    
    
}


- (void)customizeTabBarForControllers{
    
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    NSArray *tabBarItemImages = @[@"project", @"task", @"tweet", @"privatemessage", @"me"];
    NSArray *tabBarItemTitles = @[@"项目", @"任务", @"冒泡", @"消息", @"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
    
}

#pragma mark RDVTabBarControllerDelegate
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
//    BaseViewController *rootVC = (BaseViewController *)nav.topViewController;
    
    return YES;
}

@end
