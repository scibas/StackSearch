//
//  SearchEngineParametersBuilder.m
//  StackSearch
//
//  Created by Pawel Scibek on 12/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SearchEngineParametersBuilder.h"
#import "SEApiKeys.h"

@implementation SearchEngineParametersBuilder

-(instancetype)init{
    self = [super init];
    if (self) {
        
        //initialize with default value
        _page = 1;
        _pageSize = 30;
        _site = @"stackoverflow";
    }
    return self;
}

-(NSDictionary *)build{
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

    result[SESearchRequestPageParameter] = @(self.page).stringValue;
    result[SESearchRequestPageSizeParameter] = @(self.pageSize).stringValue;
    result[SESearchRequestSiteParameter] = self.site;
    
    if(self.searchPhrase) {
        result[SESearchRequestTitleParameter] = self.searchPhrase;
    }

    return [result copy];
}

-(NSDictionary *)nextPageFromParameters:(NSDictionary *)parameters{
    NSMutableDictionary *newParameters = [parameters mutableCopy];
    
    //increase page number
    NSNumber *currentPage = newParameters[SESearchRequestPageParameter];
    newParameters[SESearchRequestPageParameter] = @(currentPage.integerValue + 1);

    return [newParameters copy];
}

@end
