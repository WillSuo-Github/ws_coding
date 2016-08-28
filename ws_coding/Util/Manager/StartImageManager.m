//
//  StartImageManager.m
//  ws_coding
//
//  Created by ws on 16/8/27.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "StartImageManager.h"

@interface StartImageManager ()
@property (nonatomic, strong) StartImage *startImage;
@end

@implementation StartImageManager

+ (instancetype)shardManager{
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[StartImageManager alloc] init];
    });
    return instance;
}


- (StartImage *)curImage{
    
    if (!_startImage) {
        _startImage = [StartImage defautImage];
    }
    return _startImage;
}

@end



@implementation StartImage

+ (StartImage *)defautImage{
    
    StartImage *st = [[StartImage alloc] init];
    st.discriptionStr = @"\"Light Returning\" © 十一步";
    st.fileName = @"STARTIMAGE.jpg";
    st.pathDisk = [[NSBundle mainBundle] pathForResource:@"STARTIMAGE" ofType:@"jpg"];
    return st;
}

- (UIImage *)image{
    
    return [UIImage imageWithContentsOfFile:self.pathDisk];
}

@end



@implementation Group



@end