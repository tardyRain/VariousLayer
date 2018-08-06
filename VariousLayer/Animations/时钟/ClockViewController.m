//
//  ClockViewController.m
//  VariousLayer
//
//  Created by xinyu.wu on 2016/11/8.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "ClockViewController.h"
#import "ClockView.h"

@interface ClockViewController ()
<
UITextFieldDelegate
>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic, strong) ClockView *clockFace;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"时钟";
    
    [self createTextField];
    [self createClockView];
    [self createTimeBtn];
    [self createTimer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
}

-(void)createTextField
{
    self.textField = [[UITextField alloc] init];
    self.textField.text = @"0";
    self.textField.delegate = self;
    self.textField.bounds = CGRectMake(0, 0, 200, 50);
    self.textField.center = CGPointMake(self.view.center.x, 100);
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
}

-(void)createClockView
{
    self.clockFace = [[ClockView alloc] init];
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, 300);
    [self.view.layer addSublayer:self.clockFace];
}

-(void)createTimeBtn
{
    _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_switchBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_switchBtn setTitle:@"停止" forState:UIControlStateSelected];
    [_switchBtn setBounds:CGRectMake(0, 0, 100, 50)];
    [_switchBtn setBackgroundColor:[UIColor orangeColor]];
    [_switchBtn setCenter:CGPointMake(self.view.center.x, CGRectGetMaxY(self.clockFace.frame) + 100)];
    [_switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_switchBtn];
    
}

/*
    应用场景举例：主线程的 RunLoop 里有两个预置的 Mode：kCFRunLoopDefaultMode 和 UITrackingRunLoopMode。这两个 Mode 都已经被标记为"Common"属性。DefaultMode 是 App 平时所处的状态，TrackingRunLoopMode 是追踪 ScrollView 滑动时的状态。当你创建一个 Timer 并加到 DefaultMode 时，Timer 会得到重复回调，但此时滑动一个TableView时，RunLoop 会将 mode 切换为 TrackingRunLoopMode，这时 Timer 就不会被回调，并且也不会影响到滑动操作。
 
    有时你需要一个 Timer，在两个 Mode 中都能得到回调，一种办法就是将这个 Timer 分别加入这两个 Mode。还有一种方式，就是将 Timer 加入到顶层的 RunLoop 的 "commonModeItems" 中。"commonModeItems" 被 RunLoop 自动更新到所有具有"Common"属性的 Mode 里去。
 */

/*
 *NSDefaultRunLoopMode
 *The mode to deal with input sources other than NSConnection objects.默认模式是为了处理除了NSConnection以外的输入源
 */

/*
 *NSEventTrackingRunLoopMode
 *A run loop should be set to this mode when tracking events modally, such as a mouse-dragging loop.
 */

/*
 *NSRunLoopCommonModes
 *Objects added to a run loop using this value as the mode are monitored by all run loop modes that have been declared as a member of the set of “common" modes; see the description of CFRunLoopAddCommonMode for details.
 */

/*
 *NSModalPanelRunLoopMode
 *A run loop should be set to this mode when waiting for input from a modal panel, such as NSSavePanel or NSOpenPanel.
 */

-(void)createTimer
{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)timerAction
{
    self.clockFace.time += 1;
}

-(void)switchBtnClick:(UIButton *)btn
{
    if (btn.selected) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }else{
        [self.timer setFireDate:[NSDate distantPast]];
    }
    btn.selected = !btn.selected;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.switchBtn.selected = NO;
    [self.timer setFireDate:[NSDate distantFuture]];
    
    self.clockFace.time = [textField.text floatValue];
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
