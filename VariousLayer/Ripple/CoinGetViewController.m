//
//  CoinGetViewController.m
//  JDMobile
//
//  Created by xinyu.wu on 2016/10/14.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "CoinGetViewController.h"
#import "CoinGetColorView.h"
#import "CoinGetRippleView.h"

@interface CoinGetViewController ()

@property (nonatomic, strong) CoinGetColorView *colorView;
@property (nonatomic, strong) CoinGetRippleView *rippleView;

@property (nonatomic, strong) UILabel *benjinLabel;
@property (nonatomic, strong) UILabel *shouyiLabel;
@property (nonatomic, strong) UIButton *littleBtn;
@property (nonatomic, strong) UIButton *getBtn;
@property (nonatomic, strong) UILabel *getTitleLabel;
@property (nonatomic, strong) UILabel *getValueLabel;
@property (nonatomic, strong) UILabel *haveLabel;//本轮已经领取
@property (nonatomic, strong) UILabel *notiLabel;//记得每天领取哦

@end

@implementation CoinGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _colorView = [[CoinGetColorView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:_colorView];
    self.navigationItem.title = @"水波纹";
    self.navigationController.navigationBar.translucent = YES;
    
    [self createUI];
    [self createRippleView];
    [self createGetBtn];
    [self createDesLabel];
}

-(void)createUI
{
    _benjinLabel = [[UILabel alloc] init];
    _benjinLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    _benjinLabel.textColor = [UIColor whiteColor];
    _benjinLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_benjinLabel];
    
    _shouyiLabel = [[UILabel alloc] init];
    _shouyiLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    _shouyiLabel.textColor = [UIColor whiteColor];
    _shouyiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_shouyiLabel];
    
    _benjinLabel.text = @"本金: 10000元";
    CGSize size = [_benjinLabel.text sizeWithAttributes:@{NSFontAttributeName : _benjinLabel.font}];
    _benjinLabel.frame = CGRectMake(16, 64 + 40, size.width, size.height);

    
    _shouyiLabel.text = @"收益率: 0.2%";
    size = [_shouyiLabel.text sizeWithAttributes:@{NSFontAttributeName : _shouyiLabel.font}];    
    _shouyiLabel.frame = CGRectMake(CGRectGetMaxX(_benjinLabel.frame) + 60, CGRectGetMinY(_benjinLabel.frame), size.width, size.height);
}

-(void)createRippleView
{
    _rippleView = [[CoinGetRippleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_benjinLabel.frame) + 50, [UIScreen mainScreen].bounds.size.width, 320)];
    [self.view addSubview:_rippleView];
}


-(void)createGetBtn
{
    _getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getBtn.backgroundColor = [UIColor whiteColor];
    [_getBtn setImage:nil forState:UIControlStateNormal];
    [self.view addSubview:_getBtn];
    
    CGFloat getBtn_w = 182;
    _getBtn.layer.cornerRadius = getBtn_w/2.0;
    _getBtn.clipsToBounds = YES;
    _getBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - getBtn_w)*0.5, CGRectGetMaxY(_benjinLabel.frame) + 100, getBtn_w, getBtn_w);
    _getBtn.center = _rippleView.center;
    
    _getTitleLabel = [[UILabel alloc] init];
    _getTitleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    _getTitleLabel.textColor = [UIColor redColor];
    _getTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_getTitleLabel];
    
    _getValueLabel = [[UILabel alloc] init];
    _getValueLabel.font = [UIFont systemFontOfSize:30.0 weight:UIFontWeightMedium];
    _getValueLabel.textColor = [UIColor redColor];
    _getValueLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_getValueLabel];
    
    
    _getTitleLabel.text = @"今日可领取收益";
    _getValueLabel.text = @"3.55";
    _getTitleLabel.frame = CGRectMake(CGRectGetMinX(_getBtn.frame), CGRectGetMinY(_getBtn.frame) + 50, CGRectGetWidth(_getBtn.frame), 30);
    _getValueLabel.frame = CGRectMake(CGRectGetMinX(_getBtn.frame), CGRectGetMaxY(_getTitleLabel.frame) + 5, CGRectGetWidth(_getBtn.frame), 40);
}


-(void)createDesLabel
{
    _haveLabel = [[UILabel alloc] init];
    _haveLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    _haveLabel.textColor = [UIColor whiteColor];
    _haveLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_haveLabel];
    
    _notiLabel = [[UILabel alloc] init];
    _notiLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
    _notiLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    _notiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_notiLabel];
    
    _haveLabel.text = @"本轮已领: 5.46元";
    CGSize size = [_haveLabel.text sizeWithAttributes:@{NSFontAttributeName : _haveLabel.font}];
    _haveLabel.frame = CGRectMake(16, CGRectGetMaxY(_getBtn.frame) + 80, [UIScreen mainScreen].bounds.size.width - 16*2, size.height);
    
    _notiLabel.text = @"记得每天领取哦 未获取两天后过期";
    size = [_notiLabel.text sizeWithAttributes:@{NSFontAttributeName : _notiLabel.font}];
    _notiLabel.frame = CGRectMake(16, CGRectGetMaxY(_haveLabel.frame) + 10, [UIScreen mainScreen].bounds.size.width - 16*2, size.height);
    
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
