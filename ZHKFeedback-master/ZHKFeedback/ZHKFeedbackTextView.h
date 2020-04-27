//
//  ZHKFeedbackTextView.h
//  ZHKFeedback
//
//  Created by ZHK on 2018/6/5.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHKFeedbackTextView : UIView

@property (nonatomic, strong) NSString *text;

/*!
 *  清除文本
 */
- (void)clearText;

@end
