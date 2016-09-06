//
//  Coding_NetAPIManager.h
//  ws_coding
//
//  Created by ws on 16/9/3.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodingNetAPIClient.h"
#import "User.h"
#import "Login.h"
#import "Projects.h"

@interface Coding_NetAPIManager : NSObject

+ (instancetype)sharedManager;

#pragma mark 登录
- (void)request_Login_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

#pragma mark 首页项目列表
- (void)request_Projects_WithObj:(Projects *)projects andBlock:(void (^)(Projects *data, NSError *error))block;

@end
