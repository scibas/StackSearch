//
//  SEResponseTest.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SEApiKeys.h"
#import "SEResponse.h"
#import "SEQuestion.h"
#import "SEUser.h"

@interface SEResponseTest : XCTestCase

@end

@implementation SEResponseTest{
    NSDictionary *_responseDictionary;
    
    NSInteger _error_id;
    NSString *_error_message;
    NSString *_error_name;
    
    NSInteger _quota_max;
    NSInteger _quota_remaining;
    
    BOOL _has_more;
    
    NSString *_firstQuestionTitle;
    NSString *_secondQuestionTitle;
}

-(void)setUp{
    [super setUp];
    
    _error_id = 1234;
    _error_message = @"test error message";
    _error_name = @"test error name";
    
    _quota_max = 9876;
    _quota_remaining = 91;
    
    _has_more = YES;
    
    _firstQuestionTitle = @"Title_1";
    _secondQuestionTitle = @"Title_2";
    
    _responseDictionary = @{SEResponseErrorIdKey: @(_error_id),
                            SEResponseErrorMessageKey: _error_message,
                            SEResponseErrorNameKey : _error_name,
                            SEResponseQuotaMaxKey: @(_quota_max),
                            SEResponseQuotaRemainingKey: @(_quota_remaining),
                            SEResponseHasMoreKey: @(_has_more),
                            SEResponseItemsKey: @[@{SEQuestionTitle: _firstQuestionTitle}, @{SEQuestionTitle: _secondQuestionTitle}]
                            };
    
}

-(void)tearDown{
    [super tearDown];
    _responseDictionary = nil;
}

- (void)testParsingNonNestedValuesFromNonEmptyDictionary {
    
    SEResponse *sut = [[SEResponse alloc] initWithDictionary:_responseDictionary];

    XCTAssertEqual(sut.error_id, _error_id);
    XCTAssertEqual(sut.error_message, _error_message);
    XCTAssertEqual(sut.error_name, _error_name);
    XCTAssertEqual(sut.quota_max, _quota_max);
    XCTAssertEqual(sut.quota_remaining, _quota_remaining);
}

- (void)testParsingNestedValuesFromNonEmptyDictionary {
    
    SEResponse *sut = [[SEResponse alloc] initWithDictionary:_responseDictionary];
    XCTAssertNotNil(sut.items);
    XCTAssertTrue(sut.items.count == 2);
    XCTAssertTrue([sut.items isKindOfClass:[NSArray class]]);

    XCTAssertEqual(((SEQuestion *)sut.items[0]).questionTitle, _firstQuestionTitle);
    XCTAssertEqual(((SEQuestion *)sut.items[1]).questionTitle, _secondQuestionTitle);
}

- (void)testParsingPerformanceForlargeDateChunk{
    
    NSString *responseDictionaryPath = [[NSBundle mainBundle] pathForResource:@"SEFakeResponse" ofType:@"json"];
    NSData* dictionaryData = [NSData dataWithContentsOfFile:responseDictionaryPath];

    [self measureBlock:^{
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:dictionaryData options:kNilOptions error:nil];
        _responseDictionary = responseDictionary;
    }];

}

@end
