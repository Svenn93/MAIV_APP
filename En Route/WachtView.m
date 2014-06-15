//
//  WachtView.m
//  En Route
//
//  Created by Sven Lombaert on 11/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "WachtView.h"
#import "UIColor+EnRoute.h"
#import "UIView+EnRoute.h"

@implementation WachtView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self fixTitleBar];
        [self setBackgroundColor:[UIColor paleBackgroundColor]];
        
        UIImage *bgImage = [UIImage imageNamed:@"wachten"];
        UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
        [bgView setFrame:CGRectMake((frame.size.width - bgImage.size.width)/2, 25, bgImage.size.width, bgImage.size.height)];
        [self addSubview:bgView];
        
        UIImage *tellerImage = [UIImage imageNamed:@"tellerBg"];
        self.btnTeller = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnTeller setBackgroundImage:tellerImage forState:UIControlStateNormal];
        [self.btnTeller setBackgroundImage:tellerImage forState:UIControlStateDisabled];
        [self.btnTeller setFrame:CGRectMake((frame.size.width - tellerImage.size.width)/2, 400, tellerImage.size.width, tellerImage.size.height)];
        [self.btnTeller setTitle:@"even wachten..." forState:UIControlStateDisabled];
        [self.btnTeller.titleLabel setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        [self.btnTeller setEnabled:NO];
        [self.btnTeller setAlpha:1];
        [self addSubview:self.btnTeller];
        
        self.lbltooltip = [[UILabel alloc]initWithFrame:CGRectMake(0, 445, frame.size.width, 50)];
        [self.lbltooltip setText:@"wanneer je groep volledig\n is kan je verder"];
        self.lbltooltip.lineBreakMode = NSLineBreakByWordWrapping;
        self.lbltooltip.numberOfLines = 0;
        [self.lbltooltip setFont:[UIFont fontWithName:@"HalloSans" size:20]];
        self.lbltooltip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lbltooltip];
        
        self.aantalSec = 6;
        self.timerIsRunning = false;
    }
    return self;
}

- (void)updateAantalDeelnemers:(int)deelnemers withMaxDeelnemers:(int)deelnemers_max
{
    [self.btnTeller setTitle:[NSString stringWithFormat:@"%d/%d deelnemers", deelnemers, deelnemers_max] forState:UIControlStateDisabled];
    
    NSLog(@"UPDATE: %d", self.timerIsRunning);
    
    if((deelnemers == deelnemers_max) && !(self.timerIsRunning))
    {
        [self startTimer];
    }else if((deelnemers < deelnemers_max) && (self.timerIsRunning)){
        [self stopTimer];
    }
}

- (void)startTimer
{
    self.timerIsRunning = true;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    self.timerIsRunning = false;
    [self.timer invalidate];
    self.aantalSec = 6;
    [self.lbltooltip setText:@"wanneer je groep volledig\n is kan je verder"];
    
}

- (void)onTick:(id)sender
{
    NSLog(@"AFTELLEN!!!");
    if(self.aantalSec == 3)
    {
        [self.delegate timerReachedThreeSeconds];
    }
    
    if(self.aantalSec == 0)
    {
        [self.timer invalidate];
        [self.delegate timerReachedNilSeconds];
    }
    
    [self.lbltooltip setText:[NSString stringWithFormat:@"Je groep is vol!\n Je gaat door in %d", self.aantalSec]];
    self.aantalSec--;
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
