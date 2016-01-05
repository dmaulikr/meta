//
//  LivingEntity.m
//  Meta
//
//  Created by Matěj Sychra on 23/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import "LivingEntity.h"

@implementation LivingEntity

-(instancetype)initWithGender:(int)genderId
{
    self = [super init];

    if (self) {
        self.gender = genderId;
        self.destiny = [Destiny new];
        self.destiny.creationDate = [NSDate date];
        self.entityLove = @1.0f;

        NSLog(@"-[entity] %@ new gender %i", self, self.gender);
    }

    return self;
}

// TODO: In case the entity decides to worship a god, call "prayWithLove:(NSNumber*)love" method.
// NOTE: Does not require casualties.

/** Even atheists call 'That' (god) quite often, as seen on the planet Earth. */
-(void)terminate
{
    NSLog(@"%@ returning %f love to god", self, self.entityLove.floatValue);
    
    if (self.godDelegate != nil) {
        SEL death = NSSelectorFromString(@"entityDiedWithLove:");
        if ([self.godDelegate respondsToSelector:death]) {
            [self.godDelegate performSelector:death withObject:self.entityLove afterDelay:0];
        }
    }
}

@end
