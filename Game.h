//
//  Game.h
//  PitchCount
//
//  Created by Claude Keswani on 2/1/12.
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
@property (nonatomic, retain) NSSet *pitchers;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addPitchersObject:(Pitcher *)value;
- (void)removePitchersObject:(Pitcher *)value;
- (void)addPitchers:(NSSet *)values;
- (void)removePitchers:(NSSet *)values;

@end
