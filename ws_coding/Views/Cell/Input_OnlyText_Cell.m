//
//  Input_OnlyText_Cell.m
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Input_OnlyText_Cell.h"


@interface Input_OnlyText_Cell ()
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIButton *clearBtn;

@property (strong, nonatomic) UITapImageView *captchaView;
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
                _captchaView = [UITapImageView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
            }
        }
        
    }
    return self;
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
