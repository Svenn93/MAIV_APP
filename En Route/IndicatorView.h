//
//  IndictorView.h
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndicatorView : UIView
@property (nonatomic)int maxaantal;
@property (nonatomic)int aantal;
@property (nonatomic)int gebouwid;
@property (nonatomic)CGRect frame;
-(instancetype)initWithFrame:(CGRect)frame andMaxAantal:(int)maxaantal andGebouwid:(int)gebouwid;
@end
