//
//  UIView+EnRoute.m
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "UIView+EnRoute.h"

@implementation UIView (EnRoute)
-(void)fixTitleBar
{
    UIImage *image = [UIImage imageNamed:@"bgNavigationbar"];
    UIImageView *v = [[UIImageView alloc]initWithImage:image];
    [self addSubview:v];
}
@end
