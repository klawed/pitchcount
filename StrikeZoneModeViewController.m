//
//  StrikeZoneModeViewController.m
//  PitchCount
//
//  Created by Claude Keswani on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StrikeZoneModeViewController.h"
#define STRIKE_RECTANGLE   CGRectMake(48, 136, 120, 178)
#define BALL_RECTANGLE CGRectMake(6,74,205,300)



@implementation DragView
@synthesize  active, throw, delegate;

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
        [self addGestureRecognizer:pan];
        doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapGestureRecognized:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.cancelsTouchesInView = YES;
        [self addGestureRecognizer:doubleTap];
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

-(void) doubleTapGestureRecognized:(UITapGestureRecognizer *)gesture {
    if (self.throw == kBall) {
        [delegate didRemoveBall:self];
    } else {
        [delegate didRemoveStrike:self];
    }
    [self removeFromSuperview];
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

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        allThrows = [[NSMutableArray alloc] init];
    }
    return self;
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        allThrows = [[NSMutableArray alloc] init];
    }
    return self;
}
/*
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
*/
#pragma mark - View lifecycle
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)removeAllThrows {
    for (UIView* theView in allThrows) {
        [theView removeFromSuperview];
    }
}

-(IBAction)tapRecognized:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [sender locationInView:self.view];
        NSLog(@"x: %f, y:%f", point.x, point.y);
        
        if (CGRectContainsPoint(BALL_RECTANGLE, point)) {
            CGRect dragRect = CGRectMake(0.0f, 0.0f, 24.0f, 24.0f);
            dragRect.origin = point;
            DragView *dragger = [[DragView alloc] initWithFrame:dragRect];
            [allThrows addObject:dragger];
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

-(IBAction)wtf:(id)sender{
    NSLog(@"what the fuck?");
}



#pragma mark -
#pragma mark ui helpers
-(void) nextGame {
    [super nextGame];
    [self removeAllThrows];
    NSLog(@"next game in strikezone");
}

-(void) newPitcher {
    [super newPitcher];
    [self removeAllThrows];
    NSLog(@"new Pitcher in strikezone");
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

-(void) didRemoveBall:(DragView *)sender {
    [allThrows removeObject:sender];
    [self removeBall];
}

-(void) didRemoveStrike:(DragView *)sender {
    [allThrows removeObject:sender];
    [self removeStrike];
}
@end
