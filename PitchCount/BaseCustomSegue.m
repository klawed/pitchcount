//
//  BaseCustomSegue.m
//  PitchCount
//
//  Created by Claude Keswani on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseCustomSegue.h"

@implementation BaseCustomSegue

-(void)perform {
    HomeViewController *source = (HomeViewController *)self.sourceViewController;
    if (source.currentPitcher != nil) {
        [source presentModalViewController:self.destinationViewController animated:YES];
    }
}

@end
