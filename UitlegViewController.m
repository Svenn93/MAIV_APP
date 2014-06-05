//
//  UitlegViewController.m
//  En Route
//
//  Created by Sven Lombaert on 04/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "UitlegViewController.h"
#import "UIColor+EnRoute.h"
#import "UIViewController+PortraitViewController.h"
#import "StraatKeuzeViewController.h"

@interface UitlegViewController ()

@end

@implementation UitlegViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *titleImage = [UIImage imageNamed:@"voorjebegint"];
        UIImageView *iv = [[UIImageView alloc]initWithImage:titleImage];
        [iv setFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
        self.navigationItem.titleView = iv;
    }
    return self;
}


- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    UitlegView *v = [[UitlegView alloc]initWithFrame:frame];
    v.delegate = self;
    [self setView:v];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpImageBackButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doorgaanButtonTapped
{
    StraatKeuzeViewController *vc = [[StraatKeuzeViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
