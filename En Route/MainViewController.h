//
//  MainViewController.h
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"

@interface MainViewController : UIViewController<MainViewDelegate>
@property (nonatomic, strong)NSManagedObjectContext *context;

- (instancetype)initWithContext:(NSManagedObjectContext *)context;
@end
