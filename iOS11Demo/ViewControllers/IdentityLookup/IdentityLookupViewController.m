//
//  IdentityLookupViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/10/17.
//  Copyright © 2017年 wintel. All rights reserved.
//  具体内容见 MessageFilterExtension 文件

#import "IdentityLookupViewController.h"
#import <ContactsUI/ContactsUI.h>

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
