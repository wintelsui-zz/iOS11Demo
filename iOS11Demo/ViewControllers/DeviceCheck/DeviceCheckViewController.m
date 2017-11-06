//
//  DeviceCheckViewController.m
//  iOS11Demo
//
//  Created by wintelsui on 2017/10/19.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "DeviceCheckViewController.h"
#import <DeviceCheck/DeviceCheck.h>

#import "WTWebViewController.h"

@interface DeviceCheckViewController ()

@property (weak, nonatomic) IBOutlet UIButton *getDCDeviceTokenButton;
@end

@implementation DeviceCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WTWebViewController *wb = [[WTWebViewController alloc] init];
    wb.url = [[NSBundle mainBundle] pathForResource:@"DeviceCheck" ofType:@"html"];
    [self addChildViewController:wb];
    [self.view addSubview:wb.view];
    
    [wb.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20.0f);
        make.left.mas_equalTo(20.0f);
        make.bottom.mas_equalTo(_getDCDeviceTokenButton.mas_top).mas_offset(-20.0f);
        make.right.mas_equalTo(-20.0f);
    }];
}
- (IBAction)getDCDeviceTokenPressed:(id)sender {
    DCDevice *myDevice = DCDevice.currentDevice;
    if (myDevice.supported){
        MBProgressHUD *hud = [self showProgressHUD:@"getting..."];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [myDevice generateTokenWithCompletionHandler:^(NSData * _Nullable token, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hideProgressHUD:hud];
                    if (token){
                        NSString *deviceToken = [token base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                        NSString *message = [NSString stringWithFormat:@"deviceToken：{长度：%lu，内容：%@}", token.length, deviceToken];
                        NSLog(@"%@",message);
                        [self showSimpleAlertTitle:@"generateToken" body:message cancel:@"OK"];
                    }else{
                        if (error){
                            switch (error.code) {
                                case DCErrorUnknownSystemFailure:
                                    
                                    break;
                                case DCErrorFeatureUnsupported:
                                    
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                });
            }];
        });
    }else{
        [self showSimpleAlertTitle:@"generateToken" body:@"设备不支持DCDevice" cancel:@"OK"];
//        [[[UIAlertView alloc] initWithTitle:@"generateToken" message:@"设备不支持DCDevice" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
