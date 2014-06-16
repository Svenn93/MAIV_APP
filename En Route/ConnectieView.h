//
//  ConnectieView.h
//  En Route
//
//  Created by Sven Lombaert on 15/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectieViewDelegate.h"

@interface ConnectieView : UIView
- (void)updatePeers;
@property (nonatomic, weak) id<ConnectieViewDelegate> delegate;
@end
