//
//  Project.h
//  ws_coding
//
//  Created by ws on 16/9/10.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface Project : NSObject

@property (readwrite, nonatomic, strong) NSString *icon, *name, *owner_user_name, *backend_project_path, *full_name, *description_mine, *path, *parent_depot_path, *current_user_role,*project_path;
@property (readwrite, nonatomic, strong) NSNumber *id, *owner_id, *is_public, *un_read_activities_count, *done, *processing, *star_count, *stared, *watch_count, *watched, *fork_count, *forked, *recommended, *pin, *type, *current_user_role_id, *gitReadmeEnabled;
@property (assign, nonatomic) BOOL isStaring, isWatching, isLoadingMember, isLoadingDetail;

@end
