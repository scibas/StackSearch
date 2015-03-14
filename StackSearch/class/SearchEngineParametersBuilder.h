//
//  SearchEngineParametersBuilder.h
//  StackSearch
//
//  Created by Pawel Scibek on 12/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

@import Foundation;

@interface SearchEngineParametersBuilder : NSObject

-(NSDictionary *)build;
-(NSDictionary *)nextPageFromParameters:(NSDictionary *)parameters;

@property(nonatomic, copy) NSString *searchPhrase;
@property(nonatomic, assign) NSInteger page;
@property(nonatomic, assign) NSInteger pageSize;
@property(nonatomic, copy) NSString *site;

@end
