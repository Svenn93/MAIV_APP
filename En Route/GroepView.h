//
//  GroepView.h
//  En Route
//
//  Created by Sven Lombaert on 09/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroepViewDelegate.h"

@interface GroepView : UIView
@property (nonatomic)int groepid;
@property (nonatomic, strong)UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *arrIndicators;
-(void)buildViewWithGebouwenAlsGroepen:(NSMutableArray *)arrGroepen;
@property (nonatomic, weak) id<GroepViewDelegate> delegate;
@end
