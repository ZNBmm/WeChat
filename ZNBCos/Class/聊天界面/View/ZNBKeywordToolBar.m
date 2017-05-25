//
//  ZNBKeywordToolBar.m
//  ZNBCos
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBKeywordToolBar.h"

@interface ZNBKeywordToolBar ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end
@implementation ZNBKeywordToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textF.delegate = self;
}
+ (instancetype)shareKeyWord {

    return [self viewForXib];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return NO;
}

@end
