//
//  SleutelViewController.m
//  En Route
//
//  Created by Sven Lombaert on 02/06/14.
//  Copyright (c) 2014 Sven Lombaert. All rights reserved.
//

#import "SleutelViewController.h"
#import "Utils.h"

@interface SleutelViewController ()

@end

@implementation SleutelViewController

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
    SleutelView *v = [[SleutelView alloc]initWithFrame:frame];
    v.delegate = self;
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

- (void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textfieldEditingChangedWithDirectionUp:(BOOL)up
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    CGSize realWidthHeight = [Utils sizeInOrientation];
    if(up) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view setFrame:CGRectMake(frame.origin.x, frame.origin.y-70, realWidthHeight.width, realWidthHeight.height)];
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view setFrame:CGRectMake(0, 0, realWidthHeight.width, realWidthHeight.height)];
        }];
    }
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
