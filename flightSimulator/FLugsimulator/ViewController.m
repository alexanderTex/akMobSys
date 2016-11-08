//
//  ViewController.m
//  FLugsimulator
//
//  Created by  on 25.10.16.
//  Copyright © 2016 a. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Die Grafik des Flugzeuges
@property (weak, nonatomic) IBOutlet UIImageView *airplane;


@property (weak, nonatomic) IBOutlet UIImageView *cloud;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 
 */
- (IBAction)MovePlane:(UISlider *)sender {
    
    // Der Wert es UISlieder Objektes
    float sliderValue = sender.value;
    
    // Ausgabe
    NSLog(@"SliderValue : %f", sliderValue);
    
    // Die Bildmitte des Flugzeugbildes
    CGPoint airplaneCenter = self.airplane.center;
    
    // Die Bildhaelfte
    CGFloat airplaneHalfWidth = self.airplane.bounds.size.width / 2;
    
    // Bildschirm groesse
    CGRect screenRec = [[UIScreen mainScreen] bounds];
    
    // Haelfte des Bildschirms
    CGFloat screenWidh = screenRec.size.width;
    
    // Koppeln und ausrichten des Bildes an dem Slider
    // sliderValue liegt zwischen 0 und 1.
    // Durch den Term (1 - (2 * sliderValue)) wird der Wert negiert und man gelangt in den negativen Bereicht
    // Bsp.:
    airplaneCenter.x = sliderValue * screenWidh + (airplaneHalfWidth * (1 - (2* sliderValue)));
    
    self.airplane.center = airplaneCenter;
    
    
    
}

@end
