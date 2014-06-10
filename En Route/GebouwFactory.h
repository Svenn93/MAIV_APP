//
//  GebouwFactory.h
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GebouwData.h"

@interface GebouwFactory : NSObject
+(GebouwData *)createGebouwWithDictionary:(NSDictionary *)dictionary;
@end
