//
//  WGURLSession.h
//  Sample
//
//  Created by 7owen on 16/3/14.
//  Copyright © 2016年 7owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGURLRequestContext.h"

@class AFHTTPSessionManager;

typedef void (^WGURLSessionEditRequest)(NSMutableURLRequest *);
typedef void (^WGURLSessionCompletionHandler)(__kindof NSURLResponse *, id , NSError *);
typedef NSError*(^WGURLSessionErrorPreHandler)(__kindof NSURLResponse *, id , NSError *);
typedef id(^WGURLSessionResponsePreHandler)(__kindof NSURLResponse *, id , NSError *);

@protocol WGURLSessionDomainResolution <NSObject>

- (NSString*)queryWithDomain:(NSString*)domain;

@end

@class WGURLRequestContext;

@interface WGURLSession : NSObject

+ (void)setDefaultHTTPSessionManager:(AFHTTPSessionManager *)manager;
+ (void)setDefaultErrorPreHandler:(WGURLSessionErrorPreHandler)handler;
+ (void)setDefaultResponsePreHandler:(WGURLSessionResponsePreHandler)handler;

+ (WGURLSession * (^)(WGURLRequestContext *requestContext))requestContext;
+ (WGURLSession * (^)(NSURLRequest *request))request;

- (WGURLSession * (^)(id<WGURLSessionDomainResolution> domainResolution))domainResolution;
- (WGURLSession * (^)(WGURLSessionEditRequest requestBlock))editRequest;
- (WGURLSession * (^)(AFHTTPSessionManager *manager))sessionManager;
- (WGURLSession * (^)(WGURLSessionErrorPreHandler errorHandlerBlock))errorPreHandler;
- (WGURLSession * (^)(WGURLSessionResponsePreHandler responseHandlerBlock))responsePreHandler;
- (WGURLSession * (^)(WGURLSessionCompletionHandler completionHandler))get;

@end
