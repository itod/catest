//
//  Shape.m
//  CATest
//
//  Created by Todd Ditchendorf on 2/5/15.
//  Copyright (c) 2015 Todd Ditchendorf. All rights reserved.
//

#import "Shape.h"

@implementation Shape

//+ (id <CAAction>)defaultActionForKey:(NSString *)key {
//    return nil;
//}
//
//
//+ (id)defaultAnimationForKey:(NSString *)key {
//    return nil;
//}
//
//
- (id <CAAction>)actionForKey:(NSString *)key {
    return nil;
}
//
//
//- (id)animationForKey:(NSString *)key {
//    return nil;
//}


- (void)drawInContext:(CGContextRef)ctx {
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    
    // FILL
    CGColorRef blue = CGColorCreateGenericRGB(0.0, 0.0, 1.0, 1.0);
    CGContextSetFillColorWithColor(ctx, blue);
    CGColorRelease(blue);
    CGContextFillRect(ctx, bounds);
    
    // STROKE
    CGColorRef orange = CGColorCreateGenericRGB(1.0, 153.0/255.0, 0.0, 1.0);
    CGContextSetStrokeColorWithColor(ctx, orange);
    CGColorRelease(orange);
    CGRect borderRect = [self borderRectForBounds:bounds];
    CGContextSetLineWidth(ctx, 10.0);
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
