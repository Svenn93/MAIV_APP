//
//  MainView.h
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewDelegate.h"

@interface MainView : UIView

@property (nonatomic, strong)UIImageView *logoView;
@property (nonatomic, strong)UIImageView *groepView;
@property (nonatomic, strong)UIImageView *stadView;
@property (nonatomic, strong)UIButton *startBtn;

@property (nonatomic, weak) id<MainViewDelegate> delegate;
- (void)doLogoAnimation;
@end
