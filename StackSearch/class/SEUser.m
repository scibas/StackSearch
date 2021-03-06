//
//  SEUser.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SEUser.h"
#import "SEApiKeys.h"
#import "NSString+HTML.h"

@implementation SEUser

-(instancetype)initWithDictionary:(NSDictionary *)userDictionary{
    self = [super init];
    if(self) {
        _displayName        = [userDictionary[SEUserNameKey] kv_decodeHTMLCharacterEntities];
        _userProfileImage   = [NSURL URLWithString:userDictionary[SEUserProfileImageUrl]];
    }
    return self;
}

@end
