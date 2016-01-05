//
//  Dimension.h
//  Meta
//
//  Created by Matěj Sychra on 22/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "Universe.h"
#import "Configuration.h"

@protocol UniverseDelegate <NSObject>
-(void)universeWillTerminate;
@end

@interface Dimension : NSObject

@property (nonatomic, assign) id universe;

@property (nonatomic, retain) NSMutableArray* entities;

@property (nonatomic, retain) NSDate *judgementDay;

// Called by Universe (DimensionManager) on clock tick
-(void)updateDimension;

// Called by Universe (DimensionManager) on judgementDay
- (void)terminateDimension;

// Reverse delegate (up-call) method public to sibling
-(void)godDidTerminate:(id)god;

@end
