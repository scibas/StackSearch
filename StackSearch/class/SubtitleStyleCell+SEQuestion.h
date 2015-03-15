//
//  SubtitleStyleCell+SEQuestion.h
//  StackSearch
//
//  Created by Pawel Scibek on 14/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SubtitleStyleCell.h"

@class SEQuestion;

@interface SubtitleStyleCell (SEQuestion)

-(void)setupCellWithQuestion:(SEQuestion *)question;

@end
