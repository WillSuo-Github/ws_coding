//
//  UITapImageView.h
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapImageView : UIImageView

- (void)addTapBlock:(void(^)(id obj))tapAction;

- (void)setImageWithUrl:(NSURL *)imageUrl placeHolderImage:(UIImage *)placeHolderImage tapBlock:(void(^)(id obj))tapAction;

@end
