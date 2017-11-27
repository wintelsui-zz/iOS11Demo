//
//  IdentityLookupViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/10/17.
//  Copyright © 2017年 wintel. All rights reserved.
//  具体内容见 MessageFilterExtension 文件

#import "IdentityLookupViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <CallKit/CallKit.h>

@interface IdentityLookupViewController ()
<CNContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation IdentityLookupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNumber];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)loadNumber{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:[self groupBundleIdentifier]];
    NSString *number = [userDefault objectForKey:NumberKey];
    [_numberLabel setText:number];
}

- (IBAction)setupButtonPressed:(id)sender {
    NSString *number = _numberTextField.text;
    if (number && number.length) {
        [self.view endEditing:YES];
        NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:[self groupBundleIdentifier]];
        [userDefault setObject:number forKey:NumberKey];
        [userDefault synchronize];
        
        [self loadNumber];
    }
}


- (IBAction)resetCallDirectoryExtensionPressed:(id)sender {
    /**
     CXCallDirectoryManager.h
     
     typedef NS_ENUM(NSInteger, CXCallDirectoryEnabledStatus) {
     CXCallDirectoryEnabledStatusUnknown = 0,
     CXCallDirectoryEnabledStatusDisabled = 1,
     CXCallDirectoryEnabledStatusEnabled = 2,
     } API_AVAILABLE(ios(10.0));
     
     CX_CLASS_AVAILABLE(ios(10.0))
     @interface CXCallDirectoryManager : NSObject
     
     @property (readonly, class) CXCallDirectoryManager *sharedInstance;
     
     - (void)reloadExtensionWithIdentifier:(NSString *)identifier completionHandler:(nullable void (^)(NSError *_Nullable error))completion;
     - (void)getEnabledStatusForExtensionWithIdentifier:(NSString *)identifier completionHandler:(void (^)(CXCallDirectoryEnabledStatus enabledStatus, NSError *_Nullable error))completion;
     
     @end
     */
    
    //判断是否有权限或者开关被打开
    __weak typeof(self)weakself = self;
    [[CXCallDirectoryManager sharedInstance] getEnabledStatusForExtensionWithIdentifier:@"orz.wintelsui.test.iOS11Demo.CallDirectoryExtension" completionHandler:^(CXCallDirectoryEnabledStatus enabledStatus, NSError * _Nullable error) {
        if (enabledStatus == CXCallDirectoryEnabledStatusEnabled) {
            //开关被打开
            [[CXCallDirectoryManager sharedInstance] reloadExtensionWithIdentifier:@"orz.wintelsui.test.iOS11Demo.CallDirectoryExtension" completionHandler:^(NSError * _Nullable error) {
                if (error) {
                    
                }
            }];
        }else if (enabledStatus == CXCallDirectoryEnabledStatusDisabled) {
            //开关被关闭
            [weakself showSimpleAlertTitle:@"开关被关闭" body:@"请去手机设置里打开" cancel:@"确定"];
        }else if (enabledStatus == CXCallDirectoryEnabledStatusUnknown) {
            //开关未知，请去手机设置里设置一次
            [weakself showSimpleAlertTitle:@"开关未知" body:@"请去手机设置里设置一次" cancel:@"确定"];
        }
    }];
    
}




#pragma mark - -- 以下为费代码，因为能从通讯录里选出来的绝对不会是陌生号码，O(∩_∩)O哈哈~ --

- (IBAction)contactPickerPressed:(id)sender {
    CNContactStore * contactStore = [[CNContactStore alloc]init];
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            }
            else if (!granted)
            {
                //没有权限
                NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
            }
            else
            {
                //有权限
                [self methodForContactPicker];
            }
        }];
    }
    else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
        //有权限
        [self methodForContactPicker];
    }
    else {
        NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
    }
}

-(void)methodForContactPicker{
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey,CNContactMiddleNameKey,CNContactGivenNameKey,CNContactFamilyNameKey];
    [self presentViewController:contactPicker animated:YES completion:nil];
}

#pragma mark - -- 通讯录选择器代理 --
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNPhoneNumber *phoneNumber = (CNPhoneNumber *)contactProperty.value;
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
//        NSString *name = [NSString stringWithFormat:@"%@%@%@",contactProperty.contact.familyName,contactProperty.contact.middleName,contactProperty.contact.givenName];
        /// 电话
        NSString *phone = phoneNumber.stringValue;
        
        if (phone) {
            [_numberTextField setText:phone];
        }
    }];
}

- (NSString *)groupBundleIdentifier{
    NSString *bundleIdentifier = [@"group." stringByAppendingString:[[NSBundle mainBundle] bundleIdentifier]];
    return bundleIdentifier;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
