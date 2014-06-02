//
//  LabelFactory.m
//  100jaargeleden
//
//  Created by Sven Lombaert on 27/03/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "LabelFactory.h"

@implementation LabelFactory
+ (UILabel *)createTypewriterLabelWithText: (NSString*)text andXPos: (double)xpos andYPos: (double)ypos andWidth: (float)width andRotation:(double)rotation andFont: (NSString* )fontString andFontSize: (double)fontsize andKerning: (NSNumber *)letterKerning andLineHeight: (int)lineHeight andCentered:(BOOL)centered
{
    //attributes aanmaken
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineHeight];
    UIFont *font = [UIFont fontWithName:fontString size:fontsize];
    UIColor *color = [UIColor blackColor];
    NSNumber *kerning = letterKerning;
    
    //dictionary aanmaken met attributes
    NSDictionary *attributes = [[NSDictionary alloc]initWithObjects:[[NSArray alloc]initWithObjects:paragraphStyle, font, color, kerning, nil] forKeys:[[NSArray alloc]initWithObjects:NSParagraphStyleAttributeName, NSFontAttributeName, NSForegroundColorAttributeName, NSKernAttributeName, nil]];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributedString addAttributes:attributes range:NSMakeRange(0, attributedString.string.length)];
    
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    UILabel *lbltext = [[UILabel alloc]initWithFrame:CGRectMake(xpos, ypos, width, ceilf(rect.size.height))];
    lbltext.lineBreakMode = NSLineBreakByWordWrapping;
    if(centered){
       lbltext.textAlignment = NSTextAlignmentCenter;
        NSLog(@"KGOT CENTREREN ZE");
    }else{
        lbltext.textAlignment = NSTextAlignmentLeft;
    }
    lbltext.numberOfLines = 0;
    [lbltext setTextColor:[UIColor blackColor]];
    [lbltext setTransform:CGAffineTransformMakeRotation(rotation*(M_PI/180))];
    lbltext.attributedText = attributedString;
    [lbltext sizeToFit];
    return lbltext;
    
}
@end
