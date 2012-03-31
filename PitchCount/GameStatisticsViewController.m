//
//  GameStatistictsViewControllerViewController.m
//  PitchCount
//
//  Created by Claude Keswani on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameStatisticsViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation GameStatisticsViewController

@synthesize gameDate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

-(void) configureCell:(UITableViewCell *)theCell withIndexPath:(NSIndexPath *)indexPath {
    UILabel *pitcherLabel = (UILabel *)[theCell viewWithTag:1];
    UILabel *inningsPitchedLabel = (UILabel *)[theCell viewWithTag:2];
    UILabel *totalLabel = (UILabel *)[theCell viewWithTag:3];
    UILabel *strikesLabel = (UILabel *)[theCell viewWithTag:4];
    UILabel *strikePercentLabel = (UILabel *)[theCell viewWithTag:5];
    Game *theGame = [dataSource objectAtIndex:indexPath.row];
    pitcherLabel.text = [NSString stringWithFormat:@"%@ %@", theGame.pitcher.firstName, theGame.pitcher.lastName];
    
    inningsPitchedLabel.text = [NSString stringWithFormat:@"%@", theGame.innings];
    
    
    
    totalLabel.text = [NSString stringWithFormat:@"%d", [theGame.balls intValue] + [theGame.strikes intValue]];
    
    strikesLabel.text = [NSString stringWithFormat:@"%d", [theGame.strikes intValue]];
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterPercentStyle];
    
    float balls = [theGame.balls floatValue];
    float strikes = [theGame.strikes floatValue];
    float perc = strikes / (strikes + balls);
    strikePercentLabel.text = [number stringFromNumber:[NSNumber numberWithFloat:perc]];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *theView = [super tableView:tableView viewForHeaderInSection:section];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/YY"];
    UILabel *theLabel = (UILabel *)[theView viewWithTag:13];
    theLabel.text =[dateFormat stringFromDate:gameDate];
    theLabel = (UILabel *)[theView viewWithTag:14];
    theLabel.text = @"Pitcher";
    return theView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
