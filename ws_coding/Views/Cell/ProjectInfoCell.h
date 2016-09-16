//
//  ProjectInfoCell.h
//  ws_coding
//
//  Created by ws on 16/9/16.
//  Copyright © 2016年 ws. All rights reserved.
//

#define kCellIdentifier_ProjectInfoCell @"ProjectInfoCell"

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectInfoCell : UITableViewCell

@property (nonatomic, strong) Project *curProject;
+ (CGFloat)cellHeight;

@end
