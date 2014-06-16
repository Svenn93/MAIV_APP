//
//  ConnectieViewController.m
//  En Route
//
//  Created by Sven Lombaert on 15/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "ConnectieViewController.h"
#import "ConnectieView.h"

@interface ConnectieViewController ()

@end

@implementation ConnectieViewController

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
    ConnectieView *v = [[ConnectieView alloc]initWithFrame:frame];
    [self setView:v];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(peerDidChangeState:) name:@"peerDidChangeState" object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"peerDidChangeState" object:nil];
}

- (void)peerDidChangeState: (NSNotification *)notification
{
    NSLog(@"De peer did change zijne state ze manneke: %@", notification);
    [(ConnectieView *)self.view updatePeers];
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
