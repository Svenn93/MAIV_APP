//
//  WachtViewController.h
//  En Route
//
//  Created by Sven Lombaert on 11/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WachtView.h"

@interface WachtViewController : UIViewController<WachtViewDelegate>
@property (nonatomic)int gebouwid;
@property (nonatomic, strong)NSTimer *timer;
- (instancetype)initMetGebouwid:(int)gebouwid;
@end
