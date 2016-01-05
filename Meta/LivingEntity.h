//
//  LivingEntity.h
//  Meta
//
//  Created by Matěj Sychra on 23/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import "Destiny.h"
#import "Configuration.h"

@interface LivingEntity : NSObject <DestinyDelegate>

-(instancetype)initWithGender:(int)genderId;

// This seems like god requires a protocol!
@property (nonatomic, weak) id godDelegate;

@property (nonatomic, assign) Gender gender;
@property (nonatomic, retain) Destiny *destiny;
@property (nonatomic, retain) NSNumber *entityLove;

// DestinyDelegate protocol
-(void)terminate;

@end
