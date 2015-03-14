//
//  SEApiKeys.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SEApiKeys.h"

#pragma mark - Response
NSString *const SEResponseErrorIdKey            = @"error_id";
NSString *const SEResponseErrorMessageKey       = @"error_message";
NSString *const SEResponseErrorNameKey          = @"error_name";
NSString *const SEResponseHasMoreKey            = @"has_more";
NSString *const SEResponseItemsKey              = @"items";
NSString *const SEResponseQuotaMaxKey           = @"quota_max";
NSString *const SEResponseQuotaRemainingKey     = @"quota_remaining";

#pragma mark - Question
NSString *const SEQuestionOwnerKey              = @"owner";
NSString *const SEQuestionIsAnsweredKey         = @"is_answered";
NSString *const SEQuestionTitle                 = @"title";
NSString *const SEQuestionTags                  = @"tags";

#pragma mark - User
NSString *const SEUserNameKey                   = @"display_name";
NSString *const SEUserProfileImageUrl           = @"profile_image";

#pragma mark - Search Request Parameters
NSString *const SESearchRequestPageParameter    = @"page";
NSString *const SESearchRequestPageSizeParameter = @"pagesize";
NSString *const SESearchRequestTitleParameter   = @"intitle";
NSString *const SESearchRequestSiteParameter    = @"site";
