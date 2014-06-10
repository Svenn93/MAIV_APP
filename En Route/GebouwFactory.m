//
//  GebouwFactory.m
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "GebouwFactory.h"

@implementation GebouwFactory
+(GebouwData *)createGebouwWithDictionary:(NSDictionary *)dictionary
{
    GebouwData *gebouwData = [[GebouwData alloc]init];
    gebouwData.gebouw_id = [[dictionary objectForKey:@"gebouw_id"]intValue];
    gebouwData.deelnemers = [[dictionary objectForKey:@"deelnemers"]intValue];
    gebouwData.deelnemers_max = [[dictionary objectForKey:@"deelnemers_max" ]intValue];
    return gebouwData;
}
@end
