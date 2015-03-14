//
//  SubtitleStyleCell+SEQuestion.m
//  StackSearch
//
//  Created by Pawel Scibek on 14/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SubtitleStyleCell+SEQuestion.h"
#import "UIImageView+AFNetworking.h"
#import "SEQuestion.h"
#import "SEUser.h"

@implementation SubtitleStyleCell (SEQuestion)

-(void)setupCellWithQuestion:(SEQuestion *)question{

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *tags = [question.tags componentsJoinedByString:@", "];
    
    self.textLabel.text = question.questionTitle;
    self.detailTextLabel.text = [@"Tags: " stringByAppendingString: tags];
    
    [self.imageView setImageWithURL:question.questionOwner.userProfileImage placeholderImage:[UIImage imageNamed:@"defaultUserAvatar"]];
}

@end
