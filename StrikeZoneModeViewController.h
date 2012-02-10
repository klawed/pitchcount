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

#import "BaseModeViewController.h"

@interface StrikeZoneModeViewController : BaseModeViewController<DragViewChangeDelegate> {
        DragView *currentBall;
    NSMutableArray *allThrows;

}


-(IBAction)tapRecognized:(UITapGestureRecognizer *)sender;





@end

@protocol DragViewChangeDelegate <NSObject>

-(void) didChangeStrikeToBall:(DragView *)sender;

-(void) didChangeBallToStrike:(DragView *)sender;

@end