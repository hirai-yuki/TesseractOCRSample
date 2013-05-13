//
//  ViewController.m
//  TesseractOCRSample
//
//  Created by hirai.yuki on 2013/05/13.
//  Copyright (c) 2013年 hirai.yuki. All rights reserved.
//

#import "ViewController.h"
#import "Tesseract.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // OCRを実行する画像を表示しておく
    self.imageView.image = [UIImage imageNamed:@"tesseract_sample"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    // OCR実行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 日本語を設定
        Tesseract *tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"jpn"];
        
        // OCRを実行する画像を設定
        [tesseract setImage:self.imageView.image];
        
        // OCR実行！
        [tesseract recognize];
        
        // 実行結果をアラートビューで表示
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [[[UIAlertView alloc] initWithTitle:@"Tesseract Sample"
                                        message:[NSString stringWithFormat:@"Recognized:\n%@", [tesseract recognizedText]]
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
        });
    });
}

@end
