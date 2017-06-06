//
//  ZNBAddQRViewController.m
//  ZNBCos
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBAddQRViewController.h"

@interface ZNBAddQRViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderWidth;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (weak, nonatomic) IBOutlet UIImageView *middleImage;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;

@property (assign, nonatomic) float red;
@property (assign, nonatomic) float green;
@property (assign, nonatomic) float blue;
@end

@implementation ZNBAddQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_redSlider setThumbTintColor:[UIColor redColor]];
    [_greenSlider setThumbTintColor:[UIColor greenColor]];
    [_blueSlider setThumbTintColor:[UIColor blueColor]];
    _textView.delegate = self;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageDidTap)];
    self.addImage.userInteractionEnabled = YES;
    [self. addImage addGestureRecognizer:tapGes];
    _red = 0;
    _green = 0;
    _blue = 0;
    [self setupNav];
    
    
}

- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImageText)];
}

- (void)saveImageText {

    [self.navigationController popViewControllerAnimated:YES];
    if (self.imageBlock) {
        self.imageBlock(self.qrImageView.image);
    }
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _sliderWidth.constant = 200*kScreenW/375.0;
    _defaultMargin.constant = 20*kScreenW/375.0;
    
}
#pragma mark - 加号点击事件
- (void)addImageDidTap {
    [_textView resignFirstResponder];
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc] init];
    pickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVc.allowsEditing = YES;
    pickerVc.delegate = self;
    [self presentViewController:pickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    self.middleImage.image = image;
    
    [self changeQRColor];
}

// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self changeQRColor];
}

#pragma mark - slider 事件
- (IBAction)redSliderValueChange:(UISlider *)sender {
    _red = sender.value;
    self.redLabel.text = [NSString stringWithFormat:@"R:%.1f",sender.value];
    [self changeQRColor];
    [_textView resignFirstResponder];
    
}
- (IBAction)greenSliderValueChange:(UISlider *)sender {
    _green = sender.value;
    self.greenLabel.text = [NSString stringWithFormat:@"G:%.1f",sender.value];
    [self changeQRColor];
    [_textView resignFirstResponder];
}
- (IBAction)blueSliderValueChange:(UISlider *)sender {
    _blue = sender.value;
    self.blueLabel.text = [NSString stringWithFormat:@"B:%.1f",sender.value];
    [self changeQRColor];
    [_textView resignFirstResponder];
}
- (void)changeQRColor {
    
    ZNBQRCodeImage *image = [ZNBQRCodeImage codeImageWithString:_textView.text size:1200 color:ZNBColor(_red, _green, _blue) icon:_middleImage.image iconBorderColor:[UIColor whiteColor] iconBorderWidth:20 iconWidth:200 ];
    
    self.qrImageView.image = image;
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [_textView resignFirstResponder];
}
@end
