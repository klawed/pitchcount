//
//  Game.h
//  PitchCount
//
//  Created by Claude Keswani on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pitcher;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * balls;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * innings;
@property (nonatomic, retain) NSNumber * strikes;
@property (nonatomic, retain) Pitcher *pitcher;

@end
