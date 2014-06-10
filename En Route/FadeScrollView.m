//
//  FadeScrollView.m
//  En Route
//
//  Created by Sven Lombaert on 06/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "FadeScrollView.h"

@implementation FadeScrollView

static float const fadePercentage = 0.05;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSObject * transparent = (NSObject *) [[UIColor colorWithWhite:0 alpha:0] CGColor];
    NSObject * opaque = (NSObject *) [[UIColor colorWithWhite:0 alpha:1] CGColor];
    
    CALayer * maskLayer = [CALayer layer];
    maskLayer.frame = self.bounds;
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(self.bounds.origin.x, 0,
                                     self.bounds.size.width, self.bounds.size.height);
    
    gradientLayer.colors = [NSArray arrayWithObjects: transparent, opaque,
                            opaque, transparent, nil];
    
    // Set percentage of scrollview that fades at top & bottom
    gradientLayer.locations = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0],
                               [NSNumber numberWithFloat:0],
                               [NSNumber numberWithFloat:1.0 - fadePercentage],
                               [NSNumber numberWithFloat:1], nil];
    
    [maskLayer addSublayer:gradientLayer];
    self.layer.mask = maskLayer;
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
