//
//  Input_OnlyText_Cell.h
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#define kCellIdentifier_Input_OnlyText_Cell_Text @"Input_OnlyText_Cell_Text"
#define kCellIdentifier_Input_OnlyText_Cell_Captcha @"Input_OnlyText_Cell_Captcha"
#define kCellIdentifier_Input_OnlyText_Cell_Password @"Input_OnlyText_Cell_Password"
#define kCellIdentifier_Input_OnlyText_Cell_Phone @"Input_OnlyText_Cell_Phone"

#import <UIKit/UIKit.h>
#import "UITapImageView.h"

@interface Input_OnlyText_Cell : UITableViewCell
@property (nonatomic, strong, readonly) UITextField *textField;

@property (strong, nonatomic, readonly) PhoneCodeButton *verify_codeBtn;

@property (assign, nonatomic) BOOL isForLoginVC;

@property (nonatomic,copy) void(^textValueChangedBlock)(NSString *);//改变
@property (nonatomic,copy) void(^editDidBeginBlock)(NSString *);//开始编辑
@property (nonatomic,copy) void(^editDidEndBlock)(NSString *);//结束编辑
@property (nonatomic,copy) void(^countryCodeBtnClickedBlock)();
@end
