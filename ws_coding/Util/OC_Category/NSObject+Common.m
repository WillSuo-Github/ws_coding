//
//  NSObject+Common.m
//  ws_coding
//
//  Created by ws on 16/8/29.
//  Copyright © 2016年 ws. All rights reserved.
//
#define kTestKey @"BaseURLIsTest"
#define kBaseURLStr @"https://coding.net/"


#import "Login.h"
#import "NSObject+Common.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import "JDStatusBarNotification.h"

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

+ (BOOL)baseURLStrIsProduction{
    return [[self baseURLStr] isEqualToString:kBaseURLStr];
}

+ (BOOL)baseURLStrIsTest{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kTestKey] boolValue];
}

-(id)handleResponse:(id)responseJSON{
    return [self handleResponse:responseJSON autoShowError:YES];
}

- (id)handleResponse:(id)responseJson autoShowError:(BOOL)autoShowError{
    
    NSError *error = nil;
    NSInteger errorCode = [(NSNumber *)[responseJson valueForKeyPath:@"code"] integerValue];
    if (errorCode != 0) {
        error = [NSError errorWithDomain:[NSObject baseURLStr] code:errorCode userInfo:responseJson];
        if (errorCode == 1000 || errorCode == 3207) {//用户没有登录
            if ([Login isLogin]) {
                [Login doLoginOut];//抹除登录信息
                
                //更新 UI 要延迟 >1.0 秒，否则屏幕可能会不响应触摸事件。。暂不知为何
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
//                    kTipAlert(@"%@", [NSObject tipFromError:error]);//??原工程解析了xml 这里暂时先不用
                });
            }
        }else{//??似乎是弹出必要的验证码
            
            
        }
    }
    return error;
}

+ (BOOL)showError:(NSError *)error{
    if ([JDStatusBarNotification isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
        NSLog(@"如果statusBar上面正在显示信息，则不再用hud显示error");
        return NO;
    }
//    NSString *tipStr = [NSObject tipFromError:error];//??解析xml 跳过
    [NSObject showHudTipStr:error.domain];
    return YES;
}

+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}


- (NSString *)jsonDataToSting{
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return string;
}
@end
