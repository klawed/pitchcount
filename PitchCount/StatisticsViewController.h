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

@interface StatisticsViewController : UITableViewController {
    NSManagedObject *managedObjectContext;
    AppDelegate *appDelegate;

}
@property (nonatomic, retain) AppDelegate *appDelegate;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;



@end
