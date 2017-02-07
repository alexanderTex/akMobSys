//
//  HighScoreControllerTableViewController.m
//  FlightSim
//
//  Created by  on 31/01/17.
//  Copyright © 2017 a. All rights reserved.
//

#import "HighScoreControllerTableViewController.h"

@interface HighScoreControllerTableViewController ()

@property (strong, nonatomic) NSMutableDictionary *highscore;

@property (strong, nonatomic) NSArray *playerNames;

@end

@implementation HighScoreControllerTableViewController

- (NSArray *)sortKeysByFloatValue:(NSDictionary *)dictionary {
    
    NSArray *sortedKeys = [dictionary keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        float v1 = [obj1 floatValue];
        NSLog(@"%f", v1);
        float v2 = [obj2 floatValue];
        NSLog(@"%f", v2);
        if (v1 > v2)
            return NSOrderedAscending;
        else if (v1 < v2)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }];
    
    NSLog(@"%@" , sortedKeys);
    return sortedKeys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.highscore = [[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"];
    
    //NSLog(@"My Dic is: %@", self.highscore);
    
    self.playerNames = [self sortKeysByFloatValue : self.highscore];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}
*/

// this method tells the UITableView how many rows are present in the specified section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.highscore.allKeys.count;
}


// this method is the one that creates and configures the cell that will be
// displayed at the specified indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    // Configure the cell...
    
    if(cell != nil)
    {
        
        NSString *s = [NSString stringWithFormat:@"%ld.  %@  :  %@", (long)(indexPath.row + 1), [self.playerNames objectAtIndex:indexPath.row] , [self.highscore objectForKey:[self.playerNames objectAtIndex:indexPath.row]] ];
    
        cell.textLabel.text = s;
    }
    else
    {
        NSLog(@"Cell is null");
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
