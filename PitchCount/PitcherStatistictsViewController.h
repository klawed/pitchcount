//
//  PitcherStatistictsViewController.h
//  PitchCount
//
//  Created by Claude Keswani on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pitcher.h"
#import "Game.h"

@interface PitcherStatistictsViewController : UITableViewController {
    NSArray *games;
}

@property (nonatomic, retain) NSArray* games;
@property (nonatomic, retain) Pitcher* pitcher;
       
- (void)configureCell:(UITableViewCell *)theCell withIndexPath:(NSIndexPath *)indexPath;

@end
