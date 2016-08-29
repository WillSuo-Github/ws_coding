//
//  NSObject+Common.m
//  ws_coding
//
//  Created by ws on 16/8/29.
//  Copyright © 2016年 ws. All rights reserved.
//
#define kTestKey @"BaseURLIsTest"


#import "NSObject+Common.h"

@implementation NSObject (Common)


#pragma mark BaseURL
+ (NSString *)baseURLStr{
    NSString *baseURLStr;
    if ([self baseURLStrIsTest]) {
        //staging
        baseURLStr = kBaseUrlStr_Test;
    }else{
        //生产
        baseURLStr = @"https://coding.net/";
    }
    //    //staging
    //    baseURLStr = kBaseUrlStr_Test;
    //    //村民
    //    baseURLStr = @"http://192.168.0.188:8080/";
    //    //彭博
    //    baseURLStr = @"http://192.168.0.156:9990/";
    //    //小胖
    //    baseURLStr = @"http://192.168.0.222:8080/";
    
    return baseURLStr;
}

+ (BOOL)baseURLStrIsTest{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kTestKey] boolValue];
}

@end
