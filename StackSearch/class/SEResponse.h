//
//  SEResponse.h
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEResponse : NSObject

-(instancetype)initWithDictionary:(NSDictionary*)responseDictionary;

@property(nonatomic, assign, readonly) NSInteger error_id;
@property(nonatomic, strong, readonly) NSString *error_message;
@property(nonatomic, strong, readonly) NSString *error_name;

@property(nonatomic, assign, readonly) NSInteger quota_max;
@property(nonatomic, assign, readonly) NSInteger quota_remaining;

@property(nonatomic, assign, readonly) BOOL has_more;
@property(nonatomic, strong, readonly) NSArray *items;

@end
