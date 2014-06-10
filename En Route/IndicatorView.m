//
//  IndictorView.m
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "IndicatorView.h"
#import "UIColor+EnRoute.h"

@implementation IndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];

        self.aantal = 0;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andMaxAantal:(int)maxaantal andGebouwid:(int)gebouwid
{
    self.maxaantal = maxaantal;
    self.gebouwid = gebouwid;
    return [self initWithFrame:frame];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context,rect);
    int xpos = 1;
    for (int i = 1; i <= self.maxaantal; i++) {
        CGRect borderRect = CGRectMake(xpos, 1.0, 12.0, 12.0);
        CGContextSetRGBStrokeColor(context, 51/255.0f, 188/255.0f, 214/255.0f, 1.0);
        if(i <= self.aantal)
        {
            CGContextSetRGBFillColor(context, 51/255.0f, 188/255.0f, 214/255.0f, 1.0);
        }else{
            CGContextSetRGBFillColor(context, 238/255.0f, 229/255.0f, 204/255.0f, 1.0);
        }
        CGContextSetLineWidth(context, 2.0);
        CGContextFillEllipseInRect (context, borderRect);
        CGContextStrokeEllipseInRect(context, borderRect);
        CGContextFillPath(context);
        xpos += 17;
    }
}

@end
