//
//  ZNBTimeLineTopView.h
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZNBTimeLineTopViewBlock)();

@interface ZNBTimeLineTopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
+ (instancetype)timeLineTopView;
/** topclick */
@property (nonatomic, copy) ZNBTimeLineTopViewBlock topClickBlock;
@end
