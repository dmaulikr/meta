//
//  MetaTests.m
//  MetaTests
//
//  Created by Matěj Sychra on 22/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Universe.h"
#import "God.h"

@interface MetaTests : XCTestCase

@end

@implementation MetaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testALove
{
    XCTAssert([[God new] respondsToSelector:@selector(love)], @"Pass");
}

- (void)testAPeace
{
    XCTAssert([[God new] respondsToSelector:@selector(peace)], @"Pass");
}

- (void)testAEternity
{
    XCTAssert([[God new] respondsToSelector:@selector(eternity)], @"Pass");
}

- (void)testSpaceList
{
    Universe *spacelist = [Universe new];

    NSLog(@"spacelist: %@", [spacelist description]);

    XCTAssert(spacelist != nil, @"Pass");
}



- (void)testExample {

    NSNumber *light = nil;

    // Meta *god = [[Meta alloc] initWith

    God *mymeta = [[God alloc] initWithLove:@0.3f peace:@0.3f eternity:@0.3f];

    light = [mymeta light];

    XCTAssert(mymeta != nil, @"Pass");
}


@end
