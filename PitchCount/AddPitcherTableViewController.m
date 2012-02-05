//
//  AddPitcherTableViewController.m
//  PitchCount
//
//  Created by Claude Keswani on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddPitcherTableViewController.h"

#define FIRST_NAME_TAG = 0
#define LAST_NAME_TAG = 1
#define AGE_TAG = 1

@implementation AddPitcherTableViewController

@synthesize pitcher,delegate,isEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *firstName = @"FirstNameCell";
    static NSString *lastName = @"LastNameCell";
    static NSString *age = @"AgeCell";
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:firstName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstName];
        }
        if (isEdit) {
            UITextField *field = (UITextField *)[cell viewWithTag:1];
            field.text = pitcher.firstName;
        }
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:lastName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastName];
        }
        if (isEdit) {
            UITextField *field = (UITextField *)[cell viewWithTag:1];
            field.text = pitcher.lastName;
        }
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:age];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:age];
        } 
        if (isEdit) {
            UITextField *field = (UITextField *)[cell viewWithTag:1];
            field.text = [NSString stringWithFormat:@"%@", pitcher.age];
        }
    }
    return cell;
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

-(IBAction)save:(id)sender {
    NSIndexPath *firstNamePath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell* cell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:firstNamePath];
    UITextField *textField = (UITextField *)[cell viewWithTag:1];
    pitcher.firstName = textField.text;
    
    cell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    textField = (UITextField *)[cell viewWithTag:1];
    pitcher.lastName = textField.text;
    
    cell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    textField = (UITextField *)[cell viewWithTag:1];
    pitcher.age = [NSNumber numberWithInteger:[textField.text integerValue]];
    NSLog(@"age = %@", pitcher.age);
    //[pitcher.managedObjectContext save:nil];   
    [self.delegate pitcherAddViewController:self didAddPitcher:pitcher];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
