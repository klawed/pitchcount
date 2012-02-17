//
//  BaseModeViewController.h
//  
//
//  Created by Claude Keswani on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Pitcher.h"
#import "AppDelegate.h"
#import "PitcherListTableViewController.h"
#import <CoreData/CoreData.h>

@interface BaseModeViewController : UIViewController<UIAlertViewDelegate, UIPickerViewDelegate,PitcherPickDelegate> {
    Game *currentGame;
    /*IBOutlet UILabel *total;
    IBOutlet UILabel *strikes;
    IBOutlet UILabel *balls;
    IBOutlet UILabel *percent;
    IBOutlet UILabel *warning;
    IBOutlet UILabel *warningCountdown;
    IBOutlet UIImageView *warningImage;*/
    NSArray *innings;
    IBOutlet UIView *inningPicker;
    int currentStrikes;
    int currentBalls;
    int weeklyLimit;
}

@property (retain, nonatomic) Game *currentGame;
@property (retain, nonatomic) IBOutlet UILabel *total;
@property (retain, nonatomic) IBOutlet UILabel *strikes;
@property (retain, nonatomic) IBOutlet UILabel *balls;
@property (retain, nonatomic) IBOutlet UILabel *percent;
@property (retain, nonatomic) IBOutlet UILabel *warning;
@property (retain, nonatomic) IBOutlet UILabel *warningCountdown;
@property (retain, nonatomic) IBOutlet UIView *warningView;
@property (retain, nonatomic) IBOutlet UIView *inningPicker;
@property (retain, nonatomic) IBOutlet UILabel *pitcherName;

@property (retain, nonatomic) NSArray *pitcherList;
@property (nonatomic, retain) AppDelegate *appDelegate;


-(void) addStrike;
-(void) addBall;
-(void) removeStrike;
-(void) removeBall;
-(void) updatePercent;
-(void) updateTotal;

-(void) nextGame;

-(void) newPitcher;

-(int) weeklyLimitForPitcher;

-(IBAction)doneTapped:(id)sender;

-(IBAction)cancelTapped:(id)sender;

-(IBAction)inningDoneButtonTapped:(id)sender;

-(IBAction)inningCancelButtonTapped:(id)sender;

-(IBAction)addStrike;

-(IBAction)removeStrike;

-(IBAction) removeBall;

-(IBAction) addBall;


@end
