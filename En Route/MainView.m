//
//  MainView.m
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "MainView.h"
#import "LabelFactory.h"
#import "UIColor+EnRoute.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor paleBackgroundColor]];
        UIImage *logo = [UIImage imageNamed:@"logo"];
        self.logoView = [[UIImageView alloc]initWithImage:logo];
        [self.logoView setFrame:CGRectMake((frame.size.width - logo.size.width)/2, frame.size.height, logo.size.width, logo.size.height)];
        
        UIImage *groepje = [UIImage imageNamed:@"groepje"];
        self.groepView = [[UIImageView alloc]initWithImage:groepje];
        [self.groepView setFrame:CGRectMake((frame.size.width - groepje.size.width)/2, 268, groepje.size.width, groepje.size.height)];
        [self.groepView setAlpha:0];
        
        UIImage *stad = [UIImage imageNamed:@"stad"];
        self.stadView = [[UIImageView alloc]initWithImage:stad];
        [self.stadView setFrame:CGRectMake((frame.size.width - stad.size.width)/2, frame.size.height - stad.size.height -5, stad.size.width, stad.size.height)];
        [self.stadView setAlpha:0];
        
        UIImage *startbtnimg = [UIImage imageNamed:@"startbtn"];
        UIImage *startbtnimg2 = [UIImage imageNamed:@"startbtn_2"];
        self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.startBtn setImage:startbtnimg forState:UIControlStateNormal];
        [self.startBtn setImage:startbtnimg2 forState:UIControlStateHighlighted];
        [self.startBtn setFrame:CGRectMake((frame.size.width - startbtnimg.size.width)/2, 464, startbtnimg.size.width, startbtnimg.size.height)];
        [self.startBtn setAlpha:0];
        
        [self.startBtn addTarget:self action:@selector(startButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.stadView];
        [self addSubview:self.groepView];
        [self addSubview:self.logoView];
        [self addSubview:self.startBtn];
        
        
        //PARALAX EFFECTS
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *verticalMotionEffect2 = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        
        UIInterpolatingMotionEffect *horizontalMotionEffect2 = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect2.minimumRelativeValue = @(-15);
        horizontalMotionEffect2.maximumRelativeValue = @(15);
        verticalMotionEffect2.minimumRelativeValue = @(-15);
        verticalMotionEffect2.maximumRelativeValue = @(15);
        
        UIInterpolatingMotionEffect *verticalMotionEffect3 = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        
        UIInterpolatingMotionEffect *horizontalMotionEffect3 = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect3.minimumRelativeValue = @(-20);
        horizontalMotionEffect3.maximumRelativeValue = @(20);
        verticalMotionEffect3.minimumRelativeValue = @(-20);
        verticalMotionEffect3.maximumRelativeValue = @(20);
        
            UIInterpolatingMotionEffect *verticalMotionEffect4 = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        
        UIInterpolatingMotionEffect *horizontalMotionEffect4 = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect4.minimumRelativeValue = @(-25);
        horizontalMotionEffect4.maximumRelativeValue = @(25);
        verticalMotionEffect4.minimumRelativeValue = @(-25);
        verticalMotionEffect4.maximumRelativeValue = @(25);
        
        UIMotionEffectGroup *motionEffGroup = [UIMotionEffectGroup new];
        motionEffGroup.motionEffects = @[verticalMotionEffect, horizontalMotionEffect];
        
        UIMotionEffectGroup *motionEffGroup2 = [UIMotionEffectGroup new];
        motionEffGroup2.motionEffects = @[verticalMotionEffect2, horizontalMotionEffect2];
        
        UIMotionEffectGroup *motionEffGroup3 = [UIMotionEffectGroup new];
        motionEffGroup3.motionEffects = @[verticalMotionEffect3, horizontalMotionEffect3];
        
        UIMotionEffectGroup *motionEffGroup4 = [UIMotionEffectGroup new];
        motionEffGroup4.motionEffects = @[verticalMotionEffect4, horizontalMotionEffect4];
        
        [self.groepView addMotionEffect:motionEffGroup2];
        [self.logoView addMotionEffect:motionEffGroup4];
        [self.startBtn addMotionEffect:motionEffGroup3];
        [self.stadView addMotionEffect:motionEffGroup];
    }
    return self;
}

- (void)doLogoAnimation
{
    CGRect logoFrame = self.logoView.frame;
    [UIView animateWithDuration:1.5 animations:^{
        [self.logoView setFrame:CGRectMake(logoFrame.origin.x, 50, logoFrame.size.width, logoFrame.size.height)];
    } completion:^(BOOL finished) {
        //fadein
        [UIView animateWithDuration:0.5 animations:^{
            [self.groepView setAlpha:1];
            [self.stadView setAlpha:1];
        }];
        
        [UIView animateWithDuration:0.5 delay:0.2 options:0 animations:^{
            [self.startBtn setAlpha:1];
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)startButtonTapped:(id)sender
{
    [self.delegate startButtonTapped];
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
