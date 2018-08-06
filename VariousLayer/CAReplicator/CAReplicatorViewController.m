//
//  CAReplicatorViewController.m
//  VariousLayer
//
//  Created by xinyu.wu on 2016/10/13.
//  Copyright © 2016年 desire.wu. All rights reserved.
//
/*本篇内容来源于
 *http://www.jianshu.com/p/76c588893b19
 */

#import "CAReplicatorViewController.h"

@interface CAReplicatorViewController ()

@end

@implementation CAReplicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //打开某一个
//    [self animation1];
//    [self animation2];
    [self animation3];
}

//基本复制动画
-(void)animation1
{
    CAReplicatorLayer *r = [CAReplicatorLayer layer];
    r.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 300)*0.5, 64, 300, 300);
    r.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.view.layer addSublayer:r];
    
    //设置一个柱状图layer，放到CAReplicatorLayer上
    CALayer *bar = [CALayer layer];
    bar.bounds = CGRectMake(0, 0, 8.0, 40.0);
    bar.position = CGPointMake(10.0, CGRectGetHeight(r.frame) + 20);
    bar.cornerRadius = 2.0;
    bar.backgroundColor = [self randomColor].CGColor;
    [r addSublayer:bar];
    
    //给【柱状图】添加动画
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position.y"];
    move.toValue = [NSNumber numberWithFloat:bar.position.y - 35];
    move.duration = 0.5;
    move.autoreverses = YES;
    move.repeatCount = CGFLOAT_MAX;
    [bar addAnimation:move forKey:@"nil"];
    
    //设置复制
    r.instanceCount = 10;//复制的数量
    r.instanceTransform = CATransform3DMakeTranslation(20.0, 0, 0);//柱状图相对于【上一个】的X方向的位移
    r.instanceDelay = 0.33;//柱状图相对于【上一个】的显示时间的延迟
    r.masksToBounds = YES;//裁剪
}

//活动指示灯动画
-(void)animation2
{
    CAReplicatorLayer *r = [CAReplicatorLayer layer];
    r.bounds = CGRectMake(0, 0, 200, 200);
    r.cornerRadius = 10.0;
    r.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    r.position = self.view.center;
    [self.view.layer addSublayer:r];
    
    CALayer *dot = [CALayer layer];
    dot.bounds = CGRectMake(0, 0, 14.0, 14.0);
    dot.position = CGPointMake(100, 40);
    dot.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    dot.borderColor = [[UIColor colorWithWhite:1.0 alpha:1.0] CGColor];
    dot.borderWidth = 1.0;
    dot.cornerRadius = 2.0;
    [r addSublayer:dot];
    
    NSInteger nrDots = 15;
    r.instanceCount = nrDots;
    CGFloat angle = (2*M_PI)/(CGFloat)nrDots;
    r.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0);
    
    CFTimeInterval duration = 1.5;
    CABasicAnimation *shrink = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrink.fromValue = @(1.0);
    shrink.toValue = @(0.1);
    shrink.duration = duration;
    shrink.repeatCount = CGFLOAT_MAX;
    [dot addAnimation:shrink forKey:nil];
    
    //延时变化
    r.instanceDelay = duration/(double)(nrDots);
    //设置刚创建时 不显示
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}


-(void)animation3
{
    CAReplicatorLayer *r = [CAReplicatorLayer layer];
    r.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    r.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75].CGColor;
    r.position = self.view.center;
    [self.view.layer addSublayer:r];
    
    //创建小球
    CALayer *dot = [CALayer layer];
    dot.bounds = CGRectMake(0, 0, 10.0, 10.0);
    dot.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    dot.borderColor = [[UIColor colorWithWhite:1.0 alpha:1.0] CGColor];
    dot.borderWidth = 1.0;
    dot.cornerRadius = 5.0;
    dot.shouldRasterize = YES;
    dot.rasterizationScale = [UIScreen mainScreen].scale;
    [r addSublayer:dot];
    
    //设置关键帧动画
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.path = [self rw];
    move.duration = 4.0;
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//匀速动画
    move.repeatCount = CGFLOAT_MAX;
    [dot addAnimation:move forKey:@"nil"];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 1;
    layer.path = [self rw];
    [self.view.layer addSublayer:layer];
    
    
    r.instanceCount = 20;
    r.instanceDelay = 0.2;
    r.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0].CGColor;
    r.instanceRedOffset = -0.02;//红色每次递减0.02. 设置了instanceColor有效
    r.instanceGreenOffset = -0.03;
    r.instanceBlueOffset = -0.04;
    r.instanceAlphaOffset = -0.02;
}

//设置小球的路径
-(CGPathRef)rw
{
    //点的坐标是相对于self.view的坐标
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:(CGPointMake(31.5, 78.5))];
    [bezierPath addLineToPoint:(CGPointMake(31.5, 23.5))];
    [bezierPath addCurveToPoint:CGPointMake(58.5, 38.5) controlPoint1:CGPointMake(31.5, 23.5) controlPoint2:CGPointMake(62.46, 18.69)];
    [bezierPath addCurveToPoint:CGPointMake(53.5, 45.5) controlPoint1:CGPointMake(57.5, 43.5) controlPoint2:CGPointMake(53.5, 45.5)];
    [bezierPath addLineToPoint:(CGPointMake(43.5, 48.5))];
    [bezierPath addLineToPoint:(CGPointMake(53.5, 66.5))];
    [bezierPath addLineToPoint:(CGPointMake(62.5, 51.5))];
    [bezierPath addLineToPoint:(CGPointMake(70.5, 66.5))];
    [bezierPath addLineToPoint:(CGPointMake( 86.5, 23.5))];
    [bezierPath addLineToPoint:(CGPointMake(86.5, 78.5))];
    [bezierPath closePath];
    
    //设置transform可以使图形整体变大、包括点的坐标也会变大3倍
    CGAffineTransform T = CGAffineTransformMakeScale(3.0, 3.0);
    
    return CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &T);
}


-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
