//
//  ZNBTimeLineCell.h
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNBTimeLineViewModel.h"
@class ZNBTimeLineCell,ZNBTimeLineCmtCell;
@protocol ZNBTimeLineCellDelegate <NSObject>

- (void)timeLineCell:(ZNBTimeLineCell *)timeLineCell didSelectedCmtCell:(ZNBTimeLineCmtCell *)cmtCell atIndexPath:(NSIndexPath *)indexPath;
- (void)timeLineCell:(ZNBTimeLineCell *)timeLineCell didSelectedCmtBtn:(UIButton *)cmtBtn;

@end

typedef void(^ZNBTimeLineCellBlock)();
@interface ZNBTimeLineCell : UITableViewCell
@property (weak, nonatomic) id<ZNBTimeLineCellDelegate> delegate;
@property (nonatomic, strong) ZNBTimeLineViewModel *viewModel;

@property (nonatomic, copy) ZNBTimeLineCellBlock raiseBtnBlock;
@property (nonatomic, copy) ZNBTimeLineCellBlock cmtBtnBlock;
- (void)hiddenRaiseCmtView;
- (void)disPlayRaiseCmtView;
@end
