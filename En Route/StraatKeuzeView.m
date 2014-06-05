//
//  StraatKeuzeView.m
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "StraatKeuzeView.h"
#import "UIView+EnRoute.h"

@implementation StraatKeuzeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self fixTitleBar];
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
