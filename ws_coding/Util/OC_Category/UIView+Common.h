//
//  UIView+Common.h
//  ws_coding
//
//  Created by ws on 16/8/24.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)
- (CGSize)doubleSizeOfFrame;

- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
@end
