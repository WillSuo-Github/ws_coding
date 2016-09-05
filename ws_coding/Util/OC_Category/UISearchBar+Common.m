//
//  UISearchBar+Common.m
//  ws_coding
//
//  Created by ws on 16/9/4.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "UISearchBar+Common.h"

@implementation UISearchBar (Common)

- (void)insertBGColor:(UIColor *)backgroundColor{
    
    static NSInteger customBgTag = 999;
    UIView * realView = [[self subviews] firstObject];
    [[realView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == customBgTag) {
            [obj removeFromSuperview];
        }
    }];
    
    if (backgroundColor) {
        UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:backgroundColor]];
        [bgImage setFrame:self.bounds];
        [[[self subviews] firstObject] insertSubview:bgImage atIndex:1];
    }
}

@end
