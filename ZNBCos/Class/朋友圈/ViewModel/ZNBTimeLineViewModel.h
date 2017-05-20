//
//  ZNBTimeLineViewModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNBTimeLineModel.h"
@interface ZNBTimeLineViewModel : NSObject

/** update */
@property(nonatomic,assign) BOOL upDate;
@property (strong, nonatomic) ZNBTimeLineModel *model;

@property (strong, nonatomic) NSMutableArray *imageArr;

@property (nonatomic, copy) NSMutableAttributedString *likes;

@property (nonatomic, assign) CGFloat cellHeight;
/** 评论TableView Height */
@property (nonatomic,assign) CGFloat cmtTableHeight;
@property (nonatomic, strong) NSMutableArray *cmtCellHeightArr;
@property (nonatomic, assign) CGFloat likesHeight;
/** collectionView Size */
@property(nonatomic,assign) CGSize collecSize;
@property (strong, nonatomic) NSMutableArray<NSMutableAttributedString*> *cmtArr;
+ (instancetype)viewModelWithModel:(ZNBTimeLineModel *)model;
@end
