//
//  Projects.m
//  ws_coding
//
//  Created by ws on 16/9/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Projects.h"

@implementation Projects


+ (Projects *)projectsWithType:(ProjectsType)type User:(User *)user{
    
    Projects *pros = [[Projects alloc] init];
    pros.curUser = user;
    pros.type = type;
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
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"list" : [Project class]};
}

- (void)configWithProjects:(Projects *)responsePros{
    self.page = responsePros.page;
    self.totalRow = responsePros.totalRow;
    self.totalPage = responsePros.totalPage;
    
    NSArray *projectList = responsePros.list;
//    if (self.type == ProjectsTypeToChoose) {
//        projectList = [projectList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"is_public == %d", NO]];
//    }
//    if (!projectList) {
//        return;
//    }
    
//    if (_willLoadMore) {
//        [self.list addObjectsFromArray:projectList];
//    }else{
        self.list = [NSMutableArray arrayWithArray:projectList];
//    }
}

- (NSArray *)pinList{
    NSArray *list = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.pin.intValue == 1"];
    list = [self.list filteredArrayUsingPredicate:predicate];
    return list;
}
- (NSArray *)noPinList{
    NSArray *list = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pin.intValue == 0"];
    list = [self.list filteredArrayUsingPredicate:predicate];
    return list;
}

@end
