//
//  MainView.m
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "MainView.h"
#import "LabelFactory.h"
#import "Utils.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize bestFrame = [Utils sizeInOrientation];
        self.lblToolTip = [LabelFactory createTypewriterLabelWithText:@"Klik links als je een begeleider bent, rechts als je een deelnemer bent."
                           andXPos:bestFrame.width/2 - 110 andYPos:40 andWidth:220 andRotation:0 andFont:@"WhisperADream" andFontSize:22
                           andKerning:[NSNumber numberWithInt:0] andLineHeight:1 andCentered:YES];
        [self addSubview:self.lblToolTip];
        [self setBackgroundColor:[UIColor colorWithRed:238/255.0f green:229/255.0f blue:206/255.f alpha:1]];
        self.lblToolTip.textAlignment = NSTextAlignmentCenter;
        
        UIImage *image = [UIImage imageNamed:@"stad"];
        UIImageView *bgImage = [[UIImageView alloc]initWithImage:image];
        [bgImage setFrame:CGRectMake(0, bestFrame.height - image.size.height - 12, image.size.width, image.size.height)];
        [self addSubview:bgImage];
        
        UIImage *imgKeuze = [UIImage imageNamed:@"keuze"];
        UIImageView *ivKeuze = [[UIImageView alloc]initWithImage:imgKeuze];
        [ivKeuze setFrame:CGRectMake(193, 100, imgKeuze.size.width, imgKeuze.size.height)];
        [self addSubview:ivKeuze];
        
        UIImage *imgBegeleider = [UIImage imageNamed:@"begeleider"];
        UIImage *imgGroep = [UIImage imageNamed:@"groep"];
        
        self.btnBegeleider = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnBegeleider setBackgroundImage:imgBegeleider forState:UIControlStateNormal];
        [self.btnBegeleider setFrame:CGRectMake(25, 51, imgBegeleider.size.width, imgBegeleider.size.height)];
        [self.btnBegeleider addTarget:self action:@selector(begeleiderBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        self.btnGroep = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnGroep setBackgroundImage:imgGroep forState:UIControlStateNormal];
        [self.btnGroep setFrame:CGRectMake(375, 50, imgGroep.size.width, imgGroep.size.height)];
        
        [self addSubview:self.btnBegeleider];
        [self addSubview:self.btnGroep];
        
        NSLog(@"De width van het frame: %f",bestFrame.width);
    }
    return self;
}

- (void)begeleiderBtnTapped:(id)sender
{
    NSLog(@"Button tapped: %@", sender);
    [self.delegate begeleiderButtonTapped];
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
