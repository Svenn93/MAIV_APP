//
//  GroepViewDelegate.h
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GroepViewDelegate <NSObject>
@required
-(void)gebouwSelectedMetId:(int)gebouwid andCountUp:(BOOL)countup;
@end
