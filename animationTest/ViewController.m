//
//  ViewController.m
//  animationTest
//
//  Created by Jason Wang on 2017/8/10.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "ViewController.h"
#import "LoadingAnimationView1.h"
#import "DrawBezierView.h"
#import "GraphView.h"
#import "MCJoinViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet LoadingAnimationView1 *animationView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic, strong) DrawBezierView *bezierPathView;
@property (nonatomic, strong) GraphView *graphView;

@end

@implementation ViewController

- (DrawBezierView *)bezierPathView{
    if (!_bezierPathView) {
        CGSize size = self.view.frame.size;
        CGRect rect = CGRectMake(0, self.view.center.y - size.width / 2, size.width  / 2, size.width / 2);
        _bezierPathView = [[DrawBezierView alloc] initWithFrame:rect];
        _bezierPathView.backgroundColor = [UIColor clearColor];
        _bezierPathView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bezierPathView;
}

- (GraphView *)graphView{
    if (!_graphView) {
        _graphView = [[GraphView alloc] initWithFrame:self.view.bounds];
        _graphView.backgroundColor = [UIColor blueColor];
    }
    return _graphView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.graphView];
    
    [self.view addSubview:self.bezierPathView];
//    self.animationView.hidden = YES;
    [self.bezierPathView startRotate];
    [self.view bringSubviewToFront:self.startButton];
    
//    self.animationView = [[LoadingAnimationView1 alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:self.animationView];
//    [self.view bringSubviewToFront:self.animationView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startSuccessButtonPressed:(UIButton *)sender {
    
//    MCJoinViewController *rooVc = [[MCJoinViewController alloc] initWithNibName:@"MCJoinViewController"
//                                                                         bundle:[NSBundle mainBundle]];
//    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:rooVc];
//    [self presentViewController:navi animated:YES completion:nil];
}


@end
