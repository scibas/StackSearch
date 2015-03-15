//
//  NSLayoutConstraint+DTOHelpers.h
//  StackSearch
//
//  Created by Pawel Scibek on 18/02/14.
//  Copyright (c) 2014 Pawel Scibek. All rights reserved.
//

@import UIKit;

@interface NSLayoutConstraint (DTOHelpers)

+(instancetype)dto_horizontalyCenterView:(UIView *)view inSuperView:(UIView *)superView;
+(instancetype)dto_verticalyCenterView:(UIView *)view inSuperView:(UIView *)superView;

+(instancetype)dto_horizontalyCenterView:(UIView *)view inSuperView:(UIView *)superView withXOffset:(CGFloat)xOffset;
+(instancetype)dto_verticalyCenterView:(UIView *)view inSuperView:(UIView *)superView withYOffset:(CGFloat)yOffset;


@end

