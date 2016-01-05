//
//  Dimension.m
//  Meta
//
//  Created by Matěj Sychra on 22/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import "Dimension.h"
#import "God.h"

@implementation Dimension

-(id)init
{
    self = [super init];

    if (self) {

        // Initialize max age of this Dimension
        NSTimeInterval maxAge = fabs((float)rand() / RAND_MAX) * MAX_DIMENSION_AGE;
        self.judgementDay = [[NSDate date] dateByAddingTimeInterval:maxAge];

        int gods = (float)rand() / RAND_MAX * MAX_DIMENSION_GODS;
        self.entities = [NSMutableArray new];

        for (int i = 0; i < gods; i++) {
            
            God *god = [God new];
            god.dimension = self;

            [self.entities addObject:god];

#warning - TODO: add timer to terminate gods from top based on their 'eternity' parameter
        }


        NSLog(@"[dimension] new with %i gods will expire on %@", [self.entities count], [self formattedDate:self.judgementDay]);
    }

    return self;
}

-(void)updateDimension
{
    // external clock
    NSLog(@"[dimension] %@ holds %i living entities:", self, self.entities.count);

    if (self.entities.count) {
        NSLog(@"[dimension] %@", self.entities);
    }

    NSMutableArray *expiredEntities = [NSMutableArray new];

    for (LivingEntity *entity in self.entities) {
        NSLog(@"%@ terminationDate: %@", entity, [self formattedDate:entity.destiny.terminationDate]);

        if ([[NSDate date] compare:entity.destiny.terminationDate] == NSOrderedDescending) {
            [expiredEntities addObject:entity];
        }
    }

    // Remove expired entities (terminate)
    for (LivingEntity *entity in expiredEntities) {
        [entity terminate];
        [self.entities removeObject:entity];
    }

    if (self.entities.count == 0) {
        NSLog(@"Dimension expiration: %@", [self formattedDate:self.judgementDay]);
    }
}

// TODO: walk through all living gods and send universeWillTerminate message

- (void)terminateDimension
{
    NSLog(@"[dimension] %@ is killing all gods!", self);

    for (God *god in self.entities) {
        if ([god respondsToSelector:@selector(universeWillTerminate)]) {
            [god universeWillTerminate];
        }

        // TODO: Notify entities of the end.
    }

    // Entities should be deallocated by ARC in this environment

    //NSLog(@"Removing all entities in %@", self);
    //self.entities = nil;
}

-(void)godDidTerminate:(id)god
{
    NSLog(@"[dimension] universe %@ is forgetting terminated god %@", self, god);

    [self.entities removeObject:god];
}

-(NSString*)formattedDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterLongStyle;

    return [dateFormatter stringFromDate:date];
}

@end
