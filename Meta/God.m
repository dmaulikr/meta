//
//  Meta.m
//  Meta
//
//  Created by Matěj Sychra on 22/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "God.h"
#import "LivingEntity.h"
#import "Destiny.h"

#include <stdlib.h>

@implementation God

/* etaobject is initialized with 'god' values by default */

-(id)init
{
    self = [super init];

    if (self) {

        float l = (float)rand() / RAND_MAX;
        float p = (float)rand() / RAND_MAX;
        float e = (float)rand() / RAND_MAX;

        _love = [NSNumber numberWithFloat:l];
        _peace = [NSNumber numberWithFloat:p];
        _eternity = [NSNumber numberWithFloat:e];

#ifdef DEBUG_NEW_GODS
        NSLog(@"-[god] new god: l:%f p:%f e:%f", l, p, e);
#endif

        // Anthropomorfic limit: I have started to create this Universe at certain time.
        // God is always created in real time and can not do anything with it

        NSDate * now = [NSDate date];
        _creationDate = now;
        _existenceDatesArray = [NSMutableArray arrayWithObject:now];

        // Lifetime
        existenceTermination = [NSTimer scheduledTimerWithTimeInterval:fabs(e) target:self selector:@selector(existenceWillTerminate) userInfo:nil repeats:NO];

        // God is not necessarily living entity, but has destiny... As well as things. A house could have destiny and create living entities with its love.
        self.destiny = [Destiny new];
        self.destiny.terminationDate = [NSDate dateWithTimeIntervalSinceNow:fabs(e)];
        self.destiny.creationDate = _creationDate;

        // When god gets bored, it will create more entities...
        float boredom = fabsf((float)rand() / RAND_MAX - fabs(e));
        existenceEvent = [NSTimer scheduledTimerWithTimeInterval:boredom target:self selector:@selector(create) userInfo:nil repeats:NO];
    }

    return self;
}


-(id)initWithLove:(NSNumber*)love peace:(NSNumber*)peace eternity:(NSNumber*)eternity
{
    self = [super init];

    if (self) {
        _love = love;
        _peace = peace;
        _eternity = eternity;
    }

    return self;
}

-(NSNumber*)light
{
    // When the object is queried, it exists (schrödinger's cat principle)

    [self recordExistence];

    return [NSNumber numberWithFloat:([_love floatValue] * [_peace floatValue] * [_eternity floatValue])];
}

-(void)recordExistence
{
    [_existenceDatesArray addObject:[NSDate date]];
}

// TODO: implement delegate method UniverseDelegateTerminate before the dimension dies
-(void)spaceWillTerminate
{
    NSLog(@"%@ dies with its dimension.", self);
}

-(void)existenceWillTerminate
{
    NSLog(@"%@ dies on its own.", self);

    [self recordExistence];

    [self flushExistence];
}

-(void)flushExistence
{
    NSLog(@"-[god] flushing existences at:\n %@", _existenceDatesArray);
}

// Creation of Base Entities

-(void)create
{
    NSMutableArray *dimensionEntities = [self.dimension entities];

    int count = rand() * MAX_DIMENSION_GODS/RAND_MAX;

    for (int c = 0; c <= count; c++) {
        // Random number of 'genders' up till defined maximum
        Gender g = floorf(rand() * MAX_GOD_GENDER_COUNT / RAND_MAX);
        NSLog(@"-[god] has decided to create %i living entities.", g);
        
        for (int i = 0; i <= g; i++) {

            [self recordExistence];

            // Initialize adam with its destiny (empty with creation date)
            LivingEntity *anyGenderType = [[LivingEntity alloc] initWithGender:i];
            
            // Share the love (love does not divide between entities, but is exponential with distance, add 1 for at least one god as a love source
            anyGenderType.entityLove = [NSNumber numberWithDouble:self.love.doubleValue * 1 + 1/self.dimension.entities.count+1];

            // Create expiration date
            NSDate *end = self.dimension.judgementDay;
            NSTimeInterval maxAge = ([[NSDate date] timeIntervalSinceReferenceDate] - [end timeIntervalSinceReferenceDate]);
            NSTimeInterval age = fabs((float)rand() * MAX_ENTITY_ENDURANCE / RAND_MAX);
            if (age > maxAge) age = maxAge; // clamp MAX_ENTITY_ENDURANCE with judgementDay

            anyGenderType.destiny.terminationDate = [NSDate dateWithTimeIntervalSinceNow:age];

            NSLog(@"-[god] %@ is adding entity %@ with expiration %f seconds", self, [anyGenderType description], age);

            [dimensionEntities addObject:anyGenderType];
        }
    }
}

-(void)universeWillTerminate
{
    // Universe delegate protocol
    NSLog(@"-[god] universeWillTerminate: %@ with %i entities.", self, self.dimension.entities.count);
}

-(void)entityDiedWithLove:(NSNumber*)love
{
    self.love = [NSNumber numberWithDouble:self.love.doubleValue + love.doubleValue];
}

@end
