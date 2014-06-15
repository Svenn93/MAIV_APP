//
//  WachtViewDelegate.h
//  En Route
//
//  Created by Sven Lombaert on 12/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WachtViewDelegate <NSObject>
@required
-(void)timerReachedThreeSeconds;
-(void)timerReachedNilSeconds;
@end
