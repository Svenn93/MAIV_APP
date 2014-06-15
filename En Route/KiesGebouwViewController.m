//
//  KiesGebouwViewController.m
//  En Route
//
//  Created by Sven Lombaert on 12/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "KiesGebouwViewController.h"
#import "KiesGebouwView.h"
#import "AppDelegate.h"
#import "ConnectieViewController.h"

@interface KiesGebouwViewController ()

@end

@implementation KiesGebouwViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kiesEenGebouw" ]];
        self.navigationItem.hidesBackButton= YES;
        self.navigationItem.titleView = iv;
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"outlines" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        NSError *error = nil;
        
        self.arrOutlines = [NSMutableArray array];
        NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if( !error ){
            for (NSDictionary *dict in loadedData) {
                [self.arrOutlines addObject:dict];
            }
        }
        
        UIImage *imageConn = [UIImage imageNamed:@"connectie"];
        UIButton *connectieButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imageConn.size.width, imageConn.size.height)];
        [connectieButton setBackgroundImage:imageConn forState:UIControlStateNormal];
        UIBarButtonItem *barconnectieButton = [[UIBarButtonItem alloc] initWithCustomView:connectieButton];
        [connectieButton addTarget:self action:@selector(showConnectionScreen) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = barconnectieButton;
        
    }
    return self;
}

- (void)showConnectionScreen
{
    NSLog(@"SHOW CONNECTION SCREEN");
    ConnectieViewController *connectieVC = [[ConnectieViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:connectieVC animated:YES];
}

- (void)loadView
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *rootVC = [viewControllers objectAtIndex:0];
    NSLog(@"De rootvc: %@", rootVC);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.mpcHandler setupPeerWithDisplayName:[UIDevice currentDevice].name];
    [appDelegate.mpcHandler advertiseSelf:YES];
    [appDelegate.mpcHandler setupSession];
    [appDelegate.mpcHandler setupBrowser];
    CGRect frame = [[UIScreen mainScreen]bounds];
    KiesGebouwView *v = [[KiesGebouwView alloc]initWithFrame:frame andOutlines:self.arrOutlines];
    [self setView:v];
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
