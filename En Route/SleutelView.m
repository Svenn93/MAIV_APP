//
//  SleutelView.m
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "SleutelView.h"
#import "Utils.h"
#import "LabelFactory.h"

@implementation SleutelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGSize bestFrame = [Utils sizeInOrientation];
        [self setBackgroundColor:[UIColor colorWithRed:238/255.0f green:229/255.0f blue:206/255.f alpha:1]];
        UIImage *sleutelImg = [UIImage imageNamed:@"paswoord"];
        self.ivSleutel = [[UIImageView alloc]initWithImage:sleutelImg];
        [self.ivSleutel setFrame:CGRectMake((bestFrame.width - sleutelImg.size.width)/2, 60, sleutelImg.size.width, sleutelImg.size.height)];
        [self addSubview:self.ivSleutel];
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(160, 183, 245, 35)];
        self.textfield.delegate = self;
        self.textfield.secureTextEntry = TRUE;
        [self.textfield setTextAlignment:NSTextAlignmentCenter];
        [self.textfield setText:@"00000"];
        [self addSubview:self.textfield];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *backImg = [UIImage imageNamed:@"backbutton"];
        [self.backButton setImage:backImg forState:UIControlStateNormal];
        [self.backButton setFrame:CGRectMake(22, 190, backImg.size.width + 20, backImg.size.height + 20)];
        [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backButton];
        
        UILabel *tooltip = [LabelFactory createLabelWithText:@"voer de begeleider sleutel in" andXPos:568/2 - 85 andYPos:235 andWidth:200 andRotation:0 andFont:@"WhisperADream" andFontSize:20 andKerning:[NSNumber numberWithInt:1] andLineHeight:1 andCentered:YES];
        tooltip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tooltip];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    
    if([touch view] != self.textfield)
    {
        //keyboardje wegdoen, niet in textveld getapped
        [self.textfield endEditing:YES];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    NSString *value = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(newLength >= 5)
    {
        if(![value  isEqual: @"11111"])
        {
            [self errorAnimation];
            [self.textfield setTextColor:[UIColor redColor]];
            NSLog(@"De value: %@", value);
        }else{
            NSLog(@"JUIST");
            self.textfield.text = value;
            self.textfield.enabled = NO;
        }
    }else{
        [self.textfield setTextColor:[UIColor blackColor]];
    }
    
    
    return (newLength > 5) ? NO : YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"yes we zijn aant editten");
    if([textField.text  isEqual: @"00000"])
    {
        [textField setText:@""];
    }
    [self.delegate textfieldEditingChangedWithDirectionUp:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"ah, we zijn klaar");
    [self.delegate textfieldEditingChangedWithDirectionUp:NO];
}

- (void)backButtonTapped:(id)sender
{
    [self.delegate backButtonTapped];
}

-(void)errorAnimation
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(self.textfield.center.x - 5,self.textfield.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(self.textfield.center.x + 5, self.textfield.center.y)]];
    [self.textfield.layer addAnimation:shake forKey:@"position"];
    
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
