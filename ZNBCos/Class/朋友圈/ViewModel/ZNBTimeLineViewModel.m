//
//  ZNBTimeLineViewModel.m
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTimeLineViewModel.h"

@implementation ZNBTimeLineViewModel
- (NSMutableArray *)imageArr
{
    if (_imageArr == nil) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (NSMutableArray<NSMutableAttributedString *> *)cmtArr
{
    if (_cmtArr == nil) {
        _cmtArr = [NSMutableArray array];
    }
    return _cmtArr;
}
- (NSMutableArray *)cmtCellHeightArr
{
    if (_cmtCellHeightArr == nil) {
        _cmtCellHeightArr = [NSMutableArray array];
    }
    return _cmtCellHeightArr;
}
+ (instancetype)viewModelWithModel:(ZNBTimeLineModel *)model {

    ZNBTimeLineViewModel *viewModel = [[self alloc] init];
    viewModel.model = model;
    return viewModel;
}

- (void)setModel:(ZNBTimeLineModel *)model {
    _model = model;
    // 配置评论字符串 生成 "张三回复:李四 你妈喊你回家吃饭了"格式
    [self configCmtString:model];
   
    
    [self configImageArrWithModel:model];
    
    [self configLikestringWithModel:model];
    
    
   /*
    if (!self.likesHeight) {
        self.cmtTableHeight+=5;
    }
    */
    
    
}

// 配置喜欢字符串
- (void)configLikestringWithModel:(ZNBTimeLineModel *)model {
    if (model.likes.length) {
        NSString *str = model.likes;
        UIFont *font = kFontSize(14);
//        CGSize size = CGSizeMake(kCmtLabelWidth, MAXFLOAT);
//        CGFloat textH = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
        UIImage *image = [UIImage imageNamed:@"AlbumLikeSmall"];
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = image;
        // -((textH-image.size.height)*0.5)
        attach.bounds = CGRectMake(0, -5, image.size.width, image.size.height);
        NSAttributedString *attr = [NSAttributedString attributedStringWithAttachment:attach];
        NSMutableAttributedString *muattr = [[NSMutableAttributedString alloc] initWithString:@""];
        
        [muattr appendAttributedString:attr];
        [muattr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [muattr appendAttributedString:[[NSAttributedString alloc] initWithString:model.likes]];
        [muattr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, muattr.length)];
//        // 计算正文文字的高度
        CGSize maxSize = CGSizeMake(kCmtLabelWidth-10, MAXFLOAT);
        CGFloat attrTextH = [muattr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        self.likesHeight = attrTextH;
       
        self.likes = muattr;
    }

}

// 配置图片数组
- (void)configImageArrWithModel:(ZNBTimeLineModel *)model {

    if (model.imageArr.count==1) {
        ZNBImageModel *imageModel = model.imageArr.firstObject;
        UIImage *image = [UIImage imageWithData:imageModel.imageData];
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        self.collecSize = CGSizeMake(width, height);
        [self.imageArr addObject:image];
        return;
    }else if (model.imageArr.count == 2) {
        self.collecSize = CGSizeMake(kImageWidth*2+kImageMargin, kImageWidth);
        
    }else if (model.imageArr.count == 3) {
        self.collecSize = CGSizeMake(kImageWidth*3+2*kImageMargin, kImageWidth);
        
    }else if (model.imageArr.count==4){
        self.collecSize = CGSizeMake(kImageWidth*2+kImageMargin, kImageWidth*2+kImageMargin);
    }else if (model.imageArr.count>4 && model.imageArr.count<=6){
        self.collecSize = CGSizeMake(kImageWidth*3+2*kImageMargin, kImageWidth*2+kImageMargin);
    }else if (model.imageArr.count>6 && model.imageArr.count<=9){
        self.collecSize = CGSizeMake(kImageWidth*3+2*kImageMargin, kImageWidth*3+2*kImageMargin);
    }
    for (ZNBImageModel* imageModel in model.imageArr)  {
        [self.imageArr addObject:[UIImage imageWithData:imageModel.imageData]];
    }
}
// 配置评论字符串 生成 "张三回复:李四 你妈喊你回家吃饭了"格式
- (void)configCmtString:(ZNBTimeLineModel *)model {
    
    NSMutableAttributedString *mutableAttrStr = nil;
    for (ZNBTimeLineCmtModel *cmtModel in model.cmtArr) {
        
        NSString *reply = cmtModel.replyName;
        NSString *beReply = cmtModel.beReplyName;
        NSString *content = cmtModel.content;
        if (beReply.length) { // 如果被回复人存在
            NSString *allStr = [NSString stringWithFormat:@"%@回复%@: %@",reply,beReply,content];
            mutableAttrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
            [mutableAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, mutableAttrStr.length)];
            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
            attr[NSFontAttributeName] = kFontSize(14);
            attr[NSForegroundColorAttributeName] = kFontColor;
            NSRange replyRange = [allStr rangeOfString:reply];
            NSRange beReplyRange = [allStr rangeOfString:beReply];
            [mutableAttrStr addAttributes:attr range:replyRange];
            [mutableAttrStr addAttributes:attr range:beReplyRange];
            
            [self.cmtArr addObject:mutableAttrStr];
            
        }else {
            NSString *allStr = [NSString stringWithFormat:@"%@: %@",reply,content];
            mutableAttrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
            [mutableAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, mutableAttrStr.length)];
            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
            attr[NSFontAttributeName] = kFontSize(14);
            attr[NSForegroundColorAttributeName] = kFontColor;
            NSRange replyRange = [allStr rangeOfString:reply];
            [mutableAttrStr addAttributes:attr range:replyRange];
            
            [self.cmtArr addObject:mutableAttrStr];
        }
        
        CGSize maxSize = CGSizeMake(kCmtLabelWidth-10.0, MAXFLOAT);
        CGFloat textH = [mutableAttrStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        self.cmtTableHeight+=(textH+6);
        [self.cmtCellHeightArr addObject:[NSString stringWithFormat:@"%f",textH+6.0]];
    }
 
}
@end
