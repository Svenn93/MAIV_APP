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
#import "GroepViewController.h"

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
    self.customView.delegate = self;
    [self setView:self.customView];
}

- (void)straatSelectedVoorId: (int)straatid andVoorGroep:(int)groepid
{
    NSLog(@"Controller, straat geselecteerd voor groep: %d", groepid);
    NSLog(@"De rootviewcontroller: %@", self.navigationController.viewControllers[0]);
    MainViewController *rootVC = self.navigationController.viewControllers[0];
    NSManagedObjectContext *context = rootVC.context;
    
    //checken of er al een gebouw is
    NSArray *gebouwen = [self fetchAllBuildingsForContext:context];
    
    if([gebouwen count] == 0)
    {
        //er is er nog geen, entity aanmaken
        Gebouw *gebouwData = [NSEntityDescription insertNewObjectForEntityForName:@"Gebouw" inManagedObjectContext:context];
        NSLog(@"Het gebouw: %@", gebouwData);
        gebouwData.groep_id = [NSNumber numberWithInt:groepid];
        
        NSError *error = nil;
        
        if( [rootVC.context save:&error] ){
            NSLog(@"[StraatViewKeuzeController] Saved to core data");
        }else{
            NSLog(@"[StraatViewKeuzeController] Error saving to core data %@",
                  error.debugDescription);
        }
    }else{
        //er is er al een, entity updaten
        Gebouw *gebouwData = [gebouwen objectAtIndex:0];
        gebouwData.groep_id = [NSNumber numberWithInt:groepid];
        gebouwData.straat_id = [NSNumber numberWithInt:straatid];
        
    }
    
    GroepViewController *groepVC = [[GroepViewController alloc]initWithGroep:groepid andStraatid:straatid];
    [self.navigationController pushViewController:groepVC animated:YES];
}

- (NSArray *)fetchAllBuildingsForContext:(NSManagedObjectContext*)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Gebouw"];
    NSSortDescriptor *sorting = [NSSortDescriptor
                                 sortDescriptorWithKey:@"groep_id" ascending:YES];
    request.sortDescriptors = @[sorting];
    NSLog(@"De gebouwen:  %@", request);
    
    NSError *error2 = nil;
    NSArray *results = [context executeFetchRequest:request error:&error2];
    
    if( !results ){
        NSLog(@"Error fetchingbuildings - %@", [error2 debugDescription]);
    }else{
        NSLog(@"Joepie joepie jee, we hebben een aantal gebouw(en): %lu", (unsigned long)[results count]);
        return results;
    }
    
    return [NSArray array];
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
