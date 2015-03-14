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

@implementation SEResponse

-(instancetype)initWithDictionary:(NSDictionary *)responseDictionary{
    self = [super init];
    if(self){
        _error_id = [responseDictionary[SEResponseErrorIdKey] integerValue];
        _error_message = responseDictionary[SEResponseErrorMessageKey];
        _error_name = responseDictionary[SEResponseErrorNameKey];
        
        _has_more = [responseDictionary[SEResponseHasMoreKey] boolValue];
        
        _quota_max = [responseDictionary[SEResponseQuotaMaxKey] integerValue];
        _quota_remaining = [responseDictionary[SEResponseQuotaRemainingKey] integerValue];
        
        NSArray *items = responseDictionary[SEResponseItemsKey];
        
        NSMutableArray *itemsTmpArray = [[NSMutableArray alloc]init];
        for (NSDictionary *item in items){
            SEQuestion *question = [[SEQuestion alloc] initWithDictionary:item];
            
            [itemsTmpArray addObject:question];
        }
        
        _items = itemsTmpArray.copy;
    }
    
    return self;
}

-(void)mergeWithItems:(NSArray *)newItems{

    if(newItems.count > 0){
        _items = [newItems arrayByAddingObjectsFromArray:self.items];
    }
}

@end
