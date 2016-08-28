//
//  UIButton+Bootstrap.h
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    StrapBootstrapStyle = 0,
    StrapDefaultStyle,
    StrapPrimaryStyle,
    StrapSuccessStyle,
    StrapInfoStyle,
    StrapWarningStyle,
    StrapDangerStyle
} StrapButtonStyle;

@interface UIButton (Bootstrap)
+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector;

@end
