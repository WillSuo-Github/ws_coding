//
//  ProjectDescriptionCell.h
//  ws_coding
//
//  Created by ws on 16/9/16.
//  Copyright © 2016年 ws. All rights reserved.
//
#define kCellIdentifier_ProjectDescriptionCell @"ProjectDescriptionCell"

#import <UIKit/UIKit.h>

@interface ProjectDescriptionCell : UITableViewCell

- (void)setDescriptionStr:(NSString *)descriptionStr;

+ (CGFloat)cellHeightWithObj:(id)obj;

@end
