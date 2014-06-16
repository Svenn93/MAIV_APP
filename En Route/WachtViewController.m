//
//  WachtViewController.m
//  En Route
//
//  Created by Sven Lombaert on 11/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "WachtViewController.h"
#import "UIViewController+PortraitViewController.h"
#import "Utils.h"
#import "KiesGebouwViewController.h"

@interface WachtViewController ()

@end

@implementation WachtViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setUpImageBackButton];
        UIImage *image = [UIImage imageNamed:@"wachtenTitel"];
        self.navigationItem.titleView = [[UIImageView alloc]initWithImage:image];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
    }
    return self;
}

- (instancetype)initMetGebouwid:(int)gebouwid
{
    self.gebouwid = gebouwid;
    return [self initWithNibName:nil bundle:nil];
}

- (void)updateAantalDeelnemers
{
    NSString *path = [NSString stringWithFormat:@"%@gebouw/%d", apiurl, self.gebouwid];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            //eventueel errormessage voorzien
            NSLog(@"Er is een error %@", connectionError);
        }else{
            NSError *jsonError = nil;
            NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            if(jsonError)
            {
                //eventueel errormessage voorzien
                NSLog(@"De json is slecht");
            }else{
                NSDictionary *dict = [loadedData objectAtIndex:0];
                int deelnemers = [[dict objectForKey:@"deelnemers"]intValue];
                int deelnemers_max = [[dict objectForKey:@"deelnemers_max"]intValue];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [(WachtView *)self.view updateAantalDeelnemers:deelnemers withMaxDeelnemers:deelnemers_max];
                });
            }
        }
    }];
}

- (void)onTick:(id)sender
{
    [self updateAantalDeelnemers];
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    WachtView *v = [[WachtView alloc]initWithFrame:frame];
    v.delegate = self;
    [self setView:v];
}

- (void)timerReachedThreeSeconds
{
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)timerReachedNilSeconds
{
    [self.timer invalidate];
    KiesGebouwViewController *vc = [[KiesGebouwViewController alloc]initWithGebouwid:self.gebouwid];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
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
