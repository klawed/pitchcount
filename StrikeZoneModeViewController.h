//
//  StrikeZoneModeViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
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
    IBOutlet UILabel *total;
    IBOutlet UILabel *strikes;
    IBOutlet UILabel *balls;
    IBOutlet UILabel *percent;
    IBOutlet UILabel *warning;
    IBOutlet UILabel *warningCountdown;
    IBOutlet UIImageView *warningImage;
    DragView *currentBall;
    NSArray *innings;
    IBOutlet UIView *inningPicker;
}

@property (retain, nonatomic) Game *currentGame;
@property (retain, nonatomic) IBOutlet UILabel *total;
@property (retain, nonatomic) IBOutlet UILabel *strikes;
@property (retain, nonatomic) IBOutlet UILabel *balls;
@property (retain, nonatomic) IBOutlet UILabel *percent;
@property (retain, nonatomic) IBOutlet UILabel *warning;
@property (retain, nonatomic) IBOutlet UILabel *warningCountdown;
@property (retain, nonatomic) IBOutlet UIImageView *warningImage;
@property (retain, nonatomic) IBOutlet UIView *inningPicker;
@property int currentBalls;
@property int currentStrikes;

-(IBAction)tapRecognized:(UITapGestureRecognizer *)sender;

-(IBAction)doneTapped:(id)sender;

-(IBAction)cancelTapped:(id)sender;

-(void)  addStrike;
-(void) addBall;
-(void) updatePercent;
-(void) updateTotal;
@end
