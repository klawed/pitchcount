//
//  BaseModeViewController.m
//  
//
//  Created by Claude Keswani on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseModeViewController.h"

@implementation BaseModeViewController

@synthesize currentGame, strikes, balls, total,percent,warning, warningCountdown, warningImage, inningPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        innings = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        currentBalls = 0;
        currentStrikes = 0;
    }
    return self;
}

-(void) updatePercent{
    float perc = (float)currentStrikes/((float)currentBalls+(float)currentStrikes);
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterPercentStyle];
    
    self.percent.text = [number stringFromNumber:[NSNumber numberWithFloat:perc]];
    
}

-(void) updateTotal {
    total.text = [NSString stringWithFormat:@"%i", currentBalls + currentStrikes];
}

-(void) updateStrikes {
    self.strikes.text = [NSString  stringWithFormat:@"%i",currentStrikes];
}

-(void) updateBalls {
    self.balls.text = [NSString  stringWithFormat:@"%i",currentBalls];
}

-(void)addStrike {
    currentStrikes++;
    [self updateStrikes];
    [self updatePercent];
    [self updateTotal];
}

-(void)removeStrike {
    currentStrikes--;
    [self updateStrikes];
    [self updatePercent];
    [self updateTotal];
}

-(void) removeBall {
    currentBalls--;
    [self updateBalls];
    [self updatePercent];
    [self updateTotal];
}

-(void) addBall {
    currentBalls++;
    [self updateBalls];
    [self updatePercent];
    [self updateTotal];
}



@end
