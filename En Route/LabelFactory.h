//
//  LabelFactory.h
//  100jaargeleden
//
//  Created by Sven Lombaert on 27/03/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelFactory : NSObject
+ (UILabel *)createLabelWithText: (NSString*)text andXPos: (double)xpos andYPos: (double)ypos andWidth: (float)width andRotation:(double)rotation andFont: (NSString* )fontString andFontSize: (double)fontsize andKerning: (NSNumber *)letterKerning andLineHeight: (int)lineHeight andCentered:(BOOL)centered;
@end
