//
//  SearchEngineTest.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OHHTTPStubs.h"
#import "SearchEngine.h"
#import "SESessionManager.h"
#import "SEResponse.h"
#import "SEApiKeys.h"

@interface SearchEngineTest : XCTestCase
@end

@implementation SearchEngineTest{
    SearchEngine *_sut;
}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    _sut = nil;
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

- (void)testThatErrorIsReturnedWhenNoNetwork{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSError* notConnectedError = [NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:nil];
        return [OHHTTPStubsResponse responseWithError:notConnectedError];
    }];
     
    XCTestExpectation *expectation = [self expectationWithDescription:@"Completion block will be call after search"];
    
    SESessionManager *sessionManager = [SESessionManager sharedInstance];
    SearchEngine *sut = [[SearchEngine alloc] initWithSessionManager:sessionManager];
    
    __block SEResponse *receivedResponse = nil;
    __block NSError *receivedError = nil;
    [sut performSearchWithParameters:nil completionBlock:^(SEResponse *response, NSError *error) {
        receivedResponse = response;
        receivedError = error;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
        XCTAssertNil(receivedResponse, @"Received response should not be nil");
        XCTAssertNotNil(receivedError, @"Received error should be nil");
    }];

}

- (void)testThatValidResponseArrivedAsSearchResult {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"SEFakeResponse.json",nil)
                                                statusCode:200
                                                   headers:@{@"Content-Type": @"application/json"}];
    }];
    
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Completion block will be call after search"];
    
    SESessionManager *sessionManager = [SESessionManager sharedInstance];
    SearchEngine *sut = [[SearchEngine alloc] initWithSessionManager:sessionManager];
    
    __block SEResponse *receivedResponse = nil;
    __block NSError *receivedError = nil;
    [sut performSearchWithParameters:nil completionBlock:^(SEResponse *response, NSError *error) {
        receivedResponse = response;
        receivedError = error;
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
        XCTAssertNotNil(receivedResponse, @"Received response should not be nil");
        XCTAssertNil(receivedError, @"Received error should be nil");
    }];
}

- (void)testThatSearchPhraseInURLRequestIsValid{
    
    NSString *searchPhrase = @"Some search phrase";
    
    __block NSURL *requestURL;

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        requestURL = request.URL;
        return [[OHHTTPStubsResponse responseWithData:nil statusCode:200 headers:nil] responseTime:1.0];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Completion block will be call after search"];
    
    SESessionManager *sessionManager = [SESessionManager sharedInstance];
    SearchEngine *sut = [[SearchEngine alloc] initWithSessionManager:sessionManager];
    
    [sut performSearchWithParameters:@{SESearchRequestTitleParameter: searchPhrase} completionBlock:^(SEResponse *response, NSError *error) {
        [expectation fulfill];
    }];
    
    
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
        NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:requestURL resolvingAgainstBaseURL:NO];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", SESearchRequestTitleParameter];
        NSURLQueryItem *queryItem = [[urlComponents.queryItems filteredArrayUsingPredicate:predicate] firstObject];
        
        XCTAssertEqualObjects(queryItem.value, searchPhrase);
    }];
}

- (void)testThatNetworkActivityIndicatorTurnsOnWhilePerformingSearch{
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"SEFakeResponse.json",nil)
                                                statusCode:200
                                                   headers:@{@"Content-Type": @"application/json"}] responseTime:1.0];;
    }];
    
    BOOL ntwrkIndVisible = NO;
    ntwrkIndVisible = [[UIApplication sharedApplication] isNetworkActivityIndicatorVisible];
    XCTAssertFalse(ntwrkIndVisible, @"Network inidicator should be hiden initialy");

    SESessionManager *sessionManager = [SESessionManager sharedInstance];
    SearchEngine *sut = [[SearchEngine alloc] initWithSessionManager:sessionManager];

    [sut performSearchWithParameters:nil completionBlock:nil];
    
    [self sleep:0.5];
    ntwrkIndVisible = [[UIApplication sharedApplication] isNetworkActivityIndicatorVisible];
    XCTAssertTrue(ntwrkIndVisible, @"Network indicator should be visible while searching");
    
}

- (void)testThatNetworkActivityIndicatorTurnsOffWhenSearchingEnds{

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [[OHHTTPStubsResponse responseWithData:nil statusCode:200 headers:nil] responseTime:1.0];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Completion block will be call after search"];
    
    SESessionManager *sessionManager = [SESessionManager sharedInstance];
    SearchEngine *sut = [[SearchEngine alloc] initWithSessionManager:sessionManager];
    
    [sut performSearchWithParameters:nil completionBlock:^(SEResponse *response, NSError *error) {
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
        [self sleep:0.5];
        BOOL ntwrkIndVisible = [[UIApplication sharedApplication] isNetworkActivityIndicatorVisible];
        XCTAssertFalse(ntwrkIndVisible, @"Network indicator should be hiden when searching ends");
    }];
    
}

-(void)sleep:(float)sleepTimeInSec{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:sleepTimeInSec];
    
    while ([timeoutDate timeIntervalSinceNow] > 0) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
    }
}

@end
