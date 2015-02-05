//
//  Host.m
//  CATest
//
//  Created by Todd Ditchendorf on 2/5/15.
//  Copyright (c) 2015 Todd Ditchendorf. All rights reserved.
//

#import "Host.h"
#import "Shape.h"

@interface Host ()
@property (nonatomic, retain) CALayer *draggingLayer;
@end

@implementation Host

- (void)dealloc {
    self.draggingLayer = nil;
    [super dealloc];
}


- (BOOL)isFlipped {
    return YES;
}


- (id)animationForKey:(NSString *)key {
    return nil;
}


+ (id)defaultAnimationForKey:(NSString *)key {
    return nil;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setLayer:[CALayer layer]];
    [self setWantsLayer:YES];
    self.layer.geometryFlipped = YES;
    self.layer.autoresizingMask = kCALayerWidthSizable|kCALayerHeightSizable;
    self.layer.needsDisplayOnBoundsChange = YES;
    self.layer.name = @"host";

    // FILTERS
    self.layerUsesCoreImageFilters = YES;
    CIVector *center = [CIVector vectorWithX:NSMidX(self.bounds) Y:NSMidY(self.bounds)];
    TDAssert(center);
    CIFilter *pointillize = [CIFilter filterWithName:@"CIPointillize" keysAndValues:
                             kCIInputRadiusKey, @10.0,
                             kCIInputCenterKey, center,
                             nil];
    TDAssert(pointillize);

    // DELEGATE
    self.layer.delegate = self;
    TDAssert(self.layer);
    TDAssert(self == self.layer.delegate);
    
    // BOUNDS
    self.layer.frame = self.bounds;
    TDAssert(CGRectEqualToRect(self.bounds, self.layer.frame));
    
    CGColorRef strokeColor = CGColorCreateGenericRGB(1.0, 0.0, 0.0, 1.0);
    CGColorRef fillColor = CGColorCreateGenericRGB(0.0, 1.0, 0.0, 1.0);

//    // BORDER
//    self.layer.borderColor = strokeColor;
//    self.layer.borderWidth = 10.0;
//    
//    // FILL
//    self.layer.backgroundColor = fillColor;
//    
//    //FILTERS
//    self.layer.filters = @[pointillize];

    // ADD SHAPES
    Shape *shape = [[[Shape alloc] init] autorelease];
    
    shape.name = @"one";
    shape.frame = CGRectMake(100.0, 100.0, 40.0, 60.0);
    
//    shape.borderWidth = 10.0;
//    shape.borderColor = strokeColor;
//    shape.backgroundColor = fillColor;
    shape.filters = @[pointillize];
    
    [shape setNeedsDisplay];
    [self.layer addSublayer:shape];
    
    CGColorRelease(strokeColor);
    CGColorRelease(fillColor);
    
    [self.layer setNeedsDisplay];
}


- (id <CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)evtKey {
    return (id)[NSNull null];
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
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


- (void)mouseDown:(NSEvent *)evt {
    [super mouseDown:evt];
    
    CGPoint locInWin = [evt locationInWindow];
    CGPoint locInView = [self convertPoint:locInWin fromView:nil];
    
//    // WHY MUST I FLIP FOR HIT TEST???
//    CGAffineTransform flip = CGAffineTransformScale(CGAffineTransformMakeTranslation(0.0, self.bounds.size.height), 1.0, -1.0);
//    locInView = CGPointApplyAffineTransform(locInView, flip);
    
    CGPoint locInLayer = [self.layer convertPoint:locInView fromLayer:nil];

    CALayer *shape = [self.layer hitTest:locInLayer];

    if (self.layer != shape) {
        self.draggingLayer = shape;
    }
}


- (void)mouseDragged:(NSEvent *)evt {
    [super mouseDown:evt];
    
    CGPoint locInWin = [evt locationInWindow];
    CGPoint locInView = [self convertPoint:locInWin fromView:nil];

    if (_draggingLayer) {
        _draggingLayer.position = locInView;
    }
}


- (void)mouseUp:(NSEvent *)evt {
    [super mouseUp:evt];
    
//    CGPoint locInWin = [evt locationInWindow];
//    CGPoint locInView = [self convertPoint:locInWin fromView:nil];
    
    self.draggingLayer = nil;
}

@end
