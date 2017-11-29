//
//  CoreMLViewController.m
//  iOS11Demo
//
//  Created by wintelsui on 2017/10/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "CoreMLViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import "GoogLeNetPlacesMethod.h"
#import "GoogLeNetPlacesOnVisionMethod.h"

#import "iOS11Demo-Bridging-Header.h"

#define SWITCH_Vision 1

@interface CoreMLViewController ()
<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoVisionLabel;

@end

@implementation CoreMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (SWITCH_Vision) {
        [self setNavRightButtonWithImageName:nil title:@"Vision" normalColor:[UIColor blackColor]];
    }
}

- (void)pressedRightButton{
    [self openVisionPage];
}

- (void)showImagePicker{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerVC.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = NO;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
    }
}

#pragma mark - -- UIImagePickerController Delegate Start --

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        [_infoLabel setText:@""];
        [_infoVisionLabel setText:@""];
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (image) {
            [_imageView setImage:image];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - -- UIImagePickerController Delegate End --

- (IBAction)chooseButtonPressed:(id)sender {
    [self showImagePicker];
}
- (IBAction)beginCoreMLPressed:(id)sender {
    UIImage *image = _imageView.image;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (image) {
            NSString *info = [GoogLeNetPlacesMethod thinkOfImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (info) {
                    [_infoLabel setText:[NSString stringWithFormat:@"CoreML识别为：%@",info]];
                }else{
                    [_infoLabel setText:@"CoreML没有识别出来！"];
                }
            });
        }
    });
}
- (IBAction)CoreMLXVisionPressed:(id)sender {
    UIImage *image = _imageView.image;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (image) {
            [GoogLeNetPlacesOnVisionMethod thinkOfImage:image completion:^(NSString *info) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (info) {
                        [_infoVisionLabel setText:[NSString stringWithFormat:@"CoreML&Vision识别为：%@",info]];
                    }else{
                        [_infoVisionLabel setText:@"CoreML&Vision没有识别出来！"];
                    }
                });
                
            }];
        }
    });
}




- (void)openVisionPage{
    iOS11ActionsListModels *actionInfo = [iOS11DemoAppVCsList objectForKey:@"VisionCode"];
    if (actionInfo) {
        NSString *className = actionInfo.className;
        NSString *pageName = actionInfo.name;
        
        UIStoryboard *storyboard = [self storyboardByMyName:actionInfo.storyboard];
        UIViewController *page;
        if (storyboard && actionInfo.storyboardid) {
            page = [storyboard instantiateViewControllerWithIdentifier:actionInfo.storyboardid];
        }
        if (!page) {
            page = [[NSClassFromString(className) alloc] init];
        }
        page.title = pageName;
        [self.navigationController pushViewController:page animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
