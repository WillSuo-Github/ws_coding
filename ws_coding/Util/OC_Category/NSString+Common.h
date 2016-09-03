//
//  NSString+Common.h
//  ws_coding
//
//  Created by ws on 16/8/31.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view;
- (NSString*) sha1Str;
@end
