//
//  UIButton+Bootstrap.m
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "UIButton+Bootstrap.h"

@implementation UIButton (Bootstrap)

-(void)bootstrapStyle{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

-(void)successStyle{
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x3bbc79"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x3bbc79" andAlpha:0.5]] forState:UIControlStateDisabled];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x32a067"]] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
}

- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    const SEL selArray[] = {@selector(bootstrapStyle), @selector(defaultManager), @selector(primaryStyle), @selector(successStyle), @selector(infoStyle), @selector(warningStyle), @selector(dangerStyle)};
    if ([btn respondsToSelector:selArray[style]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [btn performSelector:selArray[style]];
#pragma clang diagnostic pop
    }
    return btn;
}



@end
