//
//  WGURLSession.m
//  Sample
//
//  Created by 7owen on 16/3/14.
//  Copyright © 2016年 7owen. All rights reserved.
//

#import "WGURLSession.h"

@interface WGURLSession ()

@property (nonatomic, strong) WGURLRequestContext *requestContext;
@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation WGURLSession

+ (WGURLSession * (^)(WGURLRequestContext *requestContext))requestContext {
    return ^(WGURLRequestContext *requestContext){
        WGURLSession *session = [WGURLSession new];
        session.requestContext = requestContext;
        return session;
    };
}

+ (WGURLSession * (^)(NSURLRequest *request))request {
    return ^(NSURLRequest *request){
        WGURLSession *session = [WGURLSession new];
        session.request = request;
        return session;
    };
}

- (WGURLSession * (^)(id<WGURLSessionDomainResolution> domainResolution))domainResolution {
    return ^(id<WGURLSessionDomainResolution> domainResolution){
        if (domainResolution) {
            if (_request) {
                NSMutableURLRequest *request = [_request mutableCopy];
                NSString *ip = [domainResolution queryWithDomain:request.URL.host];
                if (ip) {
                    [request addValue:request.URL.host forHTTPHeaderField:@"Host"];
                    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
                    urlComponents.host = ip;
                    request.URL = [urlComponents URL];
                }
                self.request = request;
            } else if (_requestContext) {
                _requestContext.connectIPAddress = [domainResolution queryWithDomain:_requestContext.serverInfo.host];
            }
        }
        return self;
    };
}

- (WGURLSession * (^)(WGURLSessionEditRequest requestBlock))editRequest {
    return ^(WGURLSessionEditRequest requestBlock){
        NSMutableURLRequest *request = [self.request mutableCopy];
        requestBlock(request);
        self.request = request;
        return self;
    };
}

- (WGURLSession * (^)(AFHTTPSessionManager *manager, WGURLSessionCompletionHandler completionHandler))get {
    return ^(AFHTTPSessionManager *manager, WGURLSessionCompletionHandler completionHandler){
        NSURLRequest *request = self.request;
        if (request) {
            NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                if (!error) {
                    NSLog(@"Response: %@", responseObject);
                    if (completionHandler) {
                        completionHandler(httpResponse, responseObject, nil);
                    }
                } else {
                    NSLog(@"Response code: %ld,error:%@ responseData:%@", (long)httpResponse.statusCode,error, responseObject);
                    if (completionHandler) {
                        completionHandler(httpResponse, responseObject, error);
                    }
                }
            }];
            [task resume];
        } else {
            completionHandler(nil, nil, nil);
        }
        return self;
    };
}

- (NSURLRequest*)request {
    if (!_request) {
        _request = [_requestContext generateURLRequest];
    }
    return _request;
}

@end
