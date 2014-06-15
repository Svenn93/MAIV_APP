//
//  WachtView.h
//  En Route
//
//  Created by Sven Lombaert on 11/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WachtViewDelegate.h"

@interface WachtView : UIView
- (void)updateAantalDeelnemers:(int)deelnemers withMaxDeelnemers:(int)deelnemers_max;
@property (nonatomic, strong) UILabel *lbltooltip;
@property (nonatomic, strong) UIButton *btnTeller;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic)int aantalSec;
@property (nonatomic)BOOL timerIsRunning;
@property (nonatomic, weak) id<WachtViewDelegate> delegate;
@end
