//
//  SearchEngine.h
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

@import Foundation;

@class SEResponse;

typedef void (^RequestCompletionBlock)(SEResponse *response, NSError *error);

@class AFHTTPSessionManager;

@interface SearchEngine : NSObject

-(instancetype)initWithSessionManager:(AFHTTPSessionManager *)sessionManager;
-(NSURLSessionDataTask *)performSearchWithParameters:(NSDictionary *)requestParameters completionBlock:(RequestCompletionBlock)completionBlock;


@end
