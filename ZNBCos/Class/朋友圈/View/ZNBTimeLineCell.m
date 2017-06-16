//
//  ZNBTimeLineCell.m
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTimeLineCell.h"
#import "ZNBTimeLineImageCell.h"
#import "ZNBRaiseCmtView.h"
#import "ZNBLikeBGView.h"
#import "ZNBTimeLineCmtCell.h"
static NSString *const reuseCell = @"ZNBTimeLineImageCell";
static NSString *const reuseCmtCell = @"reuseCmtCell";
@interface ZNBTimeLineCell ()<UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) UIImageView *avatarView;
@property (weak, nonatomic) UILabel *nameLabel;
@property (copy, nonatomic) UILabel *contentLabel;
@property (weak, nonatomic) UICollectionView *collecView;
@property (weak, nonatomic) UILabel *addressLabel;
@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UIButton *cmtBtn;
@property (weak, nonatomic) UILabel *likesLabel;
@property (weak, nonatomic) UILabel *sourceLabel;
@property (weak, nonatomic) ZNBLikeBGView *likeBGView;
@property (weak, nonatomic) ZNBRaiseCmtView *raiseAndCmtView;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MASConstraint *raiseCmtWidth;
@property (strong, nonatomic) MASConstraint *raiseCmtRight;
@end
@implementation ZNBTimeLineCell
- (UIImageView *)avatarView
{
    if (_avatarView == nil) {
        UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"znb 2"]];
        _avatarView = avatar;
       
        [self.contentView addSubview:avatar];
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(kLeftMargin);
            make.top.equalTo(self.contentView.mas_top).offset(kTopMargin);
            make.height.equalTo(@(kAvatarSize));
            make.width.equalTo(@(kAvatarSize));
            
        }];
    }
    return _avatarView;
}
 - (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        nameLabel.textColor = kFontColor;
        nameLabel.font = kFontSize(15);
        nameLabel.text = @"Znbmm美眉";
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(kRightMargin);
            make.top.equalTo(self.avatarView);
            
        }];
        
    }
    return _nameLabel;
}
- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        [self.contentView addSubview:contentLabel];
        contentLabel.textColor = kDefaultBlackColor;
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.preferredMaxLayoutWidth = (kScreenW - kLeftMargin-kImageWidth-kRightMargin-kRightMargin);
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(kImageMargin);
            make.right.equalTo(self.contentView).offset(-kRightMargin);
        }];
    }
    return _contentLabel;
}
- (UICollectionView *)collecView
{
    if (_collecView == nil) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.itemSize = CGSizeMake(kImageWidth, kImageWidth);
        fl.minimumLineSpacing = kImageMargin;
        fl.minimumInteritemSpacing = kImageMargin;
        UICollectionView *collecView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fl];
        collecView.backgroundColor = [UIColor whiteColor];
        collecView.allowsSelection = NO;
        [self.contentView addSubview:collecView];
        collecView.scrollEnabled = NO;
        collecView.dataSource = self;
        _collecView = collecView;
        [collecView registerClass:[ZNBTimeLineImageCell class] forCellWithReuseIdentifier:reuseCell];
        [collecView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(kLeftMargin);
            make.left.equalTo(self.contentLabel.mas_left);
            make.width.equalTo(@(kImageWidth*2+kImageMargin+0.1));
            make.height.equalTo(@(kImageMargin+kImageWidth*2));
        }];
    }
    return _collecView;
}
- (UILabel *)addressLabel
{
    if (_addressLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kFontColor;
        label.font = [UIFont systemFontOfSize:12];
        _addressLabel = label;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collecView.mas_bottom).offset(kImageMargin);
            make.left.equalTo(self.collecView.mas_left);
            
        }];
    }
    return _addressLabel;
}
- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        _timeLabel = label;
        [self.contentView addSubview:label];
        label.textColor = ZNBColor(200, 200, 200);
        label.font = [UIFont systemFontOfSize:12];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            make.top.equalTo(self.addressLabel.mas_bottom).offset(kImageMargin);
            
        }];
    }
    return _timeLabel;
}
- (UIButton *)cmtBtn
{
    if (_cmtBtn == nil) {
        UIButton *cmtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cmtBtn = cmtBtn;
        [self.contentView addSubview:cmtBtn];
        [cmtBtn setImage:[UIImage imageNamed:@"moments_more"] forState:UIControlStateNormal];
        [cmtBtn addTarget:self action:@selector(timeLineCmtBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cmtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-kRightMargin);
            make.centerY.equalTo(self.timeLabel);
            make.width.equalTo(@40);
//            make.height.equalTo(@40);
        }];
    }
    return _cmtBtn;
}
- (UILabel *)sourceLabel
{
    if (_sourceLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = self.timeLabel.textColor;
        label.font = self.timeLabel.font;
        _sourceLabel = label;
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(kRightMargin);
            make.centerY.equalTo(self.timeLabel);
        }];
    }
    return _sourceLabel;
}
- (UILabel *)likesLabel
{
    if (_likesLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentLeft;
        _likesLabel = label;
        _likesLabel.preferredMaxLayoutWidth = kCmtLabelWidth-10;
        label.font = kFontSize(14);
        label.textColor = kFontColor;
        [self.likeBGView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.likeBGView).offset(5);
            make.right.equalTo(self.likeBGView).offset(-5);
            make.top.equalTo(self.likeBGView).offset(9);
            make.height.equalTo(@0);
        }];
        
    }
    return _likesLabel;
}
- (ZNBLikeBGView *)likeBGView
{
    if (_likeBGView == nil) {
        ZNBLikeBGView *bgView = [[ZNBLikeBGView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:bgView];
      
         [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.right.equalTo(self.contentView).offset(-kRightMargin);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(kImageMargin);
            make.height.equalTo(@0);
        }];
        _likeBGView = bgView;
        self.hyb_lastViewInCell = _likeBGView;
        self.hyb_bottomOffsetToCell = kBottomMargin;
    }
    [_likeBGView setNeedsDisplay];
    return _likeBGView;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        [self.likeBGView addSubview:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_likeBGView);
            make.right.equalTo(_likeBGView);
            make.top.equalTo(self.likesLabel.mas_bottom);
            make.height.equalTo(@0);
        }];
        
        [tableView registerClass:[ZNBTimeLineCmtCell class] forCellReuseIdentifier:reuseCmtCell];
    }
   
    return _tableView;;
}
- (ZNBRaiseCmtView *)raiseAndCmtView
{
    if (_raiseAndCmtView == nil) {
       
        ZNBRaiseCmtView *raiseAndCmtView = [ZNBRaiseCmtView raiseCmtView];
        [raiseAndCmtView.raiseBtn addTarget:self action:@selector(raiseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [raiseAndCmtView.cmtBtn addTarget:self action:@selector(cmtBtnClick) forControlEvents:UIControlEventTouchUpInside];
        raiseAndCmtView.layer.anchorPoint = CGPointMake(1, 0.5);
        _raiseAndCmtView = raiseAndCmtView;
        [self.contentView addSubview:raiseAndCmtView];
        [raiseAndCmtView mas_makeConstraints:^(MASConstraintMaker *make) {
            self.raiseCmtRight = make.right.equalTo(self.cmtBtn.mas_left).offset(kScreenW*0.25);
            make.centerY.equalTo(self.cmtBtn);
            make.height.equalTo(@35);
            self.raiseCmtWidth = make.width.equalTo(@0);
        }];
    }
    return _raiseAndCmtView;;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self avatarView];
        [self nameLabel];
        [self contentLabel];
        [self addressLabel];
        [self collecView];
        [self timeLabel];
        [self cmtBtn];
        [self sourceLabel];
        [self likesLabel];
        [self raiseAndCmtView];
        [self tableView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
    
}

- (void)setViewModel:(ZNBTimeLineViewModel *)viewModel {
    _viewModel = viewModel;
    self.avatarView.image = [UIImage imageWithData:viewModel.model.avatar];
    self.nameLabel.text = viewModel.model.name;
    self.contentLabel.text = viewModel.model.content;
    // 配置 collectionView
    if (viewModel.imageArr.count) {
        if (viewModel.imageArr.count == 1) {
            UICollectionViewFlowLayout *fl = (UICollectionViewFlowLayout *)self.collecView.collectionViewLayout;
            fl.itemSize = viewModel.collecSize;
            self.collecView.collectionViewLayout = fl;
        }else {
            UICollectionViewFlowLayout *fl = (UICollectionViewFlowLayout *)self.collecView.collectionViewLayout;
            
            fl.itemSize = CGSizeMake(kImageWidth, kImageWidth);
            fl.minimumLineSpacing = kImageMargin;
            fl.minimumInteritemSpacing = kImageMargin;
             self.collecView.collectionViewLayout = fl;
        }
        [self.collecView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(kLeftMargin);
            make.width.equalTo(@(viewModel.collecSize.width));
            make.height.equalTo(@(viewModel.collecSize.height));
        }];
    }else {
        [self.collecView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
            make.top.equalTo(self.contentLabel.mas_bottom);
        }];
    }
    // 配置addressLabel
    if (viewModel.model.address.length) {
        self.addressLabel.text = viewModel.model.address;
        [self.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collecView.mas_bottom).offset(kImageMargin);
        }];
    }else {
        [self.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collecView.mas_bottom);
            
        }];
    }
    
    // 配置timeLabel
    if (viewModel.model.time.length) {
        self.timeLabel.text = viewModel.model.time;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_bottom).offset(kImageMargin);
        }];
    }else {
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_bottom);
            
        }];
    }
    if (viewModel.model.source.length) {
        self.sourceLabel.hidden = NO;
        self.sourceLabel.text = viewModel.model.source;
    }else {
        self.sourceLabel.hidden = YES;
    }
    
    // 配置 likesLabel
    if (viewModel.likes.length && viewModel.cmtArr.count) {
        self.likesLabel.attributedText = viewModel.likes;
        [self.likeBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(kImageMargin);
            make.height.equalTo(@(viewModel.likesHeight+12+viewModel.cmtTableHeight));//12 是额外高度
        }];

        [self.likesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likeBGView.mas_top).offset(9);
            make.height.equalTo(@(viewModel.likesHeight));
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likesLabel.mas_bottom).offset(0);
            make.height.equalTo(@(viewModel.cmtTableHeight));
        }];
        
    }else if (viewModel.likes.length && !viewModel.cmtArr.count) {
        self.likesLabel.attributedText = viewModel.likes;
        [self.likeBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(kImageMargin);
            make.height.equalTo(@(viewModel.likesHeight+12+viewModel.cmtTableHeight));//12 是额外高度
        }];
        
        [self.likesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likeBGView.mas_top).offset(9);
            make.height.equalTo(@(viewModel.likesHeight));
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likesLabel.mas_bottom).offset(0);
            make.height.equalTo(@(viewModel.cmtTableHeight));
        }];
    }else if (!viewModel.likes.length && viewModel.cmtArr.count) {
        self.likesLabel.attributedText = viewModel.likes;
        [self.likeBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(kImageMargin);
            make.height.equalTo(@(viewModel.likesHeight+12+viewModel.cmtTableHeight));//12 是额外高度
        }];
        
        [self.likesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likeBGView.mas_top).offset(9);
            make.height.equalTo(@(viewModel.likesHeight));
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likesLabel.mas_top).offset(0);
            make.height.equalTo(@(viewModel.cmtTableHeight));
        }];
    }else {
        self.likesLabel.attributedText = viewModel.likes;
        [self.likeBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(kImageMargin);
            make.height.equalTo(@0);
        }];
        
        [self.likesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likeBGView.mas_top).offset(9);
            make.height.equalTo(@(viewModel.likesHeight));
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likesLabel.mas_bottom).offset(0);
            make.height.equalTo(@(viewModel.cmtTableHeight));
        }];
    }

    
    if (viewModel.cmtArr.count && viewModel.likes.length) {
        UILabel *sepata = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
        sepata.backgroundColor = kBackGroundColor;
        self.tableView.tableHeaderView = sepata;
    }else {
        self.tableView.tableHeaderView = nil;
    }
    [self.collecView reloadData];
    [self.tableView reloadData];
    
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _viewModel.imageArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZNBTimeLineImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCell forIndexPath:indexPath];
    cell.image = self.viewModel.imageArr[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.cmtArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableAttributedString *cmtStr = self.viewModel.cmtArr[indexPath.row];
    ZNBTimeLineCmtCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCmtCell];
    cell.contentLabel.attributedText = cmtStr;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CGFloat height = [self.viewModel.cmtCellHeightArr[indexPath.row] floatValue];
    
    return height;
   /* NSMutableAttributedString *cmtStr = self.viewModel.cmtArr[indexPath.row];
    
    ZNBTimeLineCmtModel *cmtModel = self.viewModel.model.cmtArr[indexPath.row];
    CGFloat height = [ZNBTimeLineCmtCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ZNBTimeLineCmtCell *cell = (ZNBTimeLineCmtCell *)sourceCell;
        cell.contentLabel.attributedText = cmtStr;
    } cache:^NSDictionary *{
        NSDictionary *cache = @{kHYBCacheUniqueKey : cmtModel.uid,
                                kHYBCacheStateKey : @"",
                                kHYBRecalculateForStateKey : @(YES)};
        return cache;
    } ];
    
    return height;
    */
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(timeLineCell:didSelectedCmtCell:atIndexPath:)]) {
        ZNBTimeLineCmtCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.delegate timeLineCell:self didSelectedCmtCell:cell atIndexPath:indexPath];
    }
}

- (void)timeLineCmtBtnClick:(UIButton *)cmtBtn {
    if ([self.delegate respondsToSelector:@selector(timeLineCell:didSelectedCmtBtn:)]) {
        [self.delegate timeLineCell:self didSelectedCmtBtn:cmtBtn];
    }
    if (cmtBtn.selected) {
        cmtBtn.selected = NO;
       
        [self hiddenRaiseCmtView];
    }else {
        
        [self disPlayRaiseCmtView];
        cmtBtn.selected = YES;
    }
}

- (void)hiddenRaiseCmtView {
    [self.raiseCmtWidth uninstall];
    [self.raiseCmtRight uninstall];
    [self.raiseAndCmtView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0));
        make.right.equalTo(self.cmtBtn.mas_left);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.raiseAndCmtView layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.raiseAndCmtView.hidden = YES;
    }];
}
- (void)disPlayRaiseCmtView {
    self.raiseAndCmtView.hidden = NO;
    [self.raiseCmtWidth uninstall];
    [self.raiseCmtRight uninstall];
    [self.raiseAndCmtView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenW * 0.5));
        make.right.equalTo(self.cmtBtn.mas_left).offset(kScreenW*0.25);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.raiseAndCmtView layoutIfNeeded];
    }completion:^(BOOL finished) {
    }];
}
#pragma mark - 点赞按钮点击事件
- (void)raiseBtnClick {
    if (self.raiseBtnBlock) {
        self.raiseBtnBlock();
    }
}
#pragma mark - 评论按钮点击事件
- (void)cmtBtnClick {
    if (self.cmtBtnBlock) {
        self.cmtBtnBlock();
    }
}
- (void)setFrame:(CGRect)frame {

    frame.size.height-=1;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _cmtBtn.selected = NO;
    [self hiddenRaiseCmtView];
    

}

@end
