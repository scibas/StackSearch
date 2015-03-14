//
//  SearchEngine.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SearchEngine.h"
#import "AFNetworking.h"
#import "SEResponse.h"

@interface SearchEngine()
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation SearchEngine

-(instancetype)initWithSessionManager:(AFHTTPSessionManager *)sessionManager{
    self = [super init];
    if(self){
        _sessionManager = sessionManager;
    }
    return self;
}

-(NSURLSessionDataTask *)performSearchWithParameters:(NSDictionary *)requestParameters completionBlock:(RequestCompletionBlock)completionBlock{

    NSParameterAssert(self.sessionManager);
    
    return [self.sessionManager GET:@"search"
                         parameters:requestParameters
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                SEResponse *response = [[SEResponse alloc] initWithDictionary:responseObject];
                                if(completionBlock){
                                    completionBlock(response, nil);
                                }
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                if(completionBlock){
                                    completionBlock(nil, error);
                                }
                            }];
}

@end
