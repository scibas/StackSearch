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
#import "NSString+HTML.h"

@implementation SEQuestion

-(instancetype)initWithDictionary:(NSDictionary *)questionDictionary{
    self = [super init];
    if(self){
        _isAnswered     = [questionDictionary[SEQuestionIsAnsweredKey] boolValue];
        _questionTitle  = [questionDictionary[SEQuestionTitle] kv_decodeHTMLCharacterEntities];
        _questionOwner  = [[SEUser alloc] initWithDictionary:questionDictionary[SEQuestionOwnerKey]];
        _tags           = questionDictionary[SEQuestionTags];
        _link           = questionDictionary[SEQuestionLink];
    }
    
    return self;
}


@end
