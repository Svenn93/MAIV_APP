//
//  UIViewController+ImageBackButton.m
//  En Route
//
//  Created by Sven Lombaert on 04/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "UIViewController+PortraitViewController.h"

@implementation UIViewController (PortraitViewController)
- (void)setUpImageBackButton
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 26)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    UIBarButtonItem *barBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(popCurrentViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barBackButtonItem;
    self.navigationItem.hidesBackButton = YES;
}

- (void)popCurrentViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}

@end
