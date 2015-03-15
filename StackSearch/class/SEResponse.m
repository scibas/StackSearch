//
//  SEResponse.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SEResponse.h"
#import "SEApiKeys.h"
#import "SEQuestion.h"
#import "NSString+HTML.h"

@implementation SEResponse

-(instancetype)initWithDictionary:(NSDictionary *)responseDictionary{
    self = [super init];
    if(self){
        _error_id           = [responseDictionary[SEResponseErrorIdKey] integerValue];
        _error_message      = [responseDictionary[SEResponseErrorMessageKey] kv_decodeHTMLCharacterEntities];
        _error_name         = [responseDictionary[SEResponseErrorNameKey] kv_decodeHTMLCharacterEntities];
        _has_more           = [responseDictionary[SEResponseHasMoreKey] boolValue];
        _quota_max          = [responseDictionary[SEResponseQuotaMaxKey] integerValue];
        _quota_remaining    = [responseDictionary[SEResponseQuotaRemainingKey] integerValue];
        _items              = [self parseQuestionsFromFromArrayOfDictionaries:responseDictionary[SEResponseItemsKey]];
    }
    
    return self;
}

-(NSArray *)parseQuestionsFromFromArrayOfDictionaries:(NSArray *)items{
    
    NSMutableArray *questionsArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *item in items){
        SEQuestion *question = [[SEQuestion alloc] initWithDictionary:item];
        [questionsArray addObject:question];
    }
    
    return [questionsArray copy];
}

-(void)mergeWithItems:(NSArray *)newItems{

    if(newItems.count > 0){
        _items = [newItems arrayByAddingObjectsFromArray:self.items];
    }
}

@end
