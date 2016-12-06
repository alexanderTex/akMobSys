//
//  ViewController.m
//  FlightSim
//
//  Created by  on 25/10/16.
//  Copyright © 2016 a. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//airplane image property
@property (weak, nonatomic) IBOutlet UIImageView *airplane;

@property (strong, nonatomic) NSMutableArray* clouds;

@property (strong, nonatomic) UIImage *cloud;
@property (strong, nonatomic) NSTimer *gametimer;
@property (strong, nonatomic) UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //self.blueView = [self SpawnCloudAt : ([[UIScreen mainScreen] bounds].size.width/2)];
    
    self.clouds = [NSMutableArray arrayWithCapacity:10];
    
    //[self.clouds addObject:self.blueView];
    
    
    self.gametimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(callBack) userInfo:nil repeats:YES];
    
}

- (UIView *)SpawnCloudAt: (int) xpos{
    
    UIView *redView;
    
    CGRect blueFrame = CGRectMake( xpos - 50, -100, 100, 100);
    
    redView = [[UIView alloc]initWithFrame:blueFrame];
    
    redView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:redView];
    
    
    
    self.cloud = [UIImage imageNamed:@"wolken.png"];
    
    UIImageView *cloudView = [[UIImageView alloc] initWithImage:self.cloud];
    
    [redView addSubview:cloudView];
    
    CGRect cloudViewImageFrame = cloudView.frame;
    
    cloudViewImageFrame.size.width = 100;
    cloudViewImageFrame.size.height = 100;
    
    cloudView.frame = cloudViewImageFrame;
    
    return redView;
}

- (void)callBack{
    static float planespeed = 847;
    
    static int collisionLastFrame = -1;
    
    static int count = 0;
    static int enemyCount = 0;
    static int spawnMax = 3;
    
    float momentum = planespeed / 800;
    
    if( count % 900 == 0 && enemyCount < spawnMax)
    {
        int newSpawn = arc4random_uniform([[UIScreen mainScreen] bounds].size.width);
        
        [self.clouds addObject: [self SpawnCloudAt: newSpawn]];
        enemyCount = (int)self.clouds.count;
    }
    
    bool alreadyCollided = false;
    int currentCollision = -1;
    
    for(int i = 0; i < self.clouds.count; i++)
    {
        UIView *currentView = [self.clouds objectAtIndex:i];
        
        CGRect currentRect = currentView.frame;
        
        if(currentRect.origin.y > [[UIScreen mainScreen] bounds].size.height)
        {
            currentRect.origin.y = -100;
            int newSpawn = arc4random_uniform([[UIScreen mainScreen] bounds].size.width);
            currentRect.origin.x = newSpawn;
            if(collisionLastFrame == i)
            {
                collisionLastFrame = -1;
            }
        }
        else
        {
            currentRect.origin.y += momentum;
        }
        
        if( !alreadyCollided && CGRectIntersectsRect( currentRect, self.airplane.frame ))
        {
            currentCollision = i;
            
            if(collisionLastFrame == currentCollision)
            {
                alreadyCollided = true;
            }
        }
        

        
        
        currentView.frame = currentRect;
    }
    
    NSLog(@"%d, %i", currentCollision, collisionLastFrame);
    
    
    
    if(currentCollision != collisionLastFrame && currentCollision >= 0){
        NSLog(@"COLLISION");
        
        planespeed -= (planespeed * 0.12);
        NSLog(@"%f", planespeed);
        
    }
    
    collisionLastFrame = currentCollision;
    
    
    count++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Move Plane Action, connected to slider changed event
- (IBAction)MovePlane:(UISlider *)sender {
    
    // save slidervalue
    float slidervalue = sender.value;
    
    // half of the airplane width
    CGFloat plainrad = self.airplane.bounds.size.width / 2;
    
    // screen Rect
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // screen width
    CGFloat screenWidth = screenRect.size.width;
    
    // half of the screen width
    CGFloat halfScreenWidth =screenWidth / 2;
    
    // center point of the airplane image
    CGPoint airpCenter = self.airplane.center;
    
    // moves the airplane image to a new x value
    // calculates x from the center of the screen + the max extend of the plane movement , times (1 - (2 * slidervalue))
    // which minimun is -1 if slidervalue is 1 and maximum is 1 if slidervalue is 0
    airpCenter.x = halfScreenWidth + (plainrad - halfScreenWidth) * (1 - (2 * slidervalue));
    
    // assigns the new centerpoint to the airplane
    self.airplane.center = airpCenter;
}


@end
