//
//  DrawBezierView.m
//  animationTest
//
//  Created by Jason Wang on 2017/8/25.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "DrawBezierView.h"

@implementation DrawBezierView

- (void)drawRect:(CGRect)rect{
    NSLog(@"------draw rect");
    CGSize size = self.bounds.size;
    CGFloat margin = 10;
    CGFloat radius = rintf(MIN(size.height - margin, size.width - margin) / 4);
    CGFloat xOffset, yOffset;
    CGFloat offset = rintf((size.height - size.width) / 2);
    if (offset > 0) {
        xOffset = rint(margin / 2);
        yOffset = offset;
    }else{
        xOffset = -offset;
        yOffset = rint(margin / 2);
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor greenColor] setFill];
    [path addArcWithCenter:CGPointMake(xOffset + radius *2, yOffset + radius)
                    radius:radius
                startAngle:-M_PI endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 3 + xOffset, radius * 2 + yOffset)
                    radius:radius
                startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 2 + xOffset, radius * 3 + yOffset)
                    radius:radius startAngle:0
                  endAngle:M_PI * 3 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius + xOffset, radius * 2 + yOffset)
                    radius:radius
                startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
    [path closePath];
    [path fill];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    CGPoint prefP = [touch previousLocationInView:self];
    self.transform = CGAffineTransformTranslate(self.transform, currentP.x - prefP.x, currentP.y - prefP.y);
}
- (void)startRotate{
    CGAffineTransform transform = CGAffineTransformRotate(self.transform, M_PI_2 );
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    [UIView setAnimationDelegate:self];
    self.transform = transform;
    [UIView commitAnimations];
}

@end
