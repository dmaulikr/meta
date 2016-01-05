//
//  Meta.h
//  Meta
//
//  Created by Matěj Sychra on 22/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LivingEntity.h"
#import "Dimension.h"
#import "Configuration.h"
#import "Destiny.h"

@protocol GodProtocolDelegate <NSObject>
// Asynchronous, always returns void
-(void)prayWithLove:(NSNumber*)love;
@end

@interface God : NSObject <UniverseDelegate> {
    NSTimer *existenceTermination;
    NSTimer *existenceEvent;
}

@property (nonatomic, retain) Dimension *dimension; // link to the physical 'owner'

@property (nonatomic, retain) Destiny *destiny;

@property (nonatomic, retain) NSNumber *love;
@property (nonatomic, retain) NSNumber *peace;
@property (nonatomic, retain) NSNumber *eternity;

@property (nonatomic, retain) NSDate *creationDate;
@property (nonatomic, retain) NSMutableArray *existenceDatesArray;

-(id)init;

// Designated Initializer
-(id)initWithLove:(NSNumber*)love peace:(NSNumber*)peace eternity:(NSNumber*)eternity;

-(void)setLove:(NSNumber*)love; // -1 means hate
-(void)setPeace:(NSNumber*)peace; // -1 means war
-(void)setEternity:(NSNumber*)peace; // -1 means history, because 0 is singularity; one-time event

// Returns current light based on LPE values
-(NSNumber*)light;

// Space Delegate methods
-(void)universeWillTerminate;

// Living Entity Delegate Method (Death) as entity is
-(void)entityDiedWithLove:(NSNumber*)love;

@end
