//
//  Login.m
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Login.h"

#define kLoginDataListPath @"login_data_list_path.plist"
#define kLoginStatus @"login_status"
#define kLoginUserDict @"user_dict"
#define kLoginPreUserEmail @"pre_user_email"


static User *curLoginUser;

@implementation Login

- (NSString *)toPath{
    return @"api/v2/account/login";
}

- (NSDictionary *)toParams{
    NSMutableDictionary *params = @{@"account": self.email,
                                    @"password" : [self.password sha1Str],
//                                    @"remember_me" : self.remember_me? @"true" : @"false",
                                    @"remember_me" : @"true" 
                                    }.mutableCopy;
    if (self.j_captcha.length > 0) {
        params[@"j_captcha"] = self.j_captcha;
    }
    return params;
}

+ (void)setPreUserEmail:(NSString *)emailStr{
    
    if (emailStr.length <= 0) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emailStr forKey:kLoginPreUserEmail];
    [defaults synchronize];
}

+ (BOOL)isLogin{
    
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    if (loginStatus.boolValue && [Login curLoginUser]) {
        User *loginUser = [Login curLoginUser];
        if (loginUser.status && loginUser.status.integerValue == 0) {
            return NO;
        }
        return YES;
    }else{
        return NO;
    }
}


+ (NSMutableDictionary *)readLoginDataList{
    
    NSMutableDictionary *loginDataList = [NSMutableDictionary dictionaryWithContentsOfFile:[self loginDataListPath]];
    if (!loginDataList) {
        loginDataList = [NSMutableDictionary dictionary];
    }
    return loginDataList;
}

+ (NSString *)loginDataListPath{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentPath stringByAppendingString:kLoginDataListPath];
}

+ (User *)userWithGlobaykeyOrEmail:(NSString *)textStr{
    
    if (textStr.length <= 0) {
        return nil;
    }
    NSMutableDictionary *loginDataList = [self readLoginDataList];
    NSDictionary *loginData = [loginDataList objectForKey:textStr];
    return [NSObject objectOfClass:@"User" fromJSON:loginData];
}

+ (void)doLoginOut{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
    [userDefaults synchronize];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.domain hasSuffix:@".coding.net"]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
        }
    }];
    [Login setXGAccountWithCurUser];
}

+ (void)doLoginIn:(NSDictionary *)loginData{
    if (loginData) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        [defaults setObject:loginData forKey:kLoginUserDict];
        curLoginUser = [NSObject objectOfClass:@"User" fromJSON:loginData];
        [defaults synchronize];
        
        [self saveLoginData:loginData];//??保存的是dict   是否能保存对象  能否优化
    }else{
        [Login doLoginOut];
    }
}

+ (BOOL)saveLoginData:(NSDictionary *)loginData{
    BOOL saved = NO;
    if (loginData) {
        NSMutableDictionary *loginDataList = [self readLoginDataList];
        User *curUser = [NSObject objectOfClass:@"User" fromJSON:loginData];
        if (curUser.global_key.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.global_key];
            saved = YES;
        }
        if (curUser.email.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.email];
            saved = YES;
        }
        if (curUser.phone.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.phone];
            saved = YES;
        }
        if (saved) {
            saved = [loginDataList writeToFile:[self loginDataListPath] atomically:YES];
        }
    }
    return saved;
}

+ (void)setXGAccountWithCurUser{//推送相关
    if ([self isLogin]) {
        
        User *user = [Login curLoginUser];
        if (user && user.global_key.length > 0) {
            NSString *global_key = user.global_key;
            
        }
    }else{
        //注销信鸽的推送
    }
}


- (NSString *)goToLoginTipWithCaptcha:(BOOL)needCaptcha{
    
    if (!_email || _email.length <= 0) {
        return @"请填写「手机号码/电子邮箱/个性后缀」";
    }
    if (!_password || _password.length <= 0) {
        return @"请填写密码";
    }
    if (needCaptcha && (!_j_captcha || _j_captcha.length <= 0)) {
        return @"请填写验证码";
    }
    return nil;
}

+ (User *)curLoginUser{
    if (!curLoginUser) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
        curLoginUser = loginData ? [NSObject objectOfClass:@"User" fromJSON:loginData] : nil;
    }
    return curLoginUser;
}



@end
