//
//  CodingNetAPIClient.h
//  ws_coding
//
//  Created by ws on 16/9/3.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, NetWorkMethod){
    
    GET =0,
    POST,
    PUT,
    DELETE
};

@interface CodingNetAPIClient : AFHTTPRequestOperationManager

+ (CodingNetAPIClient *)sharedJsonClient;

+ (id)changeJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(NetWorkMethod)method
                       andBlock:(void(^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(NetWorkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void(^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                     withParams:(NSDictionary*)params
                 withMethodType:(NetWorkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

@end
