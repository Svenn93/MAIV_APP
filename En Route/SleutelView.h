//
//  SleutelView.h
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SleutelViewDelegate.h"

@interface SleutelView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UIImageView *ivSleutel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, weak) id<SleutelViewDelegate> delegate;

@end
