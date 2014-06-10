//
//  StraatKeuzeViewController.h
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StraatFactory.h"
#import "StraatData.h"
#import "StraatKeuzeView.h"
#import "StraatKeuzeViewDelegate.h"
#import "MainViewController.h"
#import "Gebouw.h"

@interface StraatKeuzeViewController : UIViewController<StraatKeuzeViewDelegate>
@property (nonatomic, strong)NSMutableArray *arrStraten;
@property (nonatomic, strong)StraatKeuzeView *customView;

@property (nonatomic, strong) NSManagedObjectContext *context;
@end
