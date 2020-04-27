//
//  ZHKFeedbackTextView.m
//  ZHKFeedback
//
//  Created by ZHK on 2018/6/5.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "ZHKFeedbackTextView.h"
#import "ZHKFeedbackMacros.h"
#import <Masonry/Masonry.h>

#define PADDING 15.0
#define TEXT_FONT_SIZE 15.0
#define LABEL_FONT_SIZE 13.0
#define LABEL_MARGIN 10.0

#define MAX_LENGTH 800

@interface ZHKFeedbackTextView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel    *numberView;
@property (nonatomic, strong) UILabel    *placeHolderView;

@end

@implementation ZHKFeedbackTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textView];
    [self addSubview:self.numberView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(PADDING);
        make.top.mas_equalTo(self.mas_top).offset(100);
        make.right.mas_equalTo(self.mas_right).offset(-PADDING);
        make.bottom.mas_equalTo(self.numberView.mas_top).offset(-LABEL_MARGIN);
    }];
    
    [_numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ZHK_BOUNDS.size.width - LABEL_MARGIN * 2, LABEL_FONT_SIZE));
        make.right.mas_equalTo(self.mas_right).offset(-LABEL_MARGIN);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-LABEL_MARGIN);
    }];
    
    [_textView addSubview:self.placeHolderView];
}

- (void)clearText {
    _textView.text = nil;
    _placeHolderView.hidden = NO;
    [_textView endEditing:YES];
}

#pragma mark - UITextView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeHolderView.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (_textView.text.length == 0) {
        _placeHolderView.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    _numberView.text = [NSString stringWithFormat:@"%ld/%d字", MAX_LENGTH - textView.text.length,MAX_LENGTH];
}

#pragma mark - Getter

- (NSString *)text {
    return _textView.text;
}

- (UITextView *)textView {
    if (_textView == nil) {
        self.textView = [UITextView new];
        _textView.font = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
        _textView.textColor = ZHK_COLOR(102, 102, 102, 1);
        _textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.contentInset = UIEdgeInsetsZero;
        
    }
    return _textView;
}

- (UILabel *)numberView {
    if (_numberView == nil) {
        self.numberView = [UILabel new];
        _numberView.textColor = ZHK_COLOR(153, 153, 153, 1);
        _numberView.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        _numberView.textAlignment = NSTextAlignmentRight;
        _numberView.text = [NSString stringWithFormat: @"0/%d字",MAX_LENGTH];
    }
    return _numberView;
}

- (UILabel *)placeHolderView {
    if (_placeHolderView == nil) {
        self.placeHolderView = [[UILabel alloc] initWithFrame:ZHK_FRAME(0, 0, ZHK_BOUNDS.size.width - PADDING * 2, 0)];
        _placeHolderView.text = @"感谢您对我们的支持,我们期待您的宝贵意见!";
        _placeHolderView.numberOfLines = 0;
        _placeHolderView.font = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
        _placeHolderView.backgroundColor = [UIColor clearColor];
        _placeHolderView.textColor = ZHK_COLOR(153, 153, 153, 1);
        [_placeHolderView sizeToFit];
    }
    return _placeHolderView;
}

@end
