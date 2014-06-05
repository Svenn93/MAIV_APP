//
//  StraatFactory.m
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "StraatFactory.h"

@implementation StraatFactory
+(StraatData *)createStraatWithDictionary:(NSDictionary *)dictionary
{
    StraatData *straatData = [[StraatData alloc]init];
    straatData.straatid = [[dictionary objectForKey:@"straat_id"]intValue];
    straatData.groepid = [[dictionary objectForKey:@"groep_id"]intValue];
    straatData.straatnaam = [dictionary objectForKey:@"straatnaam"];
    return straatData;
}
@end
