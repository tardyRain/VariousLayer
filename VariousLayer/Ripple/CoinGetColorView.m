//
//  CoinGetColorView.m
//  JDMobile
//
//  Created by xinyu.wu on 2016/10/14.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "CoinGetColorView.h"

@implementation CoinGetColorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    
    [self makeNew];
}

-(void)makeNew
{
    //在计算机设置中，直接选择rgb即可，其他颜色空间暂时不用考虑。
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //1.创建渐变
    /*
     1.<#CGColorSpaceRef space#> : 颜色空间 rgb
     2.<#const CGFloat *components#> ： 数组 每四个一组 表示一个颜色 ｛r,g,b,a ,r,g,b,a｝
     3.<#const CGFloat *locations#>:表示渐变的开始位置
     
     */
    
    float red,green,blue;
    red = 234/255.0;
    green = 63/255.0;
    blue = 86/255.0;
    
    float red1,green1,blue1;
    red1 = 255/255.0;
    green1 = 133/255.0;
    blue1 = 69/255.0;
    
    CGFloat components[8] = {
        red, green, blue, 1.00,
        red1, green1, blue1, 1.00,
    };;
    CGFloat locations[2] = {0.0,1.0};
    
    CGGradientRef gradient=CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //渐变区域裁剪
    //    CGContextClipToRect(context, CGRectMake(0, 360, 200, 100));
    //CGRect rect[5] = {CGRectMake(0, 0, 100, 100),CGRectMake(100, 100, 100, 100),CGRectMake(200, 0, 100, 100),CGRectMake(0, 200, 100, 100),CGRectMake(200, 200, 100, 100)};
    //CGContextClipToRects(context, rect, 5);
    
    CGPoint start = CGPointMake(0, CGRectGetHeight(self.frame));
    CGPoint end = CGPointMake(CGRectGetWidth(self.frame), 0);
    
    //绘制渐变
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsAfterEndLocation);
    //释放对象
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}


@end
