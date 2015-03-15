//
//  SESessionManager.h
//  StackSearch
//
//  Created by Pawel Scibek on 11/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SESessionManager : AFHTTPSessionManager


+(instancetype)sharedInstance;

@end
