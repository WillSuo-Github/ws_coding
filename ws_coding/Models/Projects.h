//
//  Projects.h
//  ws_coding
//
//  Created by ws on 16/9/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Projects : NSObject

@property (strong, nonatomic) User *curUser;

//请求
@property (readwrite, nonatomic, strong) NSNumber *page, *pageSize;


+ (Projects *)projectsWithUser:(User *)user;

- (NSString *)toPath;

- (NSDictionary *)toParams;

@end
