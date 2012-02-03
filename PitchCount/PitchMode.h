//
//  PitchMode.h
//  
//
//  Created by Claude Keswani on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PitchCountsAppDelegate.h"
#import "PitcherInfoWrapper.h"

@interface PitchMode : UIViewController {
    PitchCountsAppDelegate*appDelegate;
    UITextField*pitcherInningsField;
    
    int pitchCount;
    int strikes;
    int balls;
    int weekltLimit;
    int age;

    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* pitchCountLabel;
    IBOutlet UILabel* strikesLabel;
    IBOutlet UILabel* ballsLabel;
    IBOutlet UILabel* alertLabel;
    IBOutlet UIImageView* alertImage;
}

@property (nonatomic, retain) UITextField* pitcherInningsField;

-(IBAction)showGuidelines;

-(IBAction)showStatistics;

-(IBAction)showHome;

-(void)addNewPitcherAlert;

-(void)savePitcherAlert;

-(void)strikePlus;

-(void)strikeMinus;

-(void)ballPlus;

-(void)ballMinus;

-(IBAction)done;

-(IBAction)reset;

@end
