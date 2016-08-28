//
//  Login.h
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

@property (readwrite, nonatomic, strong) NSString *email, *password;

+ (BOOL)isLogin;
@end
