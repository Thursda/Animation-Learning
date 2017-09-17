//
//  GraphView.m
//  animationTest
//
//  Created by Jason Wang on 2017/8/28.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "GraphView.h"

@interface GraphView()

@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation GraphView

const CGFloat kXScale = 5.0;
const CGFloat kYScale = 100.0;

static inline CGAffineTransform CGAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy, CGFloat dx, CGFloat dy){
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setContentMode:UIViewContentModeRight];
    self.values = [NSMutableArray array];
    
    __weak id weakself = self;
    double dalayInSeconds = 0.25;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer,
                              dispatch_walltime(NULL, 0),
                              (unsigned)(dalayInSeconds * NSEC_PER_SEC),
                              0);
    dispatch_source_set_event_handler(self.timer, ^{
        [weakself updateValues];
    });
    dispatch_resume(self.timer);
}

- (void)updateValues{
    double nextValue = sin(CFAbsoluteTimeGetCurrent()) + ((double)rand() / (double)(RAND_MAX));
    [self.values addObject:[NSNumber numberWithDouble:nextValue]];
    CGSize size = self.bounds.size;
    CGFloat maxDimension = MAX(size.height, size.width);
    NSUInteger maxValues = (NSUInteger)floorl(maxDimension / kXScale);
    if ([self.values count] > maxValues) {
        [self.values removeObjectsInRange:NSMakeRange(0, [self.values count] - maxValues)];
    }
    
    [self setNeedsDisplay];
}

- (void)dealloc{
    dispatch_source_cancel(self.timer);
}

- (void)drawRect:(CGRect)rect{
    if ([self.values count] == 0) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, 5.f);
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat yOffset = self.bounds.size.height / 2;
    CGAffineTransform transform = CGAffineTransformMakeScaleTranslate(kXScale, kYScale, 0, yOffset);
    CGFloat y = [[self.values objectAtIndex:0] floatValue];
    CGPathMoveToPoint(path, &transform, 0, y);
    
    for (NSUInteger x = 1; x < [self.values count]; ++x) {
        y = [[self.values objectAtIndex:x] floatValue];
        CGPathAddLineToPoint(path, &transform, x, y);
    }
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    CGContextStrokePath(ctx);

}


@end
