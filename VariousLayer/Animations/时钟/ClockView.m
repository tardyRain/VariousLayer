//
//  ClockView.m
//  VariousLayer
//
//  Created by xinyu.wu on 2016/11/8.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView
@dynamic time;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 200, 200);
        self.time = 5400;
    }
    return self;
}

/*
 *覆写
 *无论何时time属性被修改，它都需要调用-display方法。现在我们就覆写-display方法
 */
+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([@"time" isEqualToString:key])
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}


/*
 *覆写
 *我们希望time属性能在旧值和新值之间在几帧之内做一个平滑的过渡动画。为了实现这一点，我们需要为time属性指定一个动画（或“动作（action）”），
 *而通过覆写-actionForKey:方法就能做到
 */
- (id<CAAction>)actionForKey:(NSString *)key
{
    if ([key isEqualToString:@"time"]){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = @(self.time);
        return animation;
    }
    return [super actionForKey:key];
}

/*
 *覆写
 *如果我们再次设置time属性，我们就会看到-display被多次调用。调用的次数大约为每秒 60 次，至于动画的长度，默认为 0.25 秒，大约是 15 帧：
 */

- (void)display
{
    NSLog(@"time: %ld", [[self presentationLayer] time]);
    
    // 获取时间插值
    NSInteger curTime = [self.presentationLayer time];
    
    // 创建绘制上下文
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 绘制时钟面板
    CGContextSetLineWidth(ctx, 4);
    CGContextStrokeEllipseInRect(ctx, CGRectInset(self.bounds, 2, 2));
    
    // 绘制时针
    CGFloat hour = curTime/3600;
    CGFloat angle = hour / 12.0 * 2.0 * M_PI;
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGContextSetLineWidth(ctx, 4);
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, center.x + sin(angle) * 70, center.y - cos(angle) * 70);
    CGContextStrokePath(ctx);
    
    // 绘制分针
    NSInteger m = (curTime%3600)/60;
    angle = m / 60.0 * 2.0 * M_PI;
    CGContextSetLineWidth(ctx, 2);
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, center.x + sin(angle) * 80, center.y - cos(angle) * 80);
    CGContextStrokePath(ctx);
    
    //绘制秒针
    NSInteger s = curTime%60;
    angle = s / 60.0 * 2.0 *M_PI;
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, center.x + sin(angle) * 90, center.y - cos(angle) * 90);
    CGContextStrokePath(ctx);
    
    //set backing image 设置 contents
    self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
