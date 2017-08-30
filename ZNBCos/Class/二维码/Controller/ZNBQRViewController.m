//
//  ZNBQRViewController.m
//  ZNBCos
//
//  Created by mac on 2017/5/30.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBQRViewController.h"
#import "CustomCardCollectionViewFlowLayout.h"
#import "ZNBQRCollectionViewCell.h"
#import "ZNBQRBottomToolView.h"
#import "ZNBAddQRViewController.h"
static NSString *const reuseCell = @"ZNBQRCollectionViewCell";
@interface ZNBQRViewController ()<UIGestureRecognizerDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) UIImageView *bgImage;
@property (weak, nonatomic) UIImageView *qrImage;
@property (weak, nonatomic) ZNBQRBottomToolView *bottomToolView;

@property (weak, nonatomic) UIImageView *colorImageView;
@end

@implementation ZNBQRViewController
- (UIImageView *)bgImage
{
    if (_bgImage == nil) {
        UIImageView *bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
        [self.view addSubview:bgimage];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.contentMode = UIViewContentModeScaleAspectFit;
        _bgImage = bgimage;
    }
    return _bgImage;
}
- (UIImageView *)qrImage
{
    if (_qrImage == nil) {
        UIImageView *bgimage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.view insertSubview:bgimage aboveSubview:self.bgImage];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.contentMode = UIViewContentModeScaleAspectFit;
        _qrImage = bgimage;
        _qrImage.znb_width = kScreenW*0.5;
        _qrImage.znb_height = kScreenW*0.5;
        _qrImage.center = CGPointMake(kScreenW*0.5, (kScreenH-64)*0.5);
        bgimage.userInteractionEnabled = YES;
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(qrImagePan:)];
        [_qrImage addGestureRecognizer:panGes];
        
        _qrImage.image = [UIImage imageNamed:@"znb 2"];
    }
    return _qrImage;
}
- (UIImageView *)colorImageView
{
    if (_colorImageView == nil) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        image.image = [UIImage imageNamed:@"color"];
        image.znb_centerX = kScreenW*0.5;
        image.znb_y = self.view.znb_height-image.znb_height-49;
        _colorImageView = image;
        
        UIPanGestureRecognizer *tapGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [image addGestureRecognizer:tapGes];
        image.userInteractionEnabled = YES;
        [self.view insertSubview:image belowSubview:self.qrImage];
        
    }
    return _colorImageView;
}
- (ZNBQRBottomToolView *)bottomToolView
{
    if (_bottomToolView == nil) {
        ZNBQRBottomToolView *toolView = [ZNBQRBottomToolView bottomToolView];
        _bottomToolView = toolView;
        [toolView.leftBtn addTarget:self action:@selector(changeBGImage) forControlEvents:UIControlEventTouchUpInside];
        [toolView.middleBtn addTarget:self action:@selector(changeBGColor:) forControlEvents:UIControlEventTouchUpInside];
        [toolView.rightBtn addTarget:self action:@selector(changeQRImage) forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:toolView aboveSubview:self.qrImage];
        [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(49));
        }];
    }
    return _bottomToolView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self qrImage];
    [self bgImage];
    [self setUpPinch];
    
    [self setupQRImage];
    
    [self bottomToolView];
    [self setupNav];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"二维码界面"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"二维码界面"];
}
- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImageText)];
}
- (void)setUpPinch
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self.qrImage addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.qrImage addGestureRecognizer:rotation];
}
// 默认传递的旋转的角度都是相对于最开始的位置
- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    self.qrImage.transform = CGAffineTransformRotate(self.qrImage.transform, rotation.rotation);
    rotation.rotation = 0;
}
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    self.qrImage.transform = CGAffineTransformScale(self.qrImage.transform, pinch.scale, pinch.scale);
     pinch.scale = 1;
}
- (void)qrImagePan:(UIPanGestureRecognizer *)pan {
    CGPoint transP = [pan translationInView:self.qrImage];
    
    self.qrImage.transform = CGAffineTransformTranslate(self.qrImage.transform, transP.x, transP.y);
    
    // 复位
    [pan setTranslation:CGPointZero inView:self.qrImage];
}

- (void)tap:(UIPanGestureRecognizer *)tap {

    CGPoint point = [tap locationInView:self.colorImageView];
    
    self.bgImage.backgroundColor = [self.colorImageView getPixelColorAtLocation:point];
}
- (void) setupQRImage {
    ZNBQRCodeImage *image = [ZNBQRCodeImage codeImageWithString:@"当你看到这个界面的时候就证明了,你还是我爱的人-皮皮" size:600 color:[UIColor colorWithHexString:@"D27C3A"] icon:[UIImage imageNamed:@"znb 2"] iconBorderColor:[UIColor whiteColor] iconBorderWidth:10 iconWidth:100 ];

    self.bgImage.image = [UIImage imageNamed:@"timg-7"];
    self.qrImage.image = image;
}

#pragma mark - 底部工具条点击事件
- (void)changeBGImage {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}

- (void)changeBGColor:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self colorImageView];
    }else {
        [self.colorImageView removeFromSuperview];
        self.colorImageView = nil;
    }
    
}

- (void)changeQRImage {
    
    ZNBAddQRViewController *addQRVC = [[ZNBAddQRViewController alloc] init];
    addQRVC.imageBlock = ^(UIImage *image) {
        self.qrImage.image = image;
    };
    [self.navigationController pushViewController:addQRVC animated:YES];
}

#pragma mark - <TZImagePickerControllerDelegate>
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    self.bgImage.image = photos.firstObject;
}


- (void)saveImageText {

    [self loadImageFinished:self.qrImage.image];
    
    
}
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存二维码到相册" message:@"保存二维码到相册,请到相册查看" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
   // NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}
@end
