//
//  ViewController.m
//  Sample
//
//  Created by 7owen on 16/3/14.
//  Copyright © 2016年 7owen. All rights reserved.
//

#import "ViewController.h"
#import "WGURLSession.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    id<WGURLSessionDomainResolution> resolution = nil;
    
    NSString *url = @"http://baidu.com/";
    WGURLRequestContext *requestContext = [WGURLRequestContext createWithURL:url];
    WGURLSession.requestContext(requestContext).editRequest(^(NSMutableURLRequest *request){
        request.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
    }).domainResolution(resolution).get(^(NSHTTPURLResponse *response, id responseObject, NSError *error){
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", responseObject);
        }
    });
    
    WGURLSession.requestContext(requestContext).get(^(NSHTTPURLResponse *respnse, id responseObject, NSError *error){
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", responseObject);
        }
    });
    
    WGURLSession.requestContext(requestContext).sessionManager([AFHTTPSessionManager manager]).get(^(NSHTTPURLResponse *respnse, id responseObject, NSError *error){
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", responseObject);
        }
    });
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    WGURLSession.request(request).get(^(NSHTTPURLResponse *response, id responseObject, NSError *error){
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", responseObject);
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
