//
//  GroepViewController.h
//  En Route
//
//  Created by Sven Lombaert on 09/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroepView.h"

@interface GroepViewController : UIViewController<GroepViewDelegate>
@property (nonatomic)int groepid;
@property (nonatomic)int straatid;
@property (nonatomic, strong)GroepView *customview;
@property (nonatomic, strong)NSMutableArray *arrGebouwen;
-(instancetype)initWithGroep:(int)groepid andStraatid:(int)straatid;
@property (nonatomic)int aantaldeelnemers;
@end
