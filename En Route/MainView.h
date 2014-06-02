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

@property (nonatomic, strong)UILabel *lblToolTip;
@property (nonatomic, strong)UIButton *btnBegeleider;
@property (nonatomic, strong)UIButton *btnGroep;

@property (nonatomic, weak) id<MainViewDelegate> delegate;

@end
