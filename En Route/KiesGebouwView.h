//
//  KiesGebouwView.h
//  En Route
//
//  Created by Sven Lombaert on 12/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClipView.h"
#import "KiesGebouwViewDelegate.h"

@interface KiesGebouwView : UIView
@property (nonatomic, strong)UIScrollView *scrollview;
@property (nonatomic, strong)ClipView *clipview;
@property (nonatomic, strong)NSMutableArray *arrOutlines;
@property (nonatomic, strong)UIButton *btnKies;
- (instancetype)initWithFrame:(CGRect)frame andOutlines:(NSMutableArray *)outlines;
- (void)enableButton;
@property (nonatomic, weak) id<KiesGebouwViewDelegate> delegate;

@end
