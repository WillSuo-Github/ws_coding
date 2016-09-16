//
//  NSString+Common.m
//  ws_coding
//
//  Created by ws on 16/8/31.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "NSString+Common.h"
#import "RegexKitLite.h"
#import "sys/utsname.h"
#import "RegexKitLite.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Common)

- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view{
    return [self urlImageWithCodePathResize:[[UIScreen mainScreen] scale] * CGRectGetWidth(view.frame)];
}

- (NSURL *)urlImageWithCodePathResize:(CGFloat)width{
    return [self urlImageWithCodePathResize:width crop:NO];
}

- (NSURL *)urlImageWithCodePathResize:(CGFloat)width crop:(BOOL)needCrop{
    NSString *urlStr;
    BOOL canCrop = NO;
    if (!self || self.length <= 0) {
        return nil;
    }else{
        if (![self hasPrefix:@"http"]) {
            NSString *imageName = [self stringByMatching:@"/static/fruit_avatar/([a-zA-Z0-9\\-._]+)$" capture:1];
            if (imageName && imageName.length > 0) {
                urlStr = [NSString stringWithFormat:@"http://coding-net-avatar.qiniudn.com/%@?imageMogr2/auto-orient/thumbnail/!%.0fx%.0fr", imageName, width, width];
                canCrop = YES;
            }else{
                urlStr = [NSString stringWithFormat:@"%@%@", [NSObject baseURLStr], self];
            }
        }else{
            urlStr = self;
            if ([urlStr rangeOfString:@"qbox.me"].location != NSNotFound) {
                if ([urlStr rangeOfString:@".gif"].location != NSNotFound) {
                    if ([urlStr rangeOfString:@"?"].location != NSNotFound) {
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"/thumbnail/!%.0fx%.0fr/format/png", width, width]];
                    }else{
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?imageMogr2/auto-orient/thumbnail/!%.0fx%.0fr/format/png", width, width]];
                    }
                }else{
                    if ([urlStr rangeOfString:@"?"].location != NSNotFound) {
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"/thumbnail/!%.0fx%.0fr", width, width]];
                    }else{
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?imageMogr2/auto-orient/thumbnail/!%.0fx%.0fr", width, width]];
                    }
                }
                canCrop = YES;
            }else if ([urlStr rangeOfString:@"www.gravatar.com"].location != NSNotFound){
                urlStr = [urlStr stringByReplacingOccurrencesOfString:@"s=[0-9]*" withString:[NSString stringWithFormat:@"s=%.0f", width] options:NSRegularExpressionSearch range:NSMakeRange(0, [urlStr length])];
            }else if ([urlStr hasSuffix:@"/imagePreview"]){
                urlStr = [urlStr stringByAppendingFormat:@"?width=%.0f", width];
            }
        }
        if (needCrop && canCrop) {
            urlStr = [urlStr stringByAppendingFormat:@"/gravity/Center/crop/%.0fx%.0f", width, width];
        }
        return [NSURL URLWithString:urlStr];
    }
}

- (NSString*) sha1Str
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:CGSizeMake(floor(size.width), floor(size.height))//用相对小的 width 去计算 height / 小 heigth 算 width
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(floor(resultSize.width + 1), floor(resultSize.height + 1));//上面用的小 width（height） 来计算了，这里要 +1
    return resultSize;
}
@end
