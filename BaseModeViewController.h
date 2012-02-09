//
//  BaseModeViewController.h
//  
//
//  Created by Claude Keswani on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"

@interface BaseModeViewController : UIViewController {
    Game *currentGame;
    IBOutlet UILabel *total;
    IBOutlet UILabel *strikes;
    IBOutlet UILabel *balls;
    IBOutlet UILabel *percent;
    IBOutlet UILabel *warning;
    IBOutlet UILabel *warningCountdown;
    IBOutlet UIImageView *warningImage;
    NSArray *innings;
    IBOutlet UIView *inningPicker;
    int currentStrikes;
    int currentBalls;

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

-(void)  addStrike;
-(void) addBall;
-(void) removeStrike;
-(void) removeBall;
-(void) updatePercent;
-(void) updateTotal;
@end
