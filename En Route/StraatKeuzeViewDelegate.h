//
//  StraatKeuzeViewDelegate.h
//  En Route
//
//  Created by Sven Lombaert on 09/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StraatKeuzeViewDelegate <NSObject>
@required
- (void)straatSelectedVoorId: (int)straatid andVoorGroep:(int)groepid;
@end
