//
//  StartImageManager.h
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StartImage;
@class Group;

@interface StartImageManager : NSObject

+ (instancetype)shardManager;

- (StartImage *)curImage;

@end


@interface StartImage : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) Group *group;
@property (nonatomic, strong) NSString *fileName, *discriptionStr, *pathDisk;

+ (StartImage *)defautImage;

- (UIImage *)image;
@end

@interface Group : NSObject
@property (strong, nonatomic) NSString *name, *author, *link;
@end