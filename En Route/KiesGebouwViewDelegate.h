//
//  KiesGebouwViewDelegate.h
//  En Route
//
//  Created by Sven Lombaert on 16/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KiesGebouwViewDelegate <NSObject>
@required
- (void)outlineGekozen:(int)outlineid;
@end
