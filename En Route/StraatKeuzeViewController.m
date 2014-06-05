//
//  StraatKeuzeViewController.m
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "StraatKeuzeViewController.h"
#import "UIViewController+PortraitViewController.h"
#import "StraatKeuzeView.h"

@interface StraatKeuzeViewController ()

@end

@implementation StraatKeuzeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    StraatKeuzeView *v = [[StraatKeuzeView alloc]initWithFrame:frame];
    [self setView:v];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view. 
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setUpImageBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
