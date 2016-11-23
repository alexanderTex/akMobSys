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

@property (nonatomic, strong) UIImage *cloud;
@property (nonatomic, strong) NSTimer *gametimer;
@property (nonatomic, strong) UIView *blueView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect blueFrame = CGRectMake(10, 10, 300, 400);
    self.blueView = [[UIView alloc] initWithFrame:blueFrame];
    
    // Farbe des Frames festlegen
    self.blueView.backgroundColor = [UIColor greenColor];
    
    // SubView dem RootView zuweisen
    [self.view addSubview:self.blueView];
    
    // Bildbenennung
    self.cloud = [UIImage imageNamed:@"cloud.png"];
    
    // Speicher zuweisen und initialisieren
    UIImageView *cloudView = [[UIImageView alloc] initWithImage:self.cloud];
    
    // Dem SubView einem zusaetzl. SubView zuweisen. Hier des Bildes
    [self.blueView addSubview:cloudView];
    
    // Bildframe erstellen
    CGRect cloudFrame = cloudView.frame;
    // Startpunkt festlegen
    CGPoint startPoint = CGPointMake(50, 150);
    // Startpunkt dem Frame zuweisen
    cloudFrame.origin = startPoint;
    cloudView.frame = cloudFrame;
    
    // Timer
    // = Endlosschleife bis Programm abgebrochen wird oder der Parameter invalidate genutzt wird.
    // callBack ist die Methode, die vom NSTimer immer wieder aufgerufen wird.
    self.gametimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(callBack) userInfo:nil repeats:YES];
}

// Geschwindigkeit des Frames
- (void)callBack {
    static int count = 0;
    // Anzahl der Durchlaefe bis der GameTimer beendet werden soll
    if (count == 60)
        [self.gametimer invalidate];
    
    CGRect blueRect = self.blueView.frame;
    blueRect.origin.y += 1.0;
    self.blueView.frame = blueRect;
    count++;
    
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
