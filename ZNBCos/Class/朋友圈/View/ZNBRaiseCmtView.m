//
//  ZNBRaiseCmtView.m
//  ZNBCos
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBRaiseCmtView.h"

@interface ZNBRaiseCmtView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end
@implementation ZNBRaiseCmtView
-(void)awakeFromNib {

    [super awakeFromNib];
    self.bgImageView.image = [UIImage resizableImageWithImageName:@"AlbumOperateMoreViewBkg"];
    
}
+ (instancetype)raiseCmtView {

    return [self viewForXib];
}


@end
