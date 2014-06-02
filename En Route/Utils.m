//
//  Utils.m
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(CGSize) sizeInOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

    CGSize size = [UIScreen mainScreen].bounds.size;
    //omdraaien van width en height als orientatie landscape is
    if (orientation == UIInterfaceOrientationLandscapeLeft )
    {
        size = CGSizeMake(size.height, size.width);
        NSLog(@"LEFT");
    }else if(orientation == UIInterfaceOrientationLandscapeRight){
        size = CGSizeMake(size.height, size.width);
        NSLog(@"RIGHT");
    }
    return size;
}
@end
