//
//  WPFCircleView.m
//  FetalMovement
//
//  Created by PanFengfeng on 14-6-5.
//  Copyright (c) 2014年 Doit.im. All rights reserved.
//

#import "WPFCircleView.h"

@interface WPFCircleView () {
    CAShapeLayer *_ringLayer;
    CAShapeLayer *_ringGapLayer;
    CAShapeLayer *_innerCircleLayer;
}

@end

@implementation WPFCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ringLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_ringLayer];
        
        _ringGapLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_ringGapLayer];
        
        _innerCircleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_innerCircleLayer];
        
        self.progress = 1;
        self.radiusDiff = 4.;
        self.filledColorOfRing = [UIColor colorWithRed:0 green:0 blue:0 alpha:.1];
        self.filledColorOfInnerCircle = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    progress = MAX(0, MIN(1., progress));
    
    if (_progress == progress) {
        return;
    }
    
    [self willChangeValueForKey:@"progress"];
    _progress = progress;
    [self didChangeValueForKey:@"progress"];

    [self setNeedsLayout];
}


- (void)setRadiusDiff:(CGFloat)radiusDiff {
    if (_radiusDiff == radiusDiff) {
        return;
    }
    
    [self willChangeValueForKey:@"radiusDiff"];
    _radiusDiff = radiusDiff;
    [self didChangeValueForKey:@"radiusDiff"];
    
    [self setNeedsLayout];
}

- (void)setFilledColorOfRing:(UIColor *)filledColorOfRing {
    if ([_filledColorOfRing isEqual:filledColorOfRing]) {
        return;
    }
    
    [self willChangeValueForKey:@"filledColorOfRing"];
    _filledColorOfRing = filledColorOfRing;
    [self didChangeValueForKey:@"filledColorOfRing"];
    
    _ringLayer.fillColor = _filledColorOfRing.CGColor;
    
    [self setNeedsLayout];
}

- (void)setFilledColorOfInnerCircle:(UIColor *)filledColorOfInnerCircle {
    if ([_filledColorOfInnerCircle isEqual:filledColorOfInnerCircle]) {
        return;
    }
    
    [self willChangeValueForKey:@"filledColorOfInnerCircle"];
    _filledColorOfInnerCircle = filledColorOfInnerCircle;
    [self didChangeValueForKey:@"filledColorOfInnerCircle"];
    
    _innerCircleLayer.fillColor = _filledColorOfInnerCircle.CGColor;

    [self setNeedsLayout];
}

- (void)setFilledColorOfRingGap:(UIColor *)filledColorOfRingGap {
    if ([_filledColorOfRingGap isEqual:filledColorOfRingGap]) {
        return;
    }
    
    [self willChangeValueForKey:@"filledColorOfRingGap"];
    _filledColorOfRingGap = filledColorOfRingGap;
    [self didChangeValueForKey:@"filledColorOfRingGap"];
    
    _ringGapLayer.fillColor = _filledColorOfRingGap.CGColor;
    [self setNeedsDisplay];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2.0;
    CGFloat innerRadius = MAX(0., radius - self.radiusDiff);
    
    _innerCircleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                                                            radius:innerRadius
                                                        startAngle:0
                                                          endAngle:M_PI*2
                                                         clockwise:NO].CGPath;
    
    
    CGFloat startAngle = M_PI_2*3;
    CGFloat endAngle = startAngle - M_PI*2*self.progress;
    UIBezierPath *ringPath = [UIBezierPath bezierPath];
    [ringPath addArcWithCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                        radius:radius
                    startAngle:startAngle
                      endAngle:endAngle clockwise:NO];
    [ringPath addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + innerRadius*sin(- M_PI*2*self.progress),
                                         CGRectGetMidY(self.bounds) - innerRadius*cos(- M_PI*2*self.progress))];
    [ringPath addArcWithCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                        radius:innerRadius
                    startAngle:endAngle
                      endAngle:startAngle
                     clockwise:YES];
    [ringPath addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                         CGRectGetMidY(self.bounds) - radius)];
    _ringLayer.path = ringPath.CGPath;
    
    ringPath = [UIBezierPath bezierPath];
    [ringPath addArcWithCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                        radius:radius
                    startAngle:startAngle
                      endAngle:endAngle + M_PI*2
                     clockwise:YES];
    [ringPath addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + innerRadius*sin(- M_PI*2*self.progress),
                                         CGRectGetMidY(self.bounds) - innerRadius*cos(- M_PI*2*self.progress))];
    [ringPath addArcWithCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                        radius:innerRadius
                    startAngle:endAngle + M_PI*2
                      endAngle:startAngle
                     clockwise:NO];
    [ringPath addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                         CGRectGetMidY(self.bounds) - radius)];
    _ringGapLayer.path = ringPath.CGPath;
    
}

@end
