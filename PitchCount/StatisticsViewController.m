    
//
//  SecondViewController.m
//  PitchCount
//
//  Created by Claude Keswani on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatisticsViewController.h"
#define GAMES 0
#define PITCHERS 1

@implementation StatisticsViewController

@synthesize appDelegate, fetchedResultsController, managedObjectContext, titleView;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        appDelegate = [[UIApplication sharedApplication] delegate];
        managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StatisticsTitleView" owner:self options:nil];
    titleView = (UISegmentedControl *)[nib objectAtIndex:0];
    [titleView addTarget:self action:@selector(viewTypeTapped:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = titleView;
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"StatisticsHeaderView" owner:self options:nil];
    tableHeader =(UIView *) [nib objectAtIndex:0];

    //NSError *error = nil;
	/*
     if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
     */
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initGames];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (titleView.selectedSegmentIndex) {
        case GAMES:
            return [gamesByDate count];
            break;
            
            case PITCHERS:
            return [gamesByPitcher count];
        default:
            break;
    }
    return 0;
}

-(int) getTotalPitches:(NSArray *)filtered {
    NSNumber *strikes = [filtered valueForKeyPath:@"@sum.strikes"];
    NSNumber *balls = [filtered valueForKeyPath:@"@sum.balls"];
    int total = [strikes intValue] + [balls intValue];
    return total;
}

-(float) getPercent:(NSArray *)filtered {
    NSNumber *strikes = [filtered valueForKeyPath:@"@sum.strikes"];
    NSNumber *balls = [filtered valueForKeyPath:@"@sum.balls"];
    float percent = [strikes floatValue]/([strikes floatValue] + [balls floatValue]);
    return percent;
}

-(void) configureGameCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    NSDate *theDate = (NSDate *)[gamesByDate objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/YY"];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:1];
    dateLabel.text = [dateFormat stringFromDate:theDate];
    NSArray *filtered = [results filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"date = %@", theDate]];
    UILabel *totalLabel = (UILabel *)[cell viewWithTag:3];
    totalLabel.text = [NSString stringWithFormat:@"%i",[self getTotalPitches:filtered]];
    
    UILabel *percentLabel = (UILabel *)[cell viewWithTag:2];
    float perc = [self getPercent:filtered];
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterPercentStyle];
    percentLabel.text = [number stringFromNumber:[NSNumber numberWithFloat:perc]];
}

-(void) configurePitcherCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    Pitcher *pitcher = ((Pitcher *)[gamesByPitcher objectAtIndex:indexPath.row]);
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *totalLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *percentLabel = (UILabel *)[cell viewWithTag:2];
    @try {
        nameLabel.text = [NSString stringWithFormat:@"%@, %@", pitcher.lastName, pitcher.firstName];
        NSArray *filtered = [results filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pitcher = %@", pitcher]];
        totalLabel.text = [NSString stringWithFormat:@"%i",[self getTotalPitches:filtered]];
        float perc = [self getPercent:filtered];
        NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
        [number setNumberStyle:NSNumberFormatterPercentStyle];
        percentLabel.text = [number stringFromNumber:[NSNumber numberWithFloat:perc]];
    }
    @catch (NSException *exception) {
        nameLabel.text = @"Pitcher not found";
        totalLabel.text = @"";
        percentLabel.text = @"";
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PitcherIdentifier = @"PitcherCell";
    static NSString *GameIdentifier = @"GameCell";
    NSString *CellIdentifier = (titleView.selectedSegmentIndex == GAMES) ? GameIdentifier : PitcherIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (titleView.selectedSegmentIndex) {
            
        case GAMES:
            [self configureGameCell:cell withIndexPath:indexPath];
            break;
            
        case PITCHERS:
            [self configurePitcherCell:cell withIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    /* alternating row colors!!!
    UIView *myView = [[UIView alloc] init];
    if ((indexPath.row % 2) == 0) {
        myView.backgroundColor = [UIColor grayColor];
        cell.textLabel.backgroundColor = [UIColor grayColor];
    }
    else {
        myView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor whiteColor];
    }
    
    cell.backgroundView = myView;
*/
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *theLabel = (UILabel *)[tableHeader viewWithTag:1];
    theLabel.text = (titleView.selectedSegmentIndex == GAMES) ? @"Date" : @"Pitcher";
    return tableHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
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
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
}
*/
#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:appDelegate.managedObjectContext];
        [fetchRequest setEntity:entity];
        [fetchRequest setResultType:NSDictionaryResultType];
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        NSDictionary *allAttributes = [entity attributesByName];
        
        NSAttributeDescription *dateAttribute = [allAttributes objectForKey:@"date"];
        [fetchRequest setSortDescriptors:sortDescriptors];
        [fetchRequest setPropertiesToGroupBy:[[NSArray alloc]initWithObjects:dateAttribute, nil]];
         
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        //aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
    }
	
	return fetchedResultsController;
}    


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	return appDelegate.managedObjectModel;
}

-(void) initGames {
    gamesByDate = [[NSMutableArray alloc]init];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSError *error;
    results = [managedObjectContext executeFetchRequest:request error:&error];
    NSArray *count = [results valueForKeyPath:@"@count"];
    gamesByDate=[results valueForKeyPath:@"@distinctUnionOfObjects.date"];
    gamesByPitcher = [results valueForKeyPath:@"@distinctUnionOfObjects.pitcher"];
    //NSLog(@"count:%@, byDate:%@, byPitcher:%@", count, byDate, byPitcher);
}

#pragma mark -
#pragma mark UI Helpers
-(IBAction)viewTypeTapped:(id)sender {
    switch (titleView.selectedSegmentIndex) {
        case 0:
            break;
        case 1:
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"pitcherSegue"]) {
        if (titleView.selectedSegmentIndex == PITCHERS) {
            selectedPitcher = ((Pitcher *)[gamesByPitcher objectAtIndex:indexPath.row]);
        }
        PitcherStatistictsViewController* theView = (PitcherStatistictsViewController *)segue.destinationViewController;
        theView.dataSource = [results filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pitcher = %@", selectedPitcher]];
        theView.pitcher = selectedPitcher;

    } else if ([segue.identifier isEqualToString:@"GameSegue"]) {
        NSDate *theDate = (NSDate *)[gamesByDate objectAtIndex:indexPath.row];

        GameStatisticsViewController *theView = (GameStatisticsViewController *)segue.destinationViewController;
        theView.gameDate = theDate;
        
        NSArray *filtered = [results filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"date = %@", theDate]];
        theView.dataSource = filtered;
    }
}
@end
