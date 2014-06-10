//
//  Gebouw.h
//  En Route
//
//  Created by Sven Lombaert on 10/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Gebouw : NSManagedObject

@property (nonatomic, retain) NSNumber * groep_id;
@property (nonatomic, retain) NSNumber * straat_id;

@end
