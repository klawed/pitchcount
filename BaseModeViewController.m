//
//  BaseModeViewController.m
//  
//
//  Created by Claude Keswani on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseModeViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation BaseModeViewController

@synthesize currentGame, strikes, balls, total,percent,warning, warningCountdown, warningImage, inningPicker, pitcherList, appDelegate, pitcherName;

-(void) viewDidLoad {
    UIView *v = inningPicker;
    [v.layer setCornerRadius:15.0f];
    [v.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [v.layer setBorderWidth:1.5f];
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    pitcherName.text = [NSString stringWithFormat:@"%@ %@", currentGame.pitcher.firstName, currentGame.pitcher.lastName];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        innings = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        currentBalls = 0;
        currentStrikes = 0;
        appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(void) updatePercent{
    float perc = (currentBalls == 0 && currentStrikes == 0) ? 0 : (float)currentStrikes/((float)currentBalls+(float)currentStrikes);
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

- (Pitcher *) nextPitcher {
    int nextPitcherIndex = ([pitcherList indexOfObject:currentGame.pitcher] == [pitcherList count] - 1) ? 0: [pitcherList indexOfObject:currentGame.pitcher] + 1;
    Pitcher *nextPitcher =(Pitcher *) [pitcherList objectAtIndex:nextPitcherIndex];
    return nextPitcher;
}
-(void) nextGame {
    Pitcher *nextPitcher = [self nextPitcher];
    currentGame = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:appDelegate.managedObjectContext];
    currentGame.pitcher = nextPitcher;
    currentBalls = 0;
    currentStrikes = 0;
    [self updateBalls];
    [self updateStrikes];
    [self updatePercent];
    [self updateTotal];
    pitcherName.text = [NSString stringWithFormat:@"%@ %@", currentGame.pitcher.firstName, currentGame.pitcher.lastName];
}

-(void) newPitcher {
    [[[UIAlertView alloc]initWithTitle:@"Not implemented" message:@"oops" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
}

-(IBAction)doneTapped:(id)sender {
    CGRect showFrame = CGRectMake(0, 110, 320, 350);
    [self.view bringSubviewToFront:inningPicker];
    [UIView animateWithDuration:.5 animations:^{
        inningPicker.frame = showFrame;
    }];
}

-(IBAction)cancelTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)inningDoneButtonTapped:(id)sender {
    Pitcher *nextPitcher = [self nextPitcher];
    NSString *nextMessage = [NSString stringWithFormat:@"Switch to %@ %@.", nextPitcher.firstName, nextPitcher.lastName];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"What's next?" delegate:self cancelButtonTitle:@"Nothing, the game's over." 
                                         otherButtonTitles: nextMessage, @"Choose a different pitcher.", nil];
    [alert show];
}

-(IBAction)inningCancelButtonTapped:(id)sender {
    CGRect showFrame = CGRectMake(0, 480, 320, 350);
    [UIView animateWithDuration:.5 animations:^{
        inningPicker.frame = showFrame;
    }];
  
}


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1:
            //next pitcher
            [self nextGame];
            break;
            
        case 2:
            //different pitcher
            [self newPitcher];
            break;
            
        default:
            break;
    }
    [self inningCancelButtonTapped:nil];
    return;
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView {
    
}
/*
- (void)willPresentAlertView:(UIAlertView *)alertView;  // before animation and showing view
- (void)didPresentAlertView:(UIAlertView *)alertView;  // after animation

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

// Called after edits in any of the default fields added by the style
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView;
*/

#pragma mark Picker DataSource/Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 9;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    currentGame.innings = [NSNumber numberWithInteger:[(NSString *)[innings objectAtIndex:row] integerValue]];
    currentGame.strikes = [NSNumber numberWithInt:currentStrikes];
    currentGame.balls = [NSNumber numberWithInt:currentBalls];
    [[currentGame managedObjectContext] save:nil];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [innings objectAtIndex:row];
}
@end
