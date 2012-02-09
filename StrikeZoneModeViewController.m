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
@synthesize  active, throw, delegate;

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}
-(void) panGestureRecognized:(UIPanGestureRecognizer *)gesture {
    NSLog(@"pan recognized");
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        
        CGPoint location = [gesture locationInView:self.superview];
        if (gesture.state == UIGestureRecognizerStateEnded) {
        if (CGRectContainsPoint(STRIKE_RECTANGLE, location) && throw == kBall) {
            [delegate didChangeBallToStrike:self];
            throw = kStrike;
        } else if (!CGRectContainsPoint(STRIKE_RECTANGLE, location) && CGRectContainsPoint(BALL_RECTANGLE, location) && throw == kStrike) {
            [delegate didChangeStrikeToBall:self];
            throw = kBall;
        }
        }
        [self setCenter:location];
    }
}

-(void)setActive:(BOOL)isActive {
    if (!isActive) {
        [self removeGestureRecognizer:pan];
        pan = nil;
    } 
    _active = isActive;
}

@end

@implementation StrikeZoneModeViewController
@synthesize currentGame, strikes, balls, total,percent,warning, warningCountdown, warningImage, inningPicker, currentBalls, currentStrikes;

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

-(IBAction)tapRecognized:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [sender locationInView:self.view];
        NSLog(@"x: %f, y:%f", point.x, point.y);
        
        if (CGRectContainsPoint(BALL_RECTANGLE, point)) {
            CGRect dragRect = CGRectMake(0.0f, 0.0f, 24.0f, 24.0f);
            dragRect.origin = point;
            DragView *dragger = [[DragView alloc] initWithFrame:dragRect];
            dragger.delegate = self;
            if (CGRectContainsPoint(STRIKE_RECTANGLE, point)) {
                    NSLog(@"Strike!!!");
                    [self addStrike];
                dragger.throw = kStrike;
                } else {
                    NSLog(@"Ball!!!");
                    [self addBall];
                    dragger.throw = kBall;
                }
            if (currentBall != nil) {
                currentBall.active = NO;
                [UIView animateWithDuration:0.7 
                             animations:^{                              
                                 currentBall.transform = CGAffineTransformMakeScale(1, 1);
                                 currentBall.alpha = .5;
                             } 
             ];
            }
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
    currentGame.innings = [NSNumber numberWithInteger:[(NSString *)[innings objectAtIndex:row] integerValue]];
    currentGame.strikes = [NSNumber numberWithInt:currentStrikes];
    currentGame.balls = [NSNumber numberWithInt:currentBalls];
    [[currentGame managedObjectContext] save:nil];
    [self dismissModalViewControllerAnimated:YES];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [innings objectAtIndex:row];
}

#pragma mark -
#pragma mark ui helpers


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

-(IBAction)doneTapped:(id)sender {
    CGRect showFrame = CGRectMake(200, 100, 320, 216);
    [UIView animateWithDuration:.5 animations:^{
        inningPicker.frame = showFrame;
    }];
}

-(IBAction)cancelTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - DragViewChangeDelegate
-(void) didChangeStrikeToBall:(DragView *)sender {
    [self addBall];
    [self removeStrike];
}

-(void) didChangeBallToStrike:(DragView *)sender {
    [self addStrike];
    [self removeBall];
}
@end
