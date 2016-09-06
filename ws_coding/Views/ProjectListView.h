//
//  ProjectListView.h
//  ws_coding
//
//  Created by ws on 16/9/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Projects.h"

@interface ProjectListView : UIView
- (instancetype)initWithFrame:(CGRect)frame projects:(Projects *)projects;

- (void)refreshToQueryData;

@end
