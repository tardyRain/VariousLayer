//
//  CoinGetRippleView.m
//  JDMobile
//
//  Created by xinyu.wu on 2016/10/16.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "CoinGetRippleView.h"

@implementation CoinGetRippleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeRipple];
    }
    return self;
}

-(void)makeRipple
{
    CGFloat _radus = 180;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((CGRectGetWidth(self.frame) - _radus)*0.5, (CGRectGetHeight(self.frame) - _radus)*0.5, _radus, _radus)];
    CAShapeLayer *_sharpLayer = [CAShapeLayer layer];
    _sharpLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _sharpLayer.path = path.CGPath;
    _sharpLayer.lineWidth = 2.0;
    _sharpLayer.strokeColor = [UIColor colorWithRed:255/255.0 green:209/255.0 blue:80/255.0 alpha:0.5].CGColor;
    _sharpLayer.fillColor = [UIColor clearColor].CGColor;
    
    _sharpLayer.strokeColor = [UIColor colorWithRed:255/255.0 green:209/255.0 blue:80/255.0 alpha:0.5].CGColor;
    _sharpLayer.shadowOffset = CGSizeMake(0, 0);
    _sharpLayer.shadowRadius = 3.0;
    
    //给【柱状图】添加动画
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    move.toValue = [NSNumber numberWithFloat:(CGRectGetHeight(self.frame)/_radus)];
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
    opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.fillMode = kCAFillModeBackwards;
    animationGroup.duration = 3;
    animationGroup.repeatCount = HUGE;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animationGroup.animations = @[move, opacityAnimation];
    
    [_sharpLayer addAnimation:animationGroup forKey:@"AnimationGroup"];
    
    
    CAReplicatorLayer *r = [CAReplicatorLayer layer];
    r.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));;
    [r addSublayer:_sharpLayer];
    [self.layer addSublayer:r];
    //设置复制
    r.instanceCount = 4;//复制的数量
    r.repeatCount = CGFLOAT_MAX;
    //r.instanceTransform = CATransform3DMakeTranslation(20.0, 0, 0);//柱状图相对于【上一个】的X方向的位移
    r.instanceDelay = animationGroup.duration/r.instanceCount;//柱状图相对于【上一个】的显示时间的延迟
    r.masksToBounds = YES;//裁剪
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
