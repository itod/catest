//
//  Canvas.m
//  CATest
//
//  Created by Todd Ditchendorf on 2/5/15.
//  Copyright (c) 2015 Todd Ditchendorf. All rights reserved.
//

#import "Canvas.h"
#import "Host.h"

@implementation Canvas

- (void)dealloc {
    self.host = nil;
    [super dealloc];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    TDAssert(_host);
}


- (BOOL)isFlipped {
    return YES;
}
    

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    CGRect bounds = self.bounds;
    
    // FILL
    [[NSColor whiteColor] setFill];
    CGContextFillRect(ctx, dirtyRect);
    
    // STROKE
    [[NSColor blackColor] setStroke];
    CGRect borderRect = [self borderRectForBounds:bounds];
    CGContextStrokeRect(ctx, borderRect);
}


- (CGRect)borderRectForBounds:(CGRect)bounds {
    CGFloat x = NSMinX(bounds)+0.5;
    CGFloat y = NSMinY(bounds)+0.5;
    CGFloat w = NSWidth(bounds)-1.0;
    CGFloat h = NSHeight(bounds)-1.0;
    
    CGRect r = CGRectMake(x, y, w, h);
    return r;
}

@end
