//
//  ArcToCircleLayer.m
//  animationTest
//
//  Created by Jason Wang on 2017/8/10.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "ArcToCircleLayer.h"
#import <UIKit/UIKit.h>

static  CGFloat const kLineWidth = 12;

@implementation ArcToCircleLayer

@dynamic progress;

+ (BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}


- (void)drawInContext:(CGContextRef)ctx{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat redius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2 - kLineWidth / 2;
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    //Origin
    CGFloat originStart = M_PI * 7 / 2;
    CGFloat originEnd = M_PI * 2;
    CGFloat currentOrigin = originStart - (originStart - originEnd) * self.progress;
    
    //Destination
    CGFloat destStart = M_PI * 3;
    CGFloat destEnd = M_PI * 0;
    CGFloat currentDest = destStart - (destStart - destEnd) * self.progress;
    
    [path addArcWithCenter:center radius:redius startAngle:currentOrigin endAngle:currentDest clockwise:NO];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, kLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextStrokePath(ctx);
    
}

@end
