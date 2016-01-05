//
//  ViewController.m
//  Meta
//
//  Created by Matěj Sychra on 22/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import "ViewController.h"
#import "Dimension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self bigBang];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (displayLink == nil)
    {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
        [displayLink setFrameInterval:12]; // 5 fps should be enough
    }

    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [displayLink invalidate]; displayLink = nil;
}

- (void)update:(CADisplayLink*)sender
{
    [self update];
}

/**
 * Create new universe and pass timing to updateTimer (repeating to update visuals for spectator)
 */

-(void)bigBang
{
    bigBangTimer = nil;

    NSLog(@"");
    NSLog(@"-[ui] ********************************");
    NSLog(@"-[ui] **          BIG BANG          **");
    NSLog(@"-[ui] ********************************");

    // Initialize universe (creates 
    vsehomiry = [[Universe alloc] init];

    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
}


/**
 * If universe count falls to zero, invalidate all timers and switch universe to 'boredom' state with random timer for next big bang
 */

-(void)update
{
    // Forced clock
    [vsehomiry setUseExternalClock:NO];
    [vsehomiry updateUniverse];

    int dimension_count = [[vsehomiry dimensions] count];

    if (dimension_count == 0) {
        if (bigBangTimer == nil) {
            NSLog(@"-[ui] No dimensions living.");
        } else {
            double time = [[NSDate date] timeIntervalSinceReferenceDate] - [bigBangTimer.fireDate timeIntervalSinceReferenceDate] + [bigBangTimer timeInterval];
            NSLog(@"-[ui] Big bang in %f seconds", -time);
        }
    }

    if ((dimension_count == 0) && bigBangTimer == nil) {

        if (updateTimer) {
            [updateTimer invalidate]; updateTimer = nil;
        }

        vsehomiry = nil;

        double maxBoredom = fabs((float)rand()/100000000);

        NSLog(@"-[ui] Scheduled BigBang timer in %1.0f seconds at %@", maxBoredom, [NSDate dateWithTimeIntervalSinceNow:maxBoredom]);

        bigBangTimer = [NSTimer scheduledTimerWithTimeInterval:maxBoredom target:self selector:@selector(bigBang) userInfo:nil repeats:NO];
    }
}



@end
