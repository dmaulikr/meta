//
//  ViewController.h
//  Meta
//
//  Created by Matěj Sychra on 22/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CADisplayLink.h>
#import "Universe.h"

@interface ViewController : UIViewController {
    NSTimer *bigBangTimer; // schedules the updateTimer
    NSTimer *updateTimer; // the universe UI clock
    Universe *vsehomiry; // all the Dimensions in this Space/Universe

    id displayLink; // VSYNC
}

@end

