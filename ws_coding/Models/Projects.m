//
//  Projects.m
//  ws_coding
//
//  Created by ws on 16/9/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Projects.h"

@implementation Projects


+ (Projects *)projectsWithUser:(User *)user{
    
    Projects *pros = [[Projects alloc] init];
    pros.curUser = user;
    
    pros.page = [NSNumber numberWithInteger:1];
    pros.pageSize = [NSNumber numberWithInteger:9999];
    return pros;
}


- (NSString *)toPath{
    return @"api/projects";
}

- (NSDictionary *)toParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{@"page" : [NSNumber numberWithInteger:1],
                                     @"pageSize" : self.pageSize,
                                     @"type" : @"all"}];
    return params;
}

@end
