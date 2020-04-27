//
//  ZHKFeedbackViewController.h
//  ZHKFeedback
//
//  Created by ZHK on 2018/6/5.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import <UIKit/UIKit.h>
//其他定义
typedef void(^Block)(NSString *content);

@interface ZHKFeedbackViewController : UIViewController

@property (nonatomic, copy) Block getContent;
- (void)feedback:(NSString *)text;
@property (nonatomic, copy) NSString *appId;
- (void)clearText;

@end
