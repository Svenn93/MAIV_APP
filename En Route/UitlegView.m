//
//  Uitleg.m
//  En Route
//
//  Created by Sven Lombaert on 04/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "UitlegView.h"
#import "UIColor+EnRoute.h"
#import "UIView+EnRoute.h"

@implementation UitlegView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor paleBackgroundColor]];
        [self fixTitleBar];
        UIImage *image = [UIImage imageNamed:@"professor"];
        UIImageView *iv = [[UIImageView alloc]initWithImage:image];
        [iv setFrame:CGRectMake((frame.size.width - image.size.width)/2, 23, image.size.width, image.size.height)];
        [self addSubview:iv];
        
        UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 107, frame.size.width, 25)];
        [lbl1 setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        [lbl1 setTextAlignment:NSTextAlignmentCenter];
        [lbl1 setText:@"kies je jullie straat"];
        [self addSubview:lbl1];
        
        UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 246, frame.size.width, 25)];
        [lbl2 setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        [lbl2 setTextAlignment:NSTextAlignmentCenter];
        [lbl2 setText:@"verdelen jullie je in groepjes"];
        [self addSubview:lbl2];
        
        UIImage *btnImage = [UIImage imageNamed:@"btnSnaphet"];
        UIImage *btnImage2 = [UIImage imageNamed:@"btnSnaphet_2"];
        UIButton *btnDoorgaan = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDoorgaan setImage:btnImage forState:UIControlStateNormal];
        [btnDoorgaan setImage:btnImage2 forState:UIControlStateHighlighted];
        [btnDoorgaan setFrame:CGRectMake((frame.size.width-btnImage.size.width)/2, 424, btnImage.size.width, btnImage.size.height)];
        [btnDoorgaan addTarget:self action:@selector(doorgaanButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnDoorgaan];
    }
    return self;
}

-(void)doorgaanButtonTapped:(id)sender
{
    NSLog(@"Doorgaan button tapped");
    [self.delegate doorgaanButtonTapped];
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
