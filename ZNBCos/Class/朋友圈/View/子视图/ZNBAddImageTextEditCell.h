//
//  ZNBAddImageTextEditCell.h
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kZNBAddImageTextEditCelMargin 5
#define kItemSize ((kScreenW - 20 - 4 * kZNBAddImageTextEditCelMargin)/5)
typedef void(^ZNBAddImageTextEditCellBlock)(UITextView *textView);
@interface ZNBAddImageTextEditCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collecView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;
@end
