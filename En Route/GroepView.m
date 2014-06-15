//
//  GroepView.m
//  En Route
//
//  Created by Sven Lombaert on 09/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "GroepView.h"
#import "UIColor+EnRoute.h"
#import "UIView+EnRoute.h"
#import "IndicatorView.h"

@implementation GroepView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@" Normale constructor");
        // Initialization code
        [self setBackgroundColor:[UIColor paleBackgroundColor]];
        [self fixTitleBar];
        
        UIImage *bgImage = [UIImage imageNamed:@"wolken"];
        UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
        [bgView setFrame:CGRectMake(frame.size.width - bgImage.size.width, 30, bgImage.size.width, bgImage.size.height)];
        [self addSubview:bgView];
        
        UIImage *indicatorImage = [UIImage imageNamed:@"stap2"];
        UIImageView *indicatorView = [[UIImageView alloc]initWithImage:indicatorImage];
        [indicatorView setFrame:CGRectMake((frame.size.width - indicatorImage.size.width)/2, 0, indicatorImage.size.width, indicatorImage.size.height)];
        [self addSubview:indicatorView];
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 450)];
        [self addSubview:self.scrollView];
        [self sendSubviewToBack:self.scrollView];
        [self sendSubviewToBack:bgView];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.activityIndicator setFrame:CGRectMake((frame.size.width - self.activityIndicator.frame.size.width)/2, 200, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height)];
        [self.activityIndicator startAnimating];
        [self addSubview:self.activityIndicator];
        
        UIImage *imgGroepje = [UIImage imageNamed:@"groepVuistje"];
        UIImageView *imgGroepView = [[UIImageView alloc]initWithImage:imgGroepje];
        [imgGroepView setFrame:CGRectMake((frame.size.width - imgGroepje.size.width)/2, frame.size.height - imgGroepje.size.height - 64, imgGroepje.size.width, imgGroepje.size.height)];
        [self addSubview:imgGroepView];
        [self setAutoresizesSubviews:NO];

        
    }
    return self;
}

-(void)buildViewWithGebouwenAlsGroepen:(NSMutableArray *)arrGroepen
{
    [self.activityIndicator stopAnimating];
    NSLog(@"[GroepView] arrgroepen: %@", arrGroepen);
    //grid aanmaken
    self.arrIndicators = [NSMutableArray array];
    self.arrButtons = [NSMutableArray array];
    
    int tel = 0;
    int yPos = 60;
    int xPos = 50;
    UIImage *image = [UIImage imageNamed:@"groepButton"];
    
    for (NSDictionary *dict in arrGroepen) {
        
        if(tel%2 == 0){
            xPos = 50;
            if(tel != 0)
            {
                yPos += 50 + image.size.height;
            }
        }else{
            xPos = 200;
        }
        
        UIButton *btnGroep = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnGroep setBackgroundImage:image forState:UIControlStateNormal];
        [btnGroep setFrame:CGRectMake(xPos, yPos, image.size.width, image.size.height)];
        [btnGroep setTag:[[dict valueForKey:@"gebouw_id"]intValue]];
        [btnGroep addTarget:self action:@selector(groupButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnGroep setTitle:[[NSString alloc]initWithFormat:@"Groep %d", tel+1] forState:UIControlStateNormal];
        [btnGroep setTitle:@"volzet" forState:UIControlStateDisabled];
        [btnGroep.titleLabel setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        btnGroep.exclusiveTouch = YES;

        [self.arrButtons addObject:btnGroep];
        [self.scrollView addSubview:btnGroep];
        [self.scrollView setContentSize:(CGSizeMake(320, yPos + 170))];
        
        int aantalDeelnemers = [[dict valueForKey:@"deelnemers_max"]intValue];
        
        IndicatorView *indView = [[IndicatorView alloc]initWithFrame:CGRectMake(xPos, yPos, (16.5*aantalDeelnemers), 14) andMaxAantal:aantalDeelnemers andGebouwid:[[dict valueForKey:@"gebouw_id"]intValue]];
        indView.center = CGPointMake(xPos + image.size.width/2, yPos + 50);
        [self.arrIndicators addObject:indView];
        [self.scrollView addSubview:indView];
        tel++;
    }
    [self updateViewsWithArray:arrGroepen];
}

- (void)updateViewsWithArray:(NSMutableArray *)arrGroepen
{
    for (int i = 0; i < [arrGroepen count]; i++) {
        UIButton *btn = [self.arrButtons objectAtIndex:i];
        IndicatorView *iv =  self.arrIndicators[i];

        if(iv.aantal == iv.maxaantal)
        {
            btn.enabled = false;
            
        }else{
            btn.enabled = true;
        }
        iv.aantal = [[[arrGroepen objectAtIndex:i]valueForKey:@"deelnemers"]intValue];
        [iv setNeedsDisplay];
    }
}

- (void)groupButtonPressed:(id)sender
{
    UIButton *pressedButton = (UIButton *)sender;
    pressedButton.userInteractionEnabled = NO;
    [self.delegate gebouwSelectedMetId:(int)pressedButton.tag andCountUp:YES];
}


-(void)setButtonInteractionEnabled
{
    for (int i = 0; i < [self.arrButtons count]; i++) {
        UIButton *btn = [self.arrButtons objectAtIndex:i];
        btn.userInteractionEnabled = YES;
        }
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
