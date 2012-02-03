//
//  StrikeZoneModeViewController.m
//  PitchCount
//
//  Created by Claude Keswani on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StrikeZoneModeViewController.h"
#import <QuartzCore/QuartzCore.h>
#define STRIKE_RECTANGLE   CGRectMake(48, 136, 120, 178)
#define BALL_RECTANGLE CGRectMake(6,74,205,300)



@implementation DragView
@synthesize isActive;
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if (isActive) {
    startPt = [[touches anyObject] locationInView:[self superview]];
    
	CGPoint pt = [[touches anyObject] locationInView:self];
	startLocation = pt;
	[[self superview] bringSubviewToFront:self];
    
    if ([[touches anyObject] tapCount] == 2) {
        [self removeFromSuperview];
        if(CGRectContainsPoint(CGRectMake(65, 80, 175, 175), startPt)){
            //            [[appDelegate.viewController objStrick] strikeMinus];
        }else  if(!CGRectContainsPoint(CGRectMake(65, 80, 175, 175), startPt)){
            //            [[appDelegate.viewController objStrick] ballMinus];
        }
    }
    }
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    if (isActive) {
    CGPoint Spt = [[touches anyObject] locationInView:[self superview]]; 
    if(!CGRectContainsPoint(CGRectMake(10, 74, 305, 230), Spt)) {
        return;
    }
	// Move relative to the original touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += pt.x - startLocation.x;
	frame.origin.y += pt.y - startLocation.y;
	[self setFrame:frame];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isActive) {
    endPt = [[touches anyObject] locationInView:[self superview]];
    
    //
    //i.e. Movement from Outside to Inside //Ball to Strike
    if(!CGRectContainsPoint(CGRectMake(65, 80, 175, 175), startPt) && CGRectContainsPoint(CGRectMake(65, 80, 175, 175), endPt)){
        
        //        [[appDelegate.viewController objStrick] ballMinus];
        //        [[appDelegate.viewController objStrick] strikePlus];
        
    }
    //i.e. Movement from Inside to Outside //Strike to Ball
    if(CGRectContainsPoint(CGRectMake(65, 80, 175, 175), startPt) && !CGRectContainsPoint(CGRectMake(65, 80, 175, 175), endPt)){
        
        //        [[appDelegate.viewController objStrick] strikeMinus];
        //        [[appDelegate.viewController objStrick] ballPlus];
        
    }
    }
    
}
@end

@implementation StrikeZoneModeViewController
@synthesize currentGame, strikes, balls, total,percent,warning, warningCountdown, warningImage, inningPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        innings = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *v = inningPicker;
    [v.layer setCornerRadius:30.0f];
     [v.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [v.layer setBorderWidth:1.5f];
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)tapRecognized:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [sender locationInView:self.view];
        NSLog(@"x: %f, y:%f", point.x, point.y);
        if (CGRectContainsPoint(BALL_RECTANGLE, point)) {
                if (CGRectContainsPoint(STRIKE_RECTANGLE, point)) {
                    NSLog(@"Strike!!!");
                    [self addStrike];
                } else {
                    NSLog(@"Ball!!!");
                    [self addBall];
                }
            if (currentBall != nil) {
                [UIView animateWithDuration:0.7 
                             animations:^{                              
                                 currentBall.transform = CGAffineTransformMakeScale(1, 1);
                                 currentBall.alpha = .5;
                             } 
             ];
            }
                        CGRect dragRect = CGRectMake(0.0f, 0.0f, 24.0f, 24.0f);
                    dragRect.origin = point;
                    DragView *dragger = [[DragView alloc] initWithFrame:dragRect];
                    [dragger setImage:[UIImage imageNamed:@"icon_ball.png"]];
                    [dragger setUserInteractionEnabled:YES];
                    dragger.hidden = YES;
                    [self.view addSubview:dragger];
                    
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:.5];
                    dragger.hidden = NO;
            dragger.transform = CGAffineTransformMakeScale(1.5, 1.5);
            currentBall = dragger;
                    [UIView commitAnimations];
        }  
    }
        
}

#pragma mark Picker DataSource/Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 9;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //NSDictionary *optionForRow = [accuracyOptions objectAtIndex:row];
    //[setupInfo setObject:[optionForRow objectForKey:kAccuracyValueKey] forKey:kSetupInfoKeyAccuracy];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [innings objectAtIndex:row];
}

#pragma mark -
#pragma mark ui helpers


-(void)addStrike {
    currentGame.strikes = [NSNumber numberWithInt:[currentGame.strikes intValue] +1];
    self.strikes.text = [NSString  stringWithFormat:@"%@",currentGame.strikes];
    [self updatePercent];
}

-(void) addBall {
    currentGame.balls = [NSNumber numberWithInt:[currentGame.balls intValue] +1];
    self.balls.text = [NSString  stringWithFormat:@"%@",currentGame.balls];
    [self updatePercent];
}

-(void) updatePercent{
    float str = [currentGame.strikes floatValue];
    float bls = [currentGame.balls floatValue];
    float perc = str/(str + bls);
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterPercentStyle];
    
    self.percent.text = [number stringFromNumber:[NSNumber numberWithFloat:perc]];

}
-(IBAction)doneTapped:(id)sender {
    CGRect showFrame = CGRectMake(200, 100, 120, 216);
    [UIView animateWithDuration:.5 animations:^{
        inningPicker.frame = showFrame;
    }];
    [self.currentGame.managedObjectContext save:nil];
    //[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)cancelTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
