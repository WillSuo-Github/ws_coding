//
//  Tweet_RootViewController.h
//  ws_coding
//
//  Created by ws on 16/9/3.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, Tweet_RootViewControllerType){
    Tweet_RootViewControllerTypeAll = 0,
    Tweet_RootViewControllerTypeFriend,
    Tweet_RootViewControllerTypeHot,
    Tweet_RootViewControllerTypeMine
};

@interface Tweet_RootViewController : BaseViewController
+ (instancetype)newTweetVCWithType:(Tweet_RootViewControllerType)type;
@end
