//
//  StrikeZoneModeViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Pitcher.h"

@interface DragView : UIImageView
{
	CGPoint startLocation;
    CGPoint startPt;
    CGPoint endPt;
    BOOL isActive;
}
@property BOOL isActive;
@end
@interface StrikeZoneModeViewController : UIViewController<UIPickerViewDelegate> {
    Game *currentGame;
    Pitcher *currentPitcher;
    IBOutlet UILabel *totalLabel;
    IBOutlet UILabel *strikes;
    IBOutlet UILabel *balls;
    IBOutlet UILabel *percent;
    IBOutlet UILabel *warning;
    IBOutlet UILabel *warningCountdown;
    IBOutlet UIView *warningView;
    DragView *currentBall;
    NSArray *innings;
    IBOutlet UIView *inningPicker;
    int weeklyLimit;
}

@property (retain, nonatomic) Game *currentGame;
@property (retain, nonatomic) Pitcher *currentPitcher;
@property (retain, nonatomic) IBOutlet UILabel *totalLabel;
@property (retain, nonatomic) IBOutlet UILabel *strikes;
@property (retain, nonatomic) IBOutlet UILabel *balls;
@property (retain, nonatomic) IBOutlet UILabel *percent;
@property (retain, nonatomic) IBOutlet UILabel *warning;
@property (retain, nonatomic) IBOutlet UILabel *warningCountdown;
@property (retain, nonatomic) IBOutlet UIView *warningView;
@property (retain, nonatomic) IBOutlet UIView *inningPicker;

-(IBAction)tapRecognized:(UITapGestureRecognizer *)sender;

-(IBAction)doneTapped:(id)sender;

-(IBAction)cancelTapped:(id)sender;

-(void)  addStrike;
-(void) addBall;
-(void) updatePercent;
@end
