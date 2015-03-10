//
//  SEQuestion.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SEQuestion.h"
#import "SEUser.h"
#import "SEApiKeys.h"


@implementation SEQuestion

-(instancetype)initWithDictionary:(NSDictionary *)questionDictionary{
    self = [super init];
    
    if(self){
        _isAnswered = [questionDictionary[SEQuestionIsAnsweredKey] boolValue];
        _questionTitle = questionDictionary[SEQuestionTitle];
        NSDictionary *ownerDictionary = questionDictionary[SEQuestionOwnerKey];
        _questionOwner = [[SEUser alloc] initWithDictionary:ownerDictionary];
    }
    
    return self;
}


@end
