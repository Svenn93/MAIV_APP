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

@interface GroepViewController ()

@end

@implementation GroepViewController

static NSString * const EnRouteServiceType = @"be.enroute.build";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
                NSLog(@"Tis gelukt");
                NSError *jsonError = nil;
                NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                
                NSLog(@"De loadeddata: %@", loadedData);
                
                if(jsonError)
                {
                    //eventueel errormessage voorzien
                    NSLog(@"De json is slecht");
                }else{
                    NSDictionary *dict = [loadedData objectAtIndex:0];
                    NSLog(@"Het aantal deelnemers: %@", [dict objectForKey:@"aantal_deelnemers"]);
                    self.aantaldeelnemers = [[dict objectForKey:@"aantal_deelnemers"]intValue];
                    [self getGebouwen];
                    
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

- (void)getGebouwen
{
    
    NSString *path = [NSString stringWithFormat:@"%@gebouwen/%d", apiurl, self.straatid];
    NSURL *url = [NSURL URLWithString:path];
    
    NSLog(@"het path is: %@", path);

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            //eventueel errormessage voorzien
            NSLog(@"Er is een error %@", connectionError);
        }else{
            NSLog(@"Tis gelukt");
            NSError *jsonError = nil;
            NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            NSLog(@"De loadeddata: %@", loadedData);
            
            if(jsonError)
            {
                //eventueel errormessage voorzien
                NSLog(@"De json is slecht");
            }else{
                self.arrGebouwen = [NSMutableArray array];
                
                for (NSDictionary *dict in loadedData) {
                    [self.arrGebouwen addObject:[GebouwFactory createGebouwWithDictionary:dict]];
                }
                [self buildView];
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

-(void) gebouwSelectedMetId:(int)gebouwid
{
    /*NSString *path = [NSString stringWithFormat:@"%@deelnemers/", apiurl];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[NSString stringWithFormat:@"gebouwid=%d&deelnemers=%d", gebouwid]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            //eventueel errormessage voorzien
            NSLog(@"Er is een error %@", connectionError);
        }else{
            NSLog(@"Tis gelukt");
            NSError *jsonError = nil;
            NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            NSLog(@"De loadeddata: %@", loadedData);
            
            if(jsonError)
            {
                //eventueel errormessage voorzien
                NSLog(@"De json is slecht");
            }else{
                NSDictionary *dict = [loadedData objectAtIndex:0];
                NSLog(@"Het aantal deelnemers: %@", [dict objectForKey:@"aantal_deelnemers"]);
                self.aantaldeelnemers = [[dict objectForKey:@"aantal_deelnemers"]intValue];
                [self getGebouwen];
                
            }
        }
    }];*/

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
