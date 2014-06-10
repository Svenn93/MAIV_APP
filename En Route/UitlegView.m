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
        
        UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35, frame.size.width, 353)];

        UIImage *imageKader = [UIImage imageNamed:@"kader"];
        UIImageView *ivKader = [[UIImageView alloc]initWithImage:imageKader];
        [ivKader setFrame:CGRectMake((frame.size.width - imageKader.size.width)/2, 13, imageKader.size.width, imageKader.size.height)];
        [self addSubview:ivKader];
        
        UIImage *imageUitleg = [UIImage imageNamed:@"uitleg"];
        UIImageView *ivUitleg = [[UIImageView alloc]initWithImage:imageUitleg];
        [ivUitleg setFrame:CGRectMake((frame.size.width - imageUitleg.size.width)/2, 20, imageUitleg.size.width, imageUitleg.size.height)];
        
        [sv addSubview:ivUitleg];
        
        UIImage *imageProf = [UIImage imageNamed:@"professor"];
        UIImageView *ivProf = [[UIImageView alloc]initWithImage:imageProf];
        [ivProf setFrame:CGRectMake(22, 278, imageProf.size.width, imageProf.size.height)];
        
        UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, frame.size.width, 25)];
        [lbl1 setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        [lbl1 setTextAlignment:NSTextAlignmentCenter];
        [lbl1 setText:@"kies je jullie straat"];
        [sv addSubview:lbl1];
        
        UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 186, frame.size.width, 25)];
        [lbl2 setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        [lbl2 setTextAlignment:NSTextAlignmentCenter];
        [lbl2 setText:@"verdelen jullie je in groepjes"];
        [sv addSubview:lbl2];
        
        UILabel *lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 328, frame.size.width, 25)];
        [lbl3 setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        [lbl3 setTextAlignment:NSTextAlignmentCenter];
        [lbl3 setText:@"kiezen jullie je gebouw"];
        [sv addSubview:lbl3];
        
        UIImage *btnImage = [UIImage imageNamed:@"btnSnaphet"];
        UIImage *btnImage2 = [UIImage imageNamed:@"btnSnaphet_2"];
        UIButton *btnDoorgaan = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDoorgaan setImage:btnImage forState:UIControlStateNormal];
        [btnDoorgaan setImage:btnImage2 forState:UIControlStateHighlighted];
        [btnDoorgaan setFrame:CGRectMake((frame.size.width-btnImage.size.width)/2, 424, btnImage.size.width, btnImage.size.height)];
        [btnDoorgaan addTarget:self action:@selector(doorgaanButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [sv setContentSize:(CGSizeMake(frame.size.width, 500))];

        [self addSubview:sv];
        [self addSubview:ivProf];
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
