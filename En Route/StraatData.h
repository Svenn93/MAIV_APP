//
//  StraatData.h
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StraatData : NSObject
@property (nonatomic) int straatid;
@property (nonatomic) int groepid;
@property (nonatomic, strong)NSString *straatnaam;
@end
