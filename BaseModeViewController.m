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

@synthesize currentGame, strikes, balls, total,percent,warning, warningCountdown, inningPicker, pitcherList, appDelegate, pitcherName, warningView;

-(void) viewDidLoad {
    UIView *v = inningPicker;
    [v.layer setCornerRadius:15.0f];
    [v.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [v.layer setBorderWidth:1.5f];
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    /*
    v = warningView;
    [v.layer setCornerRadius:15.0f];
    [v.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [v.layer setBorderWidth:1.5f];
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    */
    pitcherName.text = [NSString stringWithFormat:@"%@ %@", currentGame.pitcher.firstName, currentGame.pitcher.lastName];
    self.tabBarController.tabBar.hidden = YES;
    weeklyLimit = [self weeklyLimitForPitcher];
}

- (void) myInitialize {
    // Custom initialization
    innings = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    currentBalls = 0;
    currentStrikes = 0;
    appDelegate = [[UIApplication sharedApplication] delegate];

}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self myInitialize];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self myInitialize];
    }
    return self;
}

-(int)weeklyLimitForPitcher {
    int limit = 0;
    int age = [currentGame.pitcher.age intValue];
    if(age>=8 && age<=10){
        limit = 20;  //52 
    }else if(age>=11 && age<=12){
        limit = 68; 
    }else if(age>=13 && age<=14){
        limit = 76; 
    }else if(age>=15 && age<=16){
        limit = 91; 
    }else if(age>=17 && age<=18){
        limit = 106; 
    }else if(age > 19){
        limit = 106; 
    }
    return limit;
}

-(void) updatePercent{
    float perc = (currentBalls == 0 && currentStrikes == 0) ? 0 : (float)currentStrikes/((float)currentBalls+(float)currentStrikes);
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterPercentStyle];
    self.percent.text = [number stringFromNumber:[NSNumber numberWithFloat:perc]];
}

-(void) checkWarning {
    int delta = (weeklyLimit) - (currentBalls + currentStrikes);
    bool overLimit = delta < 15;
    if (overLimit) {
    [UIView animateWithDuration:1.0 animations:^{
        warningView.alpha = 1.0;
        warningCountdown.text = [NSString stringWithFormat:@"%i pitches away from the weekly recommended limit of %i.", delta, weeklyLimit];
    }];
    }
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

-(IBAction)addStrike {
    currentStrikes++;
    [self updateStrikes];
    [self updatePercent];
    [self updateTotal];
    [self checkWarning];
}

-(IBAction)removeStrike {
    currentStrikes--;
    [self updateStrikes];
    [self updatePercent];
    [self updateTotal];
}

-(IBAction) removeBall {
    currentBalls--;
    [self updateBalls];
    [self updatePercent];
    [self updateTotal];
}

-(IBAction) addBall {
    currentBalls++;
    [self updateBalls];
    [self updatePercent];
    [self updateTotal];
    [self checkWarning];
}

- (Pitcher *) nextPitcher {
    if ([pitcherList count] > 1) {
    int nextPitcherIndex = ([pitcherList indexOfObject:currentGame.pitcher] == [pitcherList count] - 1) ? 0: [pitcherList indexOfObject:currentGame.pitcher] + 1;
    Pitcher *nextPitcher =(Pitcher *) [pitcherList objectAtIndex:nextPitcherIndex];
    return nextPitcher;
    } 
    return nil;
}

-(void) reset {
    currentBalls = 0;
    currentStrikes = 0;
    [self updateBalls];
    [self updateStrikes];
    [self updatePercent];
    [self updateTotal];
    pitcherName.text = [NSString stringWithFormat:@"%@ %@", currentGame.pitcher.firstName, currentGame.pitcher.lastName];
    weeklyLimit = [self weeklyLimitForPitcher];
    warningView.alpha = 0.0;
    
}

-(void) saveGame {
    currentGame.strikes = [NSNumber numberWithInt:currentStrikes];
    currentGame.balls = [NSNumber numberWithInt:currentBalls];
    [[currentGame managedObjectContext] save:nil];
}
-(void) nextGame {
    Pitcher *nextPitcher = [self nextPitcher];
    [self saveGame];
    currentGame = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:appDelegate.managedObjectContext];
    currentGame.pitcher = nextPitcher;
    [self reset];
    }

-(void) newPitcher {
    if ([pitcherList count] > 1) {
        [self performSegueWithIdentifier:@"PickANewPitcher" sender:self];
    } else {
        [self performSegueWithIdentifier:@"AddANewPitcher" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickANewPitcher"]) {
        PitcherListTableViewController *theView = (PitcherListTableViewController *)segue.destinationViewController;
        theView.isModal = YES;
        theView.delegate = self;
    } else if ([segue.identifier isEqualToString:@"AddANewPitcher"]) {
        Pitcher *pitcher = (Pitcher *)[NSEntityDescription insertNewObjectForEntityForName:@"Pitcher" inManagedObjectContext:self.appDelegate.managedObjectContext];
        AddPitcherTableViewController *controller = (AddPitcherTableViewController *)segue.destinationViewController;
        controller.pitcher = pitcher;
        controller.delegate = self;
        controller.isModal = YES;
    }
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
    UIAlertView *alert;
    UIPickerView *thePicker = (UIPickerView *)[inningPicker viewWithTag:1];
    int row = [thePicker selectedRowInComponent:0];
    currentGame.innings = [NSNumber numberWithInteger:[(NSString *)[innings objectAtIndex:row] integerValue]];
    [self saveGame];
    if ([pitcherList count] > 1) {
        Pitcher *nextPitcher = [self nextPitcher];
        NSString *nextMessage = [NSString stringWithFormat:@"Switch to %@ %@.", nextPitcher.firstName, nextPitcher.lastName];
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"What's next?" delegate:self cancelButtonTitle:@"Nothing, the game's over." 
                                  otherButtonTitles: @"Choose a different pitcher.", nextMessage,  nil];
    } else {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"What's next?" delegate:self cancelButtonTitle:@"Nothing, the game's over." 
                                otherButtonTitles: @"Add a new pitcher.", nil];
    }
    
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
        case 2:
            //next pitcher
            [self nextGame];
            break;
            
        case 1:
            //different pitcher
            [self newPitcher];
            break;
        
        case 0:
            //game over
            [self saveGame];
            [self dismissModalViewControllerAnimated:YES];
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [innings objectAtIndex:row];
}

#pragma mark -
#pragma mark PickPitcherDelegate

- (void)pitcherListViewController:(PitcherListTableViewController *)pitcherListViewController didPickPitcher:(Pitcher *)pitcher {
    currentGame = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:appDelegate.managedObjectContext];
    currentGame.pitcher = pitcher;
    [self reset];
}

- (void)pitcherAddViewController:(AddPitcherTableViewController *)addPitcherViewController didAddPitcher:(Pitcher *)pitcher {
    [[pitcher managedObjectContext] save:nil];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Pitcher" inManagedObjectContext:appDelegate.managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"battingOrder" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSError *error;
    pitcherList = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    currentGame = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:appDelegate.managedObjectContext];
    currentGame.pitcher = pitcher;
    [self reset];
}

@end
