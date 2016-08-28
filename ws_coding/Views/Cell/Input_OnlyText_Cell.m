//
//  Input_OnlyText_Cell.m
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//
#define kCellIdentifier_Input_OnlyText_Cell_PhoneCode_Prefix @"Input_OnlyText_Cell_PhoneCode"
#import "Input_OnlyText_Cell.h"


@interface Input_OnlyText_Cell ()
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIButton *clearBtn, *passwordBtn;


@property (strong, nonatomic) UITapImageView *captchaView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation Input_OnlyText_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_textField) {
            _textField = [UITextField new];
            [_textField setFont:[UIFont systemFontOfSize:17]];
            [_textField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
            [_textField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            [self.contentView addSubview:_textField];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
                make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
        }
        
        if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Text]) {
            
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Captcha]){
            @weakify(self);
            if (!_captchaView) {
                _captchaView = [[UITapImageView alloc] initWithFrame:CGRectMake(kScreen_Width - 60 - kLoginPaddingLeftWidth, (44 -25)/2, 60, 25)];
                _captchaView.layer.cornerRadius = 5;
                _captchaView.layer.masksToBounds = YES;
                [_captchaView addTapBlock:^(id obj) {
                    @strongify(self);
                    
                }];
                [self.contentView addSubview:_captchaView];
            }
            
            if (!_activityIndicator) {
                _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                _activityIndicator.hidesWhenStopped = YES;
                [self.contentView addSubview:_activityIndicator];
                [_activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self.captchaView);
                }];
            }
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Password]){
            
            if (!_passwordBtn) {
                _textField.secureTextEntry = YES;
                
                _passwordBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - 44- kLoginPaddingLeftWidth, 0, 44, 44)];
                [_passwordBtn setImage:[UIImage imageNamed:@"password_unlook"] forState:UIControlStateNormal];
                [_passwordBtn addTarget:self action:@selector(passwordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_passwordBtn];
            }
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_PhoneCode_Prefix]){
            
            
        }
        
    }
    return self;
}

#pragma mark button Chick
- (void)passwordBtnClicked:(UIButton *)button{
    
    _textField.secureTextEntry = !_textField.secureTextEntry;
    [button setImage:[UIImage imageNamed:_textField.secureTextEntry? @"password_unlook": @"password_look"] forState:UIControlStateNormal];
}

#pragma mark TextField
- (void)editDidBegin:(id)sender {
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    self.clearBtn.hidden = _isForLoginVC? self.textField.text.length <= 0: YES;
    
    if (self.editDidBeginBlock) {
        self.editDidBeginBlock(self.textField.text);
    }
}

- (void)editDidEnd:(id)sender {
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
    self.clearBtn.hidden = YES;
    
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

- (void)textValueChanged:(id)sender {
    self.clearBtn.hidden = _isForLoginVC? self.textField.text.length <= 0: YES;
    
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

@end
