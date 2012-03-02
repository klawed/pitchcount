//
//  AddPitcherTableViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pitcher.h"

//do we need this decleration?
@protocol PitcherAddDelegate;

@interface AddPitcherTableViewController : UITableViewController {
    Pitcher *pitcher;
    id <PitcherAddDelegate> delegate;
    BOOL isEdit;
 }

@property(nonatomic, retain) id <PitcherAddDelegate> delegate;

@property (nonatomic, retain) Pitcher *pitcher;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, assign) BOOL isModal;

-(IBAction)save:(id)sender;
@end

@protocol PitcherAddDelegate <NSObject>

- (void)pitcherAddViewController:(AddPitcherTableViewController *)addPitcherViewController didAddPitcher:(Pitcher *)pitcher;

- (void)cancelButtonTouched:(id)sender;

- (void)doneButtonTouched:(id)sender;

@end