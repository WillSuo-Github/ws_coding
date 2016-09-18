//
//  ProjectViewController.h
//  ws_coding
//
//  Created by ws on 16/9/16.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectViewController : BaseViewController

@property (nonatomic, strong) Project *myProject;
@property (nonatomic, assign) NSInteger curIndex;

@end
