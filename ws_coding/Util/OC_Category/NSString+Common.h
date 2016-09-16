//
//  NSString+Common.h
//  ws_coding
//
//  Created by ws on 16/8/31.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view;
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width;
- (NSString*) sha1Str;
@end
