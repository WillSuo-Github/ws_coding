//
//  UITapImageView.m
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "UITapImageView.h"

@interface UITapImageView ()

@property (nonatomic, copy) void(^tapBlock)(id);

@end

@implementation UITapImageView

- (instancetype)init{
    
    return [self initWithFrame:CGRectZero];
}

- (void)tap{
    
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

- (void)addTapBlock:(void (^)(id))tapAction{
    self.tapBlock = tapAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)setImageWithUrl:(NSURL *)imageUrl placeHolderImage:(UIImage *)placeHolderImage tapBlock:(void (^)(id))tapAction{
    
    [self sd_setImageWithURL:imageUrl placeholderImage:placeHolderImage];
    [self addTapBlock:tapAction];
}

@end
