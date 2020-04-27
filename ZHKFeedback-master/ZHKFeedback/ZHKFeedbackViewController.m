//
//  ZHKFeedbackViewController.m
//  ZHKFeedback
//
//  Created by ZHK on 2018/6/5.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "ZHKFeedbackViewController.h"
#import "ZHKFeedbackMacros.h"
#import "ZHKFeedbackTextView.h"
#import <Masonry/Masonry.h>

#define PADDING 15.0
#define TEXT_VIEW_HEIGHT 150.0

@interface ZHKFeedbackViewController ()

@property (nonatomic, strong) ZHKFeedbackTextView *textView;
@property (nonatomic, strong) UIButton       *submitButton;
@property (nonatomic, strong) UIButton       *appraiseButton;
@property (nonatomic, strong) UILabel       *tipLabel;;
@property (nonatomic,strong)NSTimer* timer;
@end

@implementation ZHKFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户反馈";
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI

- (void)createUI {
   
    self.view.backgroundColor = ZHK_COLOR(245, 245, 245, 1);
 
    [self.view addSubview:[UIView new]];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.appraiseButton];
       
//     self.navigationController.navigationBar.translucent;
    CGFloat navHeight = 0.0f;
    
    if (@available(iOS 11.0, *)) {
        navHeight = self.view.safeAreaInsets.top;
    } else {
        navHeight = self.navigationController.navigationBar.translucent ? 64.0f : 0.0f;
    }

    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(15.0f + navHeight);
        make.height.mas_equalTo(200.0f);
    }];
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ZHK_BOUNDS.size.width - 2 * PADDING, 44));
        make.top.mas_equalTo(_textView.mas_bottom).offset(navHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    [_appraiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(ZHK_BOUNDS.size.width - 2 * PADDING, 44));
         make.top.mas_equalTo(_submitButton.mas_bottom).offset(20);
         make.centerX.mas_equalTo(self.view.mas_centerX);
     }];
    if(!self.appId) self.appraiseButton.hidden = YES;
    self.tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -  100, -40, 200, 40)];
         _tipLabel.text = @"提交成功!";
    self.tipLabel.textColor = [UIColor whiteColor];
    self.tipLabel.textAlignment = NSTextAlignmentCenter ;
    self.tipLabel.backgroundColor = ZHK_COLOR(60, 67, 97, 1);
         [self.view addSubview:_tipLabel];
    self.tipLabel.layer.cornerRadius = 10;
    self.tipLabel.clipsToBounds = YES ;
}

#pragma mark - Action

- (void)submitAction {
    
    if (!_textView.text || [_textView.text isEqualToString:@""]) {
        self.tipLabel.text = @"内容不能为空!";
    }else{
          self.tipLabel.text = @"感谢您提供宝贵的反馈！";
        [self feedback:_textView.text];
    }
    
    
    

    [UIView animateWithDuration:1 animations:^(void){
          self.tipLabel.center = self.view.center ;
            
       } completion:^(BOOL finishied){
           [self Timered];
       }];
 

}
- (void)dealloc
{
   
}
-(void)Timered{
    CGPoint center =  self.tipLabel.center;
    center.y = -40;
    
    [UIView animateWithDuration:1 animations:^(void){
        self.tipLabel.alpha = 0;
         
    } completion:^(BOOL finishied){
           self.tipLabel.center = center ;
          self.tipLabel.alpha = 1;
        if (!_textView.text || [_textView.text isEqualToString:@""]) {
           
         }else{
                [self.navigationController popViewControllerAnimated:YES];
         }
     
    }];
   

       
}
- (void)appraiseAction {
    
    
NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",self.appId];

[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

   
}
- (void)feedback:(NSString *)text {
    self.getContent(text);
}

- (void)clearText {
    [_textView clearText];
}

#pragma mark - Getter

- (ZHKFeedbackTextView *)textView {
    if (_textView == nil) {
        self.textView = [[ZHKFeedbackTextView alloc] initWithFrame:ZHK_FRAME(0, PADDING, ZHK_BOUNDS.size.width, TEXT_VIEW_HEIGHT)];
    }
    return _textView;
}

- (UIButton *)submitButton {
    if (_submitButton == nil) {
        self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.titleLabel.textColor = [UIColor whiteColor];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _submitButton.backgroundColor = ZHK_COLOR(60, 67, 97, 1);
    }
    return _submitButton;
}

- (UIButton *)appraiseButton {
    if (_appraiseButton == nil) {
        self.appraiseButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_appraiseButton setTitle:@"评价App" forState:UIControlStateNormal];
        [_appraiseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_appraiseButton addTarget:self action:@selector(appraiseAction) forControlEvents:UIControlEventTouchUpInside];
        _appraiseButton.titleLabel.textColor = [UIColor whiteColor];
        _appraiseButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _appraiseButton.backgroundColor = ZHK_COLOR(60, 67, 97, 1);
    }
    return _appraiseButton;
}
@end
