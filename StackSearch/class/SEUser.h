//
//  SEUser.h
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

@import Foundation;

@interface SEUser : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)userDictionary;

@property(nonatomic, strong, readonly) NSURL *userProfileImage;
@property(nonatomic, strong, readonly) NSString *displayName;

@end
