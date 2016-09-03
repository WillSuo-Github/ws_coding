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

@interface Coding_NetAPIManager : NSObject

+ (instancetype)sharedManager;

- (void)request_Login_WithPath:(NSString *)path Params:(id)params andBlock:(void(^)(id data, NSError *error))block;

@end
