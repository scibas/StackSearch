//
//  NSLayoutConstraint+DTOHelpers.m
//  StackSearch
//
//  Created by Pawel Scibek on 18/02/14.
//  Copyright (c) 2014 Pawel Scibek. All rights reserved.
//

#import "NSLayoutConstraint+DTOHelpers.h"

@implementation NSLayoutConstraint (DTOHelpers)

+(instancetype)dto_horizontalyCenterView:(UIView *)view inSuperView:(UIView *)superView{
    return [self dto_horizontalyCenterView:view inSuperView:superView withXOffset:0];
}

+(instancetype)dto_verticalyCenterView:(UIView *)view inSuperView:(UIView *)superView{
    return [self dto_verticalyCenterView:view inSuperView:superView withYOffset:0];
}

+(instancetype)dto_horizontalyCenterView:(UIView *)view inSuperView:(UIView *)superView withXOffset:(CGFloat)xOffset{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superView
                                        attribute:NSLayoutAttributeCenterX
                                       multiplier:1
                                         constant:xOffset];
}

+(instancetype)dto_verticalyCenterView:(UIView *)view inSuperView:(UIView *)superView withYOffset:(CGFloat)yOffset{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeCenterY
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superView
                                        attribute:NSLayoutAttributeCenterY
                                       multiplier:1
                                         constant:yOffset];
}




@end
