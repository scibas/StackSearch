//
//  SEUserTest.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "SEApiKeys.h"
#import "SEUser.h"

@interface SEUserTest : XCTestCase
@end

@implementation SEUserTest

- (void)testParsingFromNonEmptyDictionary {

    NSString *userName = @"test user name";
    NSString *userProfileImage = @"https://www.gravatar.com/avatar/1c226a1ecd0dcbd4ecdf1db95b87acb4?s=128&d=identicon&r=PG";
    
    NSDictionary *inputDictionary = @{SEUserNameKey: userName, SEUserProfileImageUrl: userProfileImage};
    
    SEUser *sut = [[SEUser alloc] initWithDictionary:inputDictionary];
    
    XCTAssertEqual(sut.displayName, userName);
    XCTAssertEqual(sut.userProfileImage.description, userProfileImage);
    
}

@end
