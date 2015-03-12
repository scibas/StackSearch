//
//  SEQuestionTest.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SEQuestion.h"
#import "SEUser.h"
#import "SEApiKeys.h"

@interface SEQuestionTest : XCTestCase
@end

@implementation SEQuestionTest

- (void)testParsingFromNonEmptyDictionary {

    NSString *userName = @"test user name";
    NSString *userProfileImage = @"https://www.gravatar.com/avatar/1c226a1ecd0dcbd4ecdf1db95b87acb4?s=128&d=identicon&r=PG";
    NSDictionary *userInputDictionary = @{SEUserNameKey: userName, SEUserProfileImageUrl: userProfileImage};
    
    BOOL isAnswered = YES;
    NSString *questionTitle = @"some test title";
    
    NSDictionary *questionInputDictionary = @{SEQuestionTitle: questionTitle,
                                              SEQuestionIsAnsweredKey: @(isAnswered),
                                              SEQuestionOwnerKey: userInputDictionary};
    
    SEQuestion *sut = [[SEQuestion alloc]  initWithDictionary:questionInputDictionary];

    XCTAssertTrue([questionTitle isEqualToString: sut.questionTitle]);
    XCTAssertEqual(sut.isAnswered, isAnswered);
    XCTAssertTrue([userName isEqualToString:sut.questionOwner.displayName]);
    XCTAssertTrue([userProfileImage isEqualToString:sut.questionOwner.userProfileImage.description]);
}

@end
