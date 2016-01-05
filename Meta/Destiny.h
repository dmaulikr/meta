//
//  Destiny.h
//  Meta
//
//  Created by Matěj Sychra on 23/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DestinyDelegate <NSObject>
-(void)terminate;
@end

@interface Destiny : NSObject {
    NSTimer *existence;
}

@property (nonatomic, weak) id delegate;

@property (nonatomic, retain) NSDate *terminationDate; // private?
@property (nonatomic, retain) NSDate *creationDate; // private?
@property (nonatomic, retain) NSMutableArray *events;

@end
