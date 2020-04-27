//
//  ViewController.m
//  ZHKFeedback
//
//  Created by ZHK on 2018/6/5.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "ViewController.h"
#import "ZHKFeedbackViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationController.navigationBar.translucent = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)feedback:(id)sender {
    ZHKFeedbackViewController *feedbackVC = [[ZHKFeedbackViewController alloc] init];
    feedbackVC.getContent = ^(NSString *content){
        NSLog(@"feedbackVC.getContent:%@",content);
    };
    [self.navigationController pushViewController:feedbackVC animated:YES];
}

@end
