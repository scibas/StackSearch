//
//  SEQuestion.h
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

@import Foundation;

@class SEUser;

@interface SEQuestion : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property(nonatomic, strong, readonly) SEUser *questionOwner;

@property(nonatomic, assign, readonly) BOOL isAnswered;

@property(nonatomic, strong, readonly) NSString *questionTitle;

@end
