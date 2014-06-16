//
//  KiesGebouwViewController.h
//  En Route
//
//  Created by Sven Lombaert on 12/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KiesGebouwView.h"

@interface KiesGebouwViewController : UIViewController<KiesGebouwViewDelegate>
@property (nonatomic, strong)NSMutableArray *arrOutlines;
@property (nonatomic)int gebouwid;
@property (nonatomic)int outlineid;
- (instancetype)initWithGebouwid:(int)gebouwid;
@end
