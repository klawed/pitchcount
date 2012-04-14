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
#import "AppDelegate.h"

@protocol PitcherPickDelegate;

@interface PitcherListTableViewController : UITableViewController <PitcherAddDelegate, NSFetchedResultsControllerDelegate>  {
@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    AppDelegate *appDelegate;
    id <PitcherPickDelegate> delegate;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) AppDelegate *appDelegate;
@property (nonatomic, retain) id <PitcherPickDelegate> delegate;
@property (nonatomic) BOOL isModal;
-(IBAction) selectPitcher:(id)sender;
- (IBAction) add:(id)sender;
-(IBAction) goHome:(id)sender;
@end

@protocol PitcherPickDelegate <NSObject>

- (void)pitcherListViewController:(PitcherListTableViewController *)pitcherListViewController didPickPitcher:(Pitcher *)pitcher;

@end
