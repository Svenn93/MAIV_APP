//
//  Uitleg.h
//  En Route
//
//  Created by Sven Lombaert on 04/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UitlegViewDelegate.h"

@interface UitlegView : UIView
@property (nonatomic, weak) id<UitlegViewDelegate> delegate;

@end
