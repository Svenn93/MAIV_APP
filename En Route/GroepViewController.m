//
//  GroepViewController.m
//  En Route
//
//  Created by Sven Lombaert on 09/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "GroepViewController.h"
#import "UIViewController+PortraitViewController.h"
#import "Utils.h"
#import "GebouwFactory.h"
#import "WachtViewController.h"
#import "AppDelegate.h"

@interface GroepViewController ()

@end

@implementation GroepViewController

static NSString * const EnRouteServiceType = @"be.enroute.build";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.firstTime = YES;
        // Custom initialization
        [self setUpImageBackButton];
        UIImage *titleImage = [UIImage imageNamed:@"kiesJeGroep"];
        UIImageView *titleView = [[UIImageView alloc]initWithImage:titleImage];
        self.navigationItem.titleView = titleView;
        
        //aantal deelenemers ophalen van de gekozen straat, met het juiste groepid van die straat
        NSString *path = [NSString stringWithFormat:@"%@groep/%d", apiurl, self.groepid];
        NSURL *url = [NSURL URLWithString:path];
        
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
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
                    NSLog(@"Het aantal deelnemers: %@", [dict objectForKey:@"aantal_deelnemers"]);
                    self.aantaldeelnemers = [[dict objectForKey:@"aantal_deelnemers"]intValue];
                    [self getGebouwen];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
                    });
                }
            }
        }];
        


    }
    return self;
}

-(instancetype)initWithGroep:(int)groepid andStraatid:(int)straatid
{
    self.groepid = groepid;
    self.straatid = straatid;
    return [self initWithNibName:nil bundle:nil];
}

- (void)onTick:(id)sender
{
    [self getGebouwen];
}

- (void)getGebouwen
{
    NSLog(@"Get gebouwen wordt opgeroepen: ");
    NSString *path = [NSString stringWithFormat:@"%@gebouwen/%d", apiurl, self.straatid];
    NSURL *url = [NSURL URLWithString:path];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
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
                dispatch_async(dispatch_get_main_queue(), ^{

                    self.arrGebouwen = [NSMutableArray array];
                
                    for (NSDictionary *dict in loadedData) {
                        [self.arrGebouwen addObject:[GebouwFactory createGebouwWithDictionary:dict]];
                    }
                    if(self.firstTime)
                    {
                        [self buildView];
                        self.firstTime = false;
                    }else{
                        [(GroepView *)self.view updateViewsWithArray:self.arrGebouwen];
                    }
                    });
            }
        }
    }];
}

- (void)buildView
{
    NSLog(@"Json ingeladen, build de view");
    //insert gebouwen
    
    if(self.customview)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [(GroepView *)self.view buildViewWithGebouwenAlsGroepen:self.arrGebouwen];
        });
    }
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    self.customview = [[GroepView alloc]initWithFrame:frame];
    self.customview.delegate = self;
    [self setView:self.customview];
}

-(void)gebouwSelectedMetId:(int)gebouwid andCountUp:(BOOL)countup
{
    NSString *path = [NSString stringWithFormat:@"%@gebouw/%d", apiurl, gebouwid];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            //eventueel errormessage voorzien
            NSLog(@"Er is een error %@", connectionError);
        }else{
            NSError *jsonError = nil;
            NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSLog(@"De loadeddata: %@", loadedData);
            
            if(jsonError)
            {
                //eventueel errormessage voorzien
                NSLog(@"De json is slecht");
            }else{
                NSDictionary *dict = [loadedData objectAtIndex:0];
                int deelnemers = [[dict objectForKey:@"deelnemers"]intValue];
                int deelnemers_max = [[dict objectForKey:@"deelnemers_max"]intValue];
                
                NSLog(@"Het gebouw heeft al %d van de %d deelnemers.", deelnemers, deelnemers_max);
                
                if (countup && deelnemers < deelnemers_max) {
                    [self updateAantalDeelnemersInGebouwMetId:gebouwid enAantalDeelnemers:deelnemers+1 enCountUp:YES];
                }else if(!countup){
                    [self updateAantalDeelnemersInGebouwMetId:gebouwid enAantalDeelnemers:deelnemers-1 enCountUp:NO];
                    
                }
            }
        }
    }];
}

-(void)updateAantalDeelnemersInGebouwMetId:(int)gebouwid enAantalDeelnemers:(int)aantalDeelnemers enCountUp:(BOOL)countup
{
    
    NSString *path = [NSString stringWithFormat:@"%@deelnemers/update/%d", apiurl, gebouwid];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"deelnemers=%d", aantalDeelnemers];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            //eventueel errormessage voorzien
            NSLog(@"Er is een error %@", connectionError);
        }else{
            NSError *jsonError = nil;
            NSDictionary *loadedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSLog(@"De loaded data met de responsecode: %@", loadedData);
            if(jsonError)
            {
                
            }else{
                NSString *responseCode = [loadedData valueForKey:@"responsecode"];
                
                if([responseCode isEqualToString:@"ok"])
                {
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                    [appDelegate.mpcHandler setupPeerWithDisplayName:[UIDevice currentDevice].name];
                    if(aantalDeelnemers == 1)
                    {
                        appDelegate.mpcHandler.shouldInvite = YES;
                    }else{
                        appDelegate.mpcHandler.shouldInvite = NO;
                    }

                    //inladen nieuwe vieuwcontroller
                    self.lastChosenGebouwId = gebouwid;
                    
                    if (countup) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            WachtViewController *vc = [[WachtViewController alloc]initMetGebouwid:self.lastChosenGebouwId];
                            [self.navigationController pushViewController:vc animated:YES];
                        });
                    }
                    
                }
            }
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [(GroepView *)self.view setButtonInteractionEnabled];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.firstTime) {

        [self gebouwSelectedMetId:self.lastChosenGebouwId andCountUp:NO];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
    }
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
