//
//  Login.h
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Login : NSObject

@property (readwrite, nonatomic, strong) NSString *email, *password, *j_captcha;//邮箱， 密码， 验证码
@property (readwrite, nonatomic, strong) NSNumber *remember_me;

- (NSString *)toPath;
- (NSDictionary *)toParams;


+ (User *)curLoginUser;
+ (void)setPreUserEmail:(NSString *)emailStr;
+ (BOOL)isLogin;
+ (NSMutableDictionary *)readLoginDataList;
+ (User *)userWithGlobaykeyOrEmail:(NSString *)textStr;
+ (void)doLoginOut;
+ (void)doLoginIn:(NSDictionary *)loginData;

- (NSString *)goToLoginTipWithCaptcha:(BOOL)needCaptcha;
@end
