//
//  LoadingAnimationView1.m
//  animationTest
//
//  Created by Jason Wang on 2017/8/11.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "LoadingAnimationView1.h"
#import "ArcToCircleLayer.h"

static const CGFloat kRedius = 40;
static const CGFloat kLineWidth = 12;
static const CGFloat kStep1Duration = 1.0;

@interface LoadingAnimationView1()

@property (nonatomic, strong) ArcToCircleLayer *arcToCircleLayer;

@end

@implementation LoadingAnimationView1

# pragma mark - public
- (void)startAnimation{
    [self reset];
    [self doStep1];
}
# pragma mark - animation

- (void)reset{
    [self.arcToCircleLayer removeFromSuperlayer];
}
- (void)doStep1{
    self.arcToCircleLayer = [ArcToCircleLayer layer];
    self.arcToCircleLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.arcToCircleLayer];
    self.arcToCircleLayer.bounds = CGRectMake(0, 0, (kRedius + kLineWidth) * 2,  2 * (kRedius +kLineWidth));
    self.arcToCircleLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    

    self.arcToCircleLayer.progress = 1; //end status
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = kStep1Duration;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.autoreverses = NO;
    [self.arcToCircleLayer addAnimation:animation forKey:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
