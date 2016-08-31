//
//  User.m
//  ws_coding
//
//  Created by ws on 16/8/31.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)userWithGlobalKey:(NSString *)global_key{
    
    User *curUser = [[User alloc] init];
    curUser.global_key = global_key;
    return curUser;
}

@end
