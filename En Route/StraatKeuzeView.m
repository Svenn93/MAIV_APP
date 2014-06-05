//
//  StraatKeuzeView.m
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "StraatKeuzeView.h"
#import "UIView+EnRoute.h"
#import "UIColor+EnRoute.h"

@implementation StraatKeuzeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"straatkeuzeview");
        [self fixTitleBar];
        [self setBackgroundColor:[UIColor redColor]];
        self.activIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activIndicator.center = CGPointMake(frame.size.width / 2.0, 100);
        [self addSubview: self.activIndicator];
        [self.activIndicator startAnimating];
        [self setBackgroundColor:[UIColor paleBackgroundColor]];
        
        UIImage *image = [UIImage imageNamed:@"kaartman"];
        self.bgView = [[UIImageView alloc]initWithImage:image];
        [self.bgView setFrame:CGRectMake((frame.size.width - image.size.width)/2, frame.size.height - image.size.height - 64, image.size.width, image.size.height)];
        [self addSubview:self.bgView];
    }
    return self;
}

- (void)buildWithArray:(NSMutableArray *)array
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 235)];
    [self addSubview:scrollView];
    [self sendSubviewToBack:scrollView];
    [self.activIndicator stopAnimating];
    int ypos = 20;
    for(StraatData *straatdata in array)
    {
        
        UIImage *image = [UIImage imageNamed:@"straatbord"];
        UIButton *straatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [straatBtn setBackgroundImage:image forState:UIControlStateNormal];
        [straatBtn setFrame:CGRectMake((frame.size.width - image.size.width)/2, ypos, image.size.width, image.size.height)];
        [straatBtn setTitle:straatdata.straatnaam forState:UIControlStateNormal];
        [straatBtn.titleLabel setFont:[UIFont fontWithName:@"HalloSans" size:25]];
        
        [scrollView addSubview:straatBtn];
        ypos += 76;
    }
    
    [scrollView setContentSize:(CGSizeMake(320, ypos))];

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
