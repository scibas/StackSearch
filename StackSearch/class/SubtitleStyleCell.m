//
//  SubtitleStyleCell.m
//  StackSearch
//
//  Created by Pawel Scibek on 14/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SubtitleStyleCell.h"

@implementation SubtitleStyleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if(self){
        self.detailTextLabel.textColor = [UIColor grayColor];
    }
    return self;
}

//-(void)prepareForReuse{
//    
//}

@end
