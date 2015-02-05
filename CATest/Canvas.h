//
//  Canvas.h
//  CATest
//
//  Created by Todd Ditchendorf on 2/5/15.
//  Copyright (c) 2015 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Host;

@interface Canvas : NSView

@property (nonatomic, retain) IBOutlet Host *host;
@end
