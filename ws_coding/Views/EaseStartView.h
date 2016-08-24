//
//  EaseStartView.h
//  ws_coding
//
//  Created by ws on 16/8/24.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EaseStartView : UIView

+ (instancetype)startView;

- (void)startAnimationWithCompletionBlock:(void(^)(EaseStartView *easeStartView))completionHandler;

@end
