//
//  GameStatistictsViewControllerViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Pitcher.h"
#import "BaseStatistictsDetailViewController.h"

@interface GameStatisticsViewController : BaseStatistictsDetailViewController

@property (nonatomic, retain) NSDate *gameDate;


@end
