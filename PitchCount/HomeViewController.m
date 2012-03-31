//
//  FirstViewController.m
//  PitchCount
//
//  Created by Claude Keswani on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

#define UPFRAME    CGRectMake(0, 200, 320, 216)
#define DOWNFRAME  CGRectMake(0, 480, 320, 216)
@implementation HomeViewController

@synthesize datePicker, currentPitcher, appDelegate, header;

@synthesize fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}	
    if ([[fetchedResultsController fetchedObjects] count] != 0) {
        currentPitcher = (Pitcher *)[[fetchedResultsController fetchedObjects]objectAtIndex:0];
    }
    datePicker.hidden = YES;
    datePicker.frame = DOWNFRAME;
    datePicker.datePickerMode = UIDatePickerModeDate;
//    UIImage *img = [UIImage imageNamed:@"home_bkgrnd.png"];
//	[[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:img]];  
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    UITableViewCell *cell;
    static NSString *dateIdentifier = @"DateCell";
    static NSString *pitcherIdentifier = @"PitcherCell";
    static NSString *ageIdentifier = @"AgeCell";
    static NSString *strikeIdentifier = @"StrikeButton";
    static NSString *plusIdentifier = @"PlusButton";
    if (indexPath.section == 0) {
            Pitcher *pitcher = currentPitcher;
            if (indexPath.row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:dateIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dateIdentifier];
                }
                /*UIImage *img = [UIImage imageNamed:@"tableBGRed.png"];
                [cell setBackgroundColor:[UIColor colorWithPatternImage:img]];*/

                UILabel *label;
                label = (UILabel *)[cell viewWithTag:1];
                label.text = [self todaysDate];
            } else  if (indexPath.row == 1) {
                cell = [tableView dequeueReusableCellWithIdentifier:pitcherIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pitcherIdentifier];
                 }                                  
                UILabel *label;
                 label = (UILabel *)[cell viewWithTag:1];
                    if (pitcher == nil) {
                    label.text = @"Add a pitcher"; 
                } else {
                   label.text = [NSString stringWithFormat: @"%@ %@", pitcher.firstName, pitcher.lastName];
                }
            }  else  if (indexPath.row == 2) {
                cell = [tableView dequeueReusableCellWithIdentifier:ageIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ageIdentifier];
                }                                    
                UILabel *label;
                label = (UILabel *)[cell viewWithTag:1];
                if (pitcher != nil) {
                    label.text = [NSString stringWithFormat:@"%@", pitcher.age];
                }
            }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:strikeIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strikeIdentifier];
            }   
        
            /*UIButton *theButton = (UIButton *)[cell viewWithTag:1];
            [theButton addTarget:self action:@selector(strikeModeSelected) forControlEvents:UIControlEventTouchUpInside];*/
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:plusIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:plusIdentifier];
            }   
            
            /*UIButton *theButton = (UIButton *)[cell viewWithTag:1];
            [theButton addTarget:self action:@selector(strikeModeSelected) forControlEvents:UIControlEventTouchUpInside];*/

        }
    }
    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Pitch Count";
            break;
            
        default:
            return @"";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *niblets = [[NSBundle mainBundle] loadNibNamed:@"HomeHeader" owner:self options:NULL];
    
    switch (section) {
            
        case 0:
            return [niblets objectAtIndex:0];
            break;
            
        default:
            return nil;
            break;
    }
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self toggleDatePicker:nil];
    }
}


#pragma mark -
#pragma mark PickPitcherDelegate

- (void)pitcherListViewController:(PitcherListTableViewController *)pitcherListViewController didPickPitcher:(Pitcher *)pitcher {
    self.currentPitcher = pitcher;
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}	
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pitcher" inManagedObjectContext:appDelegate.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"battingOrder" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        aFetchedResultsController.delegate = self;
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

#pragma  mark -
#pragma mark uipickerviewdelegate
- (void)datePicked:(id)sender {
    UITableViewCell *dateCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] ];
    UILabel *dateLabel = (UILabel *)[dateCell viewWithTag:1];
    dateLabel.text = [self formatDate:datePicker.date];
}


#pragma mark -
#pragma mark helper methods

-(NSString*) formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

-(NSString*)todaysDate {
    NSDate *today = [NSDate date];
    return [self formatDate:today];    
}

#pragma mark -
#pragma mark ui actions
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickAPitcher"]) {
        ((PitcherListTableViewController *)segue.destinationViewController).delegate = self;
    } else if ([segue.identifier isEqualToString:@"ShowStrikeMode"] || [segue.identifier isEqualToString:@"ShowPlusMinusMode"]) {
        if (currentPitcher == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select a pitcher?" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            [alert show];
            return;
        }
        Game *game = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:appDelegate.managedObjectContext];
        NSTimeInterval time = floor([datePicker.date timeIntervalSinceReferenceDate] / 86400.0) * 86400.0;
        NSDate *newDateTime = [NSDate dateWithTimeIntervalSinceReferenceDate:time];
        game.date = newDateTime;
        game.pitcher = currentPitcher;
        NSMutableSet *games = [currentPitcher mutableSetValueForKey:@"games"];
        [games addObject:game];
        BaseModeViewController *strikeMode = (BaseModeViewController *)segue.destinationViewController;
        strikeMode.currentGame = game;
        strikeMode.pitcherList = [[self fetchedResultsController] fetchedObjects];
    }
}

-(IBAction)toggleDatePicker:(id)sender {
    datePicker.hidden = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if (CGRectEqualToRect(datePicker.frame, UPFRAME)) {
        datePicker.frame = DOWNFRAME;
    } else {
        datePicker.frame = UPFRAME;
    }
    [UIView commitAnimations];
}


-(void)  strikeModeSelected {
    if (currentPitcher == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select a pitcher?" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert show];
        return;
    }
    Game *game = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:appDelegate.managedObjectContext];
    game.date = datePicker.date;
    game.pitcher = currentPitcher;
    NSMutableSet *games = [currentPitcher mutableSetValueForKey:@"games"];
    [games addObject:game];
    StrikeZoneModeViewController *strikeMode = [[StrikeZoneModeViewController alloc]initWithNibName:nil bundle:nil];
    strikeMode.currentGame = game;
    strikeMode.pitcherList = [[self fetchedResultsController] fetchedObjects];
    [self.view addSubview:strikeMode.view];
    [self.navigationController presentModalViewController:strikeMode animated:YES];             
}



@end
