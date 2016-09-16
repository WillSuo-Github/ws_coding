//
//  NSObject+Common.h
//  ws_coding
//
//  Created by ws on 16/8/29.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

+ (NSString *)baseURLStr;
+ (BOOL)baseURLStrIsTest;
+ (BOOL)baseURLStrIsProduction;

-(id)handleResponse:(id)responseJSON;
- (id)handleResponse:(id)responseJson autoShowError:(BOOL)autoShowError;

+ (void)showHudTipStr:(NSString *)tipStr;
+ (BOOL)showError:(NSError *)error;

- (NSString *)jsonDataToSting;
@end
