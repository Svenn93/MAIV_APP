//
//  StraatKeuzeView.h
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StraatData.h"
#import "StraatKeuzeViewDelegate.h"

@interface StraatKeuzeView : UIView
@property (nonatomic, strong)UIActivityIndicatorView *activIndicator;
@property (nonatomic, strong)UIImageView *bgView;
- (void)buildWithArray:(NSMutableArray *)array;

@property (nonatomic, weak) id<StraatKeuzeViewDelegate> delegate;
@end
