//
//  StraatKeuzeViewController.m
//  En Route
//
//  Created by Sven Lombaert on 05/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "StraatKeuzeViewController.h"
#import "UIViewController+PortraitViewController.h"
#import "Utils.h"

@interface StraatKeuzeViewController ()

@end

@implementation StraatKeuzeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *titleImage = [UIImage imageNamed:@"kieseenstraat"];
        UIImageView *titleView = [[UIImageView alloc]initWithImage:titleImage];
        [titleView setFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
        self.navigationItem.titleView = titleView;
        
        NSString *path = [NSString stringWithFormat:@"%@straten", apiurl];
        NSURL *url = [NSURL URLWithString:path];
        
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if(connectionError){
                //eventueel errormessage voorzien
                NSLog(@"Er is een error %@", connectionError);
            }else{
                NSLog(@"Tis gelukt");
                NSError *jsonError = nil;
                NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                
                if(jsonError)
                {
                    //eventueel errormessage voorzien
                    NSLog(@"De json is slecht");
                }else{
                    self.arrStraten = [NSMutableArray array];
                    for(NSDictionary *dict in loadedData)
                    {
                        StraatData *straat = [StraatFactory createStraatWithDictionary:dict];
                        [self.arrStraten addObject:straat];
                    }
                    [self buildViewWithArray:self.arrStraten];
                }
            }
        }];
    }
    return self;
}

- (void)buildViewWithArray:(NSMutableArray *)array
{
    NSLog(@"Json ingeladen, build de view");
    if(self.customView)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [(StraatKeuzeView *)self.view buildWithArray:array];
        });
    }
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    self.customView= [[StraatKeuzeView alloc]initWithFrame:frame];
    [self setView:self.customView];
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
