//
//  FirstViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Pitcher.h"
#import "Game.h"
#import "PitcherListTableViewController.h"
#import "StrikeZoneModeViewController.h"

@interface HomeViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    IBOutlet UINavigationBar *navigationBar;
    UIDatePicker *datePicker;
    Pitcher *currentPitcher;
    AppDelegate *appDelegate;

@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) Pitcher *currentPitcher;
@property (nonatomic, retain) AppDelegate *appDelegate;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSString *)todaysDate;
-(NSString*)ageForDate:(NSDate *)theDate;

-(IBAction)toggleDatePicker:(id)sender;


- (void) strikeModeSelected;
- (NSString *)applicationDocumentsDirectory;

@end