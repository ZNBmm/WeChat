//
//  ZNBAddImageTextEditCell.m
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBAddImageTextEditCell.h"

@interface ZNBAddImageTextEditCell ()<UITextViewDelegate>




@end
@implementation ZNBAddImageTextEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
  
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = kItemSize;
    fl.minimumLineSpacing = kZNBAddImageTextEditCelMargin;
    fl.minimumInteritemSpacing = kZNBAddImageTextEditCelMargin;
    fl.itemSize = CGSizeMake(itemWidth, itemWidth);
    self.collecView.collectionViewLayout = fl;
    
   
}

- (void)textViewDidChange:(UITextView *)textView {

    if (textView.text.length) {
        self.placeHolder.hidden = YES;
    }else {
        self.placeHolder.hidden = NO;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
