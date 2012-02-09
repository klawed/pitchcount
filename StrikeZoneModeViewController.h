//
//  StrikeZoneModeViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

typedef enum {
    kBall,
    kStrike
} ThrowType;
@protocol DragViewChangeDelegate;

@interface DragView : UIImageView
{
	CGPoint startLocation;
    CGPoint startPt;
    CGPoint endPt;
    BOOL _active;
    UIPanGestureRecognizer *pan;
    ThrowType throw;
    id <DragViewChangeDelegate> delegate;
}
//overide the setter here to kill the gesture recognizer
@property (setter = setActive:,nonatomic) BOOL active;

@property (nonatomic) ThrowType throw;

@property (nonatomic, retain) id <DragViewChangeDelegate> delegate;

-(void) panGestureRecognized:(UIPanGestureRecognizer *)gesture;

@end

@interface StrikeZoneModeViewController : UIViewController<UIPickerViewDelegate, DragViewChangeDelegate> {
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

@protocol DragViewChangeDelegate <NSObject>

-(void) didChangeStrikeToBall:(DragView *)sender;

-(void) didChangeBallToStrike:(DragView *)sender;

@end