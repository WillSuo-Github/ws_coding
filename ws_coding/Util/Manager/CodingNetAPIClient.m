//
//  CodingNetAPIClient.m
//  ws_coding
//
//  Created by ws on 16/9/3.
//  Copyright © 2016年 ws. All rights reserved.
//

#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]

#import "CodingNetAPIClient.h"

@implementation CodingNetAPIClient

static dispatch_once_t onceToken;
static CodingNetAPIClient *_sharedClient = nil;

+ (CodingNetAPIClient *)sharedJsonClient{
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CodingNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseURLStr]]];
    });
    return _sharedClient;
}

+ (id)changeJsonClient{
    _sharedClient = [[CodingNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseURLStr]]];
    return _sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url{
    
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}


- (void)requestJsonDataWithPath:(NSString *)aPath withParams:(NSDictionary *)params withMethodType:(NetWorkMethod)method andBlock:(void (^)(id, NSError *))block{
    
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath withParams:(NSDictionary *)params withMethodType:(NetWorkMethod)method autoShowError:(BOOL)autoShowError andBlock:(void (^)(id, NSError *))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    
    DebugLog(@"/n===========request=============/n%@/n%@.n%@",kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    switch (method) {
        case GET:{
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath stringByAppendingString:params.description];
            }
            [self GET:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@",aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
//                    responseObject = [//??缓存机制暂时放弃
                    block(nil, error);
                }else{
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        //判断数据是否符合预期,给出提示
                        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                            if (responseObject[@"data"][@"too_many_files"]) {
                                if (autoShowError) {
                                    [NSObject showHudTipStr:@"文件太多，不能正常显示"];
                                }
                            }
                        }
                        
                        //??保存缓存
                    }
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@",aPath, error, operation.responseString);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
            
            break;}
        case PUT:{
                [self PUT:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                    id error = [self handleResponse:responseObject autoShowError:autoShowError];
                    if (error) {
                        block(nil, error);
                    }else{
                        block(responseObject, nil);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, operation.responseString);
                    !autoShowError || [NSObject showError:error];
                    block(nil, error);
                }];
            break;}
        case POST:{
            [self POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, operation.responseString);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
            break;}
        case DELETE:{
            [self DELETE:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, operation.responseString);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
            break;}
        default:
            break;
    }
}

- (void)requestJsonDataWithPath:(NSString *)aPath file:(NSDictionary *)file withParams:(NSDictionary *)params withMethodType:(NetWorkMethod)method andBlock:(void (^)(id, NSError *))block{
    
    //log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Data
    NSData *data;
    NSString *name, *fileName;
    if (file) {
        UIImage *image = file[@"image"];
        
        //压缩图片
        data = UIImageJPEGRepresentation(image, 1.0);
        if ((float)data.length/1024 > 1000) {
            data = UIImageJPEGRepresentation(image, 1024*1000.0/(float)data.length);
        }
        
        name = file[@"name"];
        fileName = file[@"fileName"];
    }
    
    switch (method) {
        case POST:{
            AFHTTPRequestOperation *operation = [self POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                if (file) {
                    [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
                }
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, operation.responseString);
                [NSObject showError:error];
                block(nil, error);
            }];
            [operation start];
            break;}
        default:
            break;
    }
}



@end
