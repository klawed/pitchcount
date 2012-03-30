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

@synthesize gameDate, allGames;

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
    return [allGames count];
}

-(void) configureCell:(UITableViewCell *)theCell withIndexPath:(NSIndexPath *)indexPath {
    UILabel *pitcherLabel = (UILabel *)[theCell viewWithTag:1];
    UILabel *inningsPitchedLabel = (UILabel *)[theCell viewWithTag:2];
    UILabel *totalLabel = (UILabel *)[theCell viewWithTag:3];
    UILabel *strikesLabel = (UILabel *)[theCell viewWithTag:4];
    UILabel *strikePercentLabel = (UILabel *)[theCell viewWithTag:5];
    Game *theGame = [allGames objectAtIndex:indexPath.row];
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
    UIView * theView;
    if (section == 0) {
        NSArray *niblets = [[NSBundle mainBundle] loadNibNamed:@"PitcherStatsHeader" owner:self options:NULL];
        theView = (UIView *)[niblets objectAtIndex:0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/YY"];

        UILabel *theLabel = (UILabel *)[theView viewWithTag:13];
        theLabel.text =[dateFormat stringFromDate:gameDate];
        //[v.layer setCornerRadius:15.0f];
        //[[theView viewWithTag:1].layer setCornerRadius:10.0f];
        UIView *pitcherName = [theView viewWithTag:1];
        // Create the path (with only the top-left corner rounded)
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:pitcherName.bounds 
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(10.0, 10.0)];
        
        // Create the shape layer and set its path
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = pitcherName.bounds;
        maskLayer.path = maskPath.CGPath;
        
        UILabel *pitcherLabel = (UILabel *)[theView viewWithTag:14];
        pitcherLabel.text = @"Pitcher";
        // Set the newly created shape layer as the mask for the image view's layer
        pitcherName.layer.mask = maskLayer;
        
        UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapped)];
        [theView addGestureRecognizer:tp];
        
    }
    return theView;
}


 -(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
     NSArray *niblets = [[NSBundle mainBundle] loadNibNamed:@"PitcherStatsFooter" owner:self options:NULL];
     UIView *theView = (UIView *)[niblets objectAtIndex:0];
     UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:theView.bounds 
                                                   byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                         cornerRadii:CGSizeMake(10.0, 10.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = theView.bounds;
    maskLayer.path = maskPath.CGPath;
    theView.layer.mask = maskLayer;
    
     UILabel *ipTotalLabel = (UILabel *)[theView viewWithTag:2];
     UILabel *totalTotalLabel = (UILabel *)[theView viewWithTag:3];
     UILabel *strikesTotalLabel = (UILabel *)[theView viewWithTag:4];
     UILabel *percentTotal =(UILabel *)[theView viewWithTag:5];

     
     return theView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

-(void) headerTapped {
    [self dismissModalViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? 145: 0;
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
