//
//  Destiny.m
//  Meta
//
//  Created by Matěj Sychra on 23/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import "Destiny.h"

@implementation Destiny

/*
 * Schedules existence timer to notify delegate on its own death.
 */

-(void)setTerminationDate:(NSDate *)terminationDate
{
    _terminationDate = terminationDate;

    NSTimeInterval interval =  [terminationDate timeIntervalSinceReferenceDate] - [NSDate timeIntervalSinceReferenceDate];
    existence = [NSTimer scheduledTimerWithTimeInterval:fabs(interval) target:self selector:@selector(terminate) userInfo:nil repeats:NO];
}

-(void)terminate
{
    if (existence) {
        [existence invalidate]; existence = nil;
    }

    if (self.delegate) {
        [self.delegate terminate];
    }
}

@end
