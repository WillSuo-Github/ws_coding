//
//  Projects.h
//  ws_coding
//
//  Created by ws on 16/9/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Project.h"
typedef NS_ENUM(NSInteger, ProjectsType)
{
    ProjectsTypeAll = 0,
    ProjectsTypeCreated,
    ProjectsTypeJoined,
    ProjectsTypeWatched,
    ProjectsTypeStared,
    ProjectsTypeToChoose,
    ProjectsTypeTaProject,
    ProjectsTypeTaStared,
    ProjectsTypeTaWatched,
    ProjectsTypeAllPublic,
};


@interface Projects : NSObject

@property (strong, nonatomic) User *curUser;
@property (assign, nonatomic) ProjectsType type;

//请求
@property (readwrite, nonatomic, strong) NSNumber *page, *pageSize;
@property (readwrite, nonatomic, strong) NSMutableArray<Project *> *list;

//解析
@property (nonatomic, strong) NSNumber *totalRow, *totalPage;


+ (Projects *)projectsWithType:(ProjectsType)type User:(User *)user;

- (NSString *)toPath;

- (NSDictionary *)toParams;

- (void)configWithProjects:(Projects *)responsePros;
- (NSArray *)pinList;
- (NSArray *)noPinList;
@end
