//
//  SecondViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Game.h"
#import "Pitcher.h"
#import "PitcherStatistictsViewController.h"

@interface StatisticsViewController : UITableViewController {
    AppDelegate *appDelegate;
    NSArray *results;
    NSArray *gamesByDate;
    NSArray *gamesByPitcher;
    UIView *tableHeader;
    Pitcher *selectedPitcher;

}
@property (nonatomic, retain) AppDelegate *appDelegate;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain, getter = getManagedContext) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UISegmentedControl* titleView;

-(void) initGames;

-(IBAction)viewTypeTapped:(id)sender;


@end
