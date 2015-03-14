//
//  SEApiKeys.h
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

@import Foundation;

#pragma mark - Response
FOUNDATION_EXPORT NSString *const SEResponseErrorIdKey;
FOUNDATION_EXPORT NSString *const SEResponseErrorMessageKey;
FOUNDATION_EXPORT NSString *const SEResponseErrorNameKey;
FOUNDATION_EXPORT NSString *const SEResponseHasMoreKey;
FOUNDATION_EXPORT NSString *const SEResponseItemsKey;
FOUNDATION_EXPORT NSString *const SEResponseQuotaMaxKey;
FOUNDATION_EXPORT NSString *const SEResponseQuotaRemainingKey;

#pragma mark - Question
FOUNDATION_EXPORT NSString *const SEQuestionOwnerKey;
FOUNDATION_EXPORT NSString *const SEQuestionIsAnsweredKey;
FOUNDATION_EXPORT NSString *const SEQuestionTitle;
FOUNDATION_EXPORT NSString *const SEQuestionTags;
FOUNDATION_EXPORT NSString *const SEQuestionLink;

#pragma mark - User
FOUNDATION_EXPORT NSString *const SEUserNameKey;
FOUNDATION_EXPORT NSString *const SEUserProfileImageUrl;

#pragma mark - Search Sequest Parameters
FOUNDATION_EXPORT NSString *const SESearchRequestPageParameter;
FOUNDATION_EXPORT NSString *const SESearchRequestPageSizeParameter;
FOUNDATION_EXPORT NSString *const SESearchRequestTitleParameter;
FOUNDATION_EXPORT NSString *const SESearchRequestSiteParameter;