//
//  ViewController.m
//  VariousLayer
//
//  Created by xinyu.wu on 2016/10/13.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [_dataArray addObject:@[@"CAReplicatorLayer-复制图层",@"CAReplicatorViewController"]];
    [_dataArray addObject:@[@"CAEmitterLayer-粒子图层",@"CAEmitterViewController"]];
    [_dataArray addObject:@[@"CAKeyframeAnimation-水波纹",@"CoinGetViewController"]];
    [_dataArray addObject:@[@"CAKeyframeAnimation-时钟",@"ClockViewController"]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSArray *titleArray = _dataArray[indexPath.row];
    cell.textLabel.text = titleArray[0];
    cell.detailTextLabel.text = titleArray[1];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = _dataArray[indexPath.row];
    
    NSString *class = titleArray[1];;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    UIViewController *vc = [[newClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
