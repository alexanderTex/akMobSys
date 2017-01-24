//
//  NavigationControllerViewController.m
//  FlightSim
//
//  Created by  on 24/01/17.
//  Copyright © 2017 a. All rights reserved.
//

#import "NavigationControllerViewController.h"

@interface NavigationControllerViewController ()



@end

@implementation NavigationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"NavCon activated");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"Segue executed");
    
    if([segue.identifier  isEqual: @"StartGame"])
    {
        [self.navigationBar setHidden:YES];
    }
    else if([segue.identifier  isEqual: @"QuitGame"])
    {
        [self.navigationBar setHidden:NO];
        
        // uebergabe von spielergebnis
    }
}


@end
