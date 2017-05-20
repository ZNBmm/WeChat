//
//  ZNBTimeLineImageCell.m
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTimeLineImageCell.h"

@interface ZNBTimeLineImageCell ()
@property (weak, nonatomic) UIImageView *imageView;
@end
@implementation ZNBTimeLineImageCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
    
}
@end
