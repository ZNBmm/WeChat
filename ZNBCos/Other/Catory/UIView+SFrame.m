
#import "UIView+SFrame.h"

@implementation UIView (SFrame)

- (void)setZnb_x:(CGFloat)znb_x {
    CGRect frame = self.frame;
    frame.origin.x = znb_x;
    self.frame = frame;
}

- (CGFloat)znb_x {

    return self.frame.origin.x;
}

- (void)setZnb_y:(CGFloat)znb_y {
    CGRect frame = self.frame;
    frame.origin.y = znb_y;
    self.frame = frame;
}

- (CGFloat)znb_y {
    
    return self.frame.origin.y;
}

- (void)setZnb_width:(CGFloat)znb_width {
    CGRect frame = self.frame;
    frame.size.width = znb_width;
    self.frame = frame;
}

- (CGFloat)znb_width {
    
    return self.frame.size.width;
}
- (void)setZnb_height:(CGFloat)znb_height {
    CGRect frame = self.frame;
    frame.size.height = znb_height;
    self.frame = frame;
}

- (CGFloat)znb_height {
    
    return self.frame.size.height;
}
- (void)setZnb_centerX:(CGFloat)znb_centerX {
 
    CGPoint center = self.center;
    center.x = znb_centerX;
    self.center = center;
}

- (CGFloat)znb_centerX {
    
    return self.center.x;
}
- (void)setZnb_centerY:(CGFloat)znb_centerY {
    
    CGPoint center = self.center;
    center.y = znb_centerY;
    self.center = center;
}

- (CGFloat)znb_centerY {
    
    return self.center.y;
}
+ (instancetype)viewForXib {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
