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

typedef void (^WGURLSessionEditRequest)(NSMutableURLRequest *request);
typedef void (^WGURLSessionCompletionHandler)(NSHTTPURLResponse *response, id responseObject, NSError *error);

@protocol WGURLSessionDomainResolution <NSObject>

- (NSString*)queryWithDomain:(NSString*)domain;

@end

@class WGURLRequestContext;

@interface WGURLSession : NSObject

+ (WGURLSession * (^)(WGURLRequestContext *requestContext))requestContext;
+ (WGURLSession * (^)(NSURLRequest *request))request;

- (WGURLSession * (^)(id<WGURLSessionDomainResolution> domainResolution))domainResolution;
- (WGURLSession * (^)(WGURLSessionEditRequest requestBlock))editRequest;
- (WGURLSession * (^)(AFHTTPSessionManager *manager))sessionManager;
- (WGURLSession * (^)(WGURLSessionCompletionHandler completionHandler))get;

@end
