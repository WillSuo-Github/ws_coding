//
//  UITableView+Common.h
//  ws_coding
//
//  Created by ws on 16/8/30.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Common)

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;

@end
