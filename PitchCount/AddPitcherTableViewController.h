//
//  AddPitcherTableViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Pitcher.h"
#import "AppDelegate.h"
//do we need this decleration?
@protocol PitcherAddDelegate;

@interface AddPitcherTableViewController : UITableViewController {
    Pitcher *pitcher;
    id <PitcherAddDelegate> delegate;
    BOOL isEdit;
 }

@property(nonatomic, retain) id <PitcherAddDelegate> delegate;

@property (nonatomic, retain) Pitcher *pitcher;

@property (nonatomic, retain) AppDelegate *appDelegate;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, assign) BOOL isModal;

-(IBAction)save:(id)sender;
@end

@protocol PitcherAddDelegate <NSObject>

- (void)pitcherAddViewController:(AddPitcherTableViewController *)addPitcherViewController didAddPitcher:(Pitcher *)pitcher;

- (void)cancelButtonTouched:(id)sender;

- (void)doneButtonTouched:(id)sender;

- (IBAction)goBack:(id)sender;
@end