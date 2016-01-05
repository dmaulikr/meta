//
//  Universe.h
//  Meta
//
//  Created by Matěj Sychra on 23/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Dimension.h"

#import "Configuration.h"

@interface Universe : NSObject {
    NSTimer *masterClock;
}

@property (nonatomic, retain) NSMutableArray *dimensions;

@property (nonatomic, assign) BOOL useExternalClock;

// external timer latch
-(void)updateUniverse;

@end
