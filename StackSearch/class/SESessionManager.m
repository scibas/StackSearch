//
//  SESessionManager.m
//  StackSearch
//
//  Created by Pawel Scibek on 11/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SESessionManager.h"

static NSString *const kSOServiceBaseURL = @"http://api.stackexchange.com/2.2";

@implementation SESessionManager

+(instancetype)sharedInstance{
    static SESessionManager *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL *serviceURL = [[NSURL alloc] initWithString:kSOServiceBaseURL];
        __sharedInstance = [[SESessionManager alloc] initWithBaseURL:serviceURL];
        
    });
    
    return __sharedInstance;
}

@end
