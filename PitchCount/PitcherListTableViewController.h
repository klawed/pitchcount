//
//  PitcherListTableViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Pitcher.h"
#import "AddPitcherTableViewController.h"
#import "HomeViewController.h"

@interface PitcherListTableViewController : UITableViewController <PitcherAddDelegate, NSFetchedResultsControllerDelegate>  {
@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    Pitcher *currentPitcher;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(IBAction) selectPitcher:(id)sender;

@end
