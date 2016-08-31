//
//  Login.m
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Login.h"

#define kLoginDataListPath @"login_data_list_path.plist"

@implementation Login

+ (BOOL)isLogin{
    
    return NO;
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



@end
