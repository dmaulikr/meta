//
//  Universe.m
//  Meta
//
//  Created by Matěj Sychra on 23/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import "Universe.h"

@implementation Universe

-(id)init
{
    self = [super init];

    if (self) {

        float random = rand()/RAND_MAX;
        int dim = 1 + random * MAX_UNIVERSE_DIMENSIONS ;
        self.dimensions = [NSMutableArray new];

        NSLog(@"[universe] new with %i dimensions:", dim);

        for (int i = 0; i <= dim; i++) {
            Dimension *space = [Dimension new];
            [self.dimensions addObject:space];
        }
    }

    masterClock = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateUniverse) userInfo:nil repeats:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dimensionDidTerminate:) name:@"dimensionDidTerminate" object:nil];

    return self;
}

-(void)updateUniverse
{
    if (self.useExternalClock) {
        [masterClock invalidate]; masterClock = nil;
    }

    NSLog(@"[universe] tick");

    NSMutableArray *expiredDimensions = [NSMutableArray new];

    // Force clock, extract expired dimensions and terminate them

    for (Dimension *dim in self.dimensions) {

        [dim updateDimension];

        if ([[NSDate date] compare:dim.judgementDay] == NSOrderedDescending) {

            [dim terminateDimension];
            [expiredDimensions addObject:dim];
        }
    }

    if ([expiredDimensions count]) {
        NSLog(@"[universe] expired %i dimensions", expiredDimensions.count);
    } else {
        NSLog(@"[universe] holding %i dimensions", self.dimensions.count);
    }

    // Remove expired/terminated dimensions

    for (Dimension *dim in expiredDimensions) {
        [self.dimensions removeObject:dim];
    }


}


-(void)dimensionDidTerminate:(Dimension*)dim
{
    NSLog(@"[universe] removing terminated space %@", dim);

    @synchronized(self.dimensions) {
        [self.dimensions removeObject:dim];
    }
}

@end
