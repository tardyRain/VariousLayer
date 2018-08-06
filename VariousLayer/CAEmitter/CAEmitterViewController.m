//
//  CAEmitterViewController.m
//  VariousLayer
//
//  Created by xinyu.wu on 2016/10/13.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "CAEmitterViewController.h"

@interface CAEmitterViewController ()

@end

@implementation CAEmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //create particle emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    //configure emitter
    emitter.birthRate = 1;//每秒产生的粒子数
    emitter.renderMode = kCAEmitterLayerUnordered;//合并粒子重叠的部分使重叠部分更亮
    emitter.emitterShape = kCAEmitterLayerLine;//发射器的形状
    emitter.emitterMode = kCAEmitterLayerVolume;//发射模式
    emitter.emitterSize = CGSizeMake(200, 20);//发射源尺寸的大小
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, 100.0);//发射源的位置
    
    //create a particle template
    CAEmitterCell *cell0 = [self getCellContents:(__bridge id)[UIImage imageNamed:@"blue"].CGImage];
    CAEmitterCell *cell1 = [self getCellContents:(__bridge id)[UIImage imageNamed:@"bzx"].CGImage];
    CAEmitterCell *cell2 = [self getCellContents:(__bridge id)[UIImage imageNamed:@"rank"].CGImage];
    
    
    //add particle template to emitter
    emitter.emitterCells = @[cell0,cell1,cell2];
}

-(CAEmitterCell *)getCellContents:(id)content
{
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = content;
    cell.birthRate = arc4random()%3 + 1;//每秒产生的粒子数 与emitter.birthRate相乘得到最终的每秒发射的粒子数
    
#pragma mark --生命周期
    cell.lifetime = 20.0;//每个粒子的生命周期
    cell.lifetimeRange = 1;//生命周期浮动范围
    
    
#pragma mark ---颜色
    //cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.0 alpha:1.0].CGColor;//color设置了粒子的颜色，并设置了每个色值的浮动范围
    cell.redRange = 0;
    cell.greenRange = 0;
    cell.blueRange = 0;
    cell.alphaRange = 0;
    
    cell.redSpeed = 0;
    cell.greenSpeed = 0;
    cell.blueSpeed = 0;
    cell.alphaSpeed = 0;//每秒透明度递减0.4
    
    
#pragma mark --旋转角度
    cell.spin = 0;//旋转角度
    cell.spinRange = 0.25 * M_PI;//旋转范围
    
    
#pragma mark --初始速度
    cell.velocity = 100;//velcity指定了初速度
    cell.velocityRange = 50;//设置初速度在50到150(cell.velocity +- 50)之间浮动
    
    
#pragma mark --发射角度
    cell.emissionLongitude = -M_PI;//XY平面内与[Y]周方向的夹角 还与emitterShape有关
    cell.emissionLatitude = 0;//XZ平面内与X周方向的夹角
    cell.emissionRange = M_PI_4;//发射角度范围 emissionRange设置了一个范围，围绕着y轴负方向，建立了一个圆锥形，粒子从这个圆锥形的范围内打出
    
#pragma mark --加速度
    cell.xAcceleration = 0;//x方向的加速度
    cell.yAcceleration = 10;//y方向的加速度 沿y轴的加速度，用于给粒子减速
    cell.zAcceleration = 0;//z方向的加速度
    
    
#pragma mark --大小
    cell.scale = 1.;
    cell.scaleRange = 0.0 ; //0 - 1.6
    cell.scaleSpeed = -0.05 ; //每秒减小0.05
    
    return cell;
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
