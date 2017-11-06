//
//  CoreNFCViewController.m
//  iOS11Demo
//
//  Created by wintelsui on 2017/10/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "CoreNFCViewController.h"
#import <CoreNFC/CoreNFC.h>

@interface CoreNFCViewController ()
<
NFCNDEFReaderSessionDelegate,
UITableViewDelegate,
UITableViewDataSource
>
{
    NFCNDEFReaderSession *_session;
    NSArray *_payloads;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation CoreNFCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - NFCNDEFReaderSessionDelegate start

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error{
    //如果收到error消息，session将会自动结束
    if (error) {
        switch (error.code) {
            case NFCReaderSessionInvalidationErrorFirstNDEFTagRead:
                //当第一个NDEF标签被成功读取后，会话将自动失效.
                break;
            case NFCReaderSessionInvalidationErrorUserCanceled:
                //用户调用[_session invalidateSession]主动结束扫描
                break;
            default:
                //NFCReaderSessionInvalidationErrorSessionTimeout,
                //NFCReaderSessionInvalidationErrorSessionTerminatedUnexpectedly,
                //NFCReaderSessionInvalidationErrorSystemIsBusy,
                //超时，系统忙，以外终止。。。。
                
                break;
        }
    }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages{
    if (messages) {
        //扫描到标签
        NFCNDEFMessage *NDEFMessage = messages.firstObject;
        _payloads = NDEFMessage.records;
        [_tableview reloadData];
    }
}

#pragma mark - NFCNDEFReaderSessionDelegate start


#pragma mark - UITableViewDelegate start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _payloads?[_payloads count]:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
    //根据textLabel文字内容自动布局高度
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger row = indexPath.row;
    [cell.textLabel setTextColor:[UIColor colorNamed:@"ColorMyPink"]];
    
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    
    NFCNDEFPayload *payload = [_payloads objectAtIndex:row];
    cell.textLabel.text = [self NFCNDEFPayloadDescription:payload];
    
//    NSMutableString *info = [[NSMutableString alloc] init];
//    [info appendString:@"payload Info:\n"];
//    for (int i = 0; i < row; i++) {
//        [info appendString:@"123123123\n"];
//    }
//    cell.textLabel.text = info;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UITableViewDelegate end

#pragma mark - -- Actions Start --

- (IBAction)scanButtonPressed:(id)sender {
    //如果设备支持 NFC 读取
    if ([NFCNDEFReaderSession readingAvailable]) {
        //_session每次需要新的初始化
        _session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_get_main_queue() invalidateAfterFirstRead:YES];
        
        //开始扫描
        [_session beginSession];
        
        //主动结束扫描
        //[_session invalidateSession]
    }else{
        [self showSimpleAlertTitle:@"📵❓💔" body:@"设备不支持 NFC 读取功能，或者没有权限使用该功能" cancel:@"确定"];
    }
}

#pragma mark - -- Actions End --

- (NSString *)NFCNDEFPayloadDescription:(NFCNDEFPayload *)payload{
    NSMutableString *info = [[NSMutableString alloc] init];
    [info appendString:@"payload Info:\n"];
    
    {
        NSString *TNFString;
        switch (payload.typeNameFormat) {
            case NFCTypeNameFormatEmpty:
                TNFString = @"TypeNameFormat:（Empty）无效的空数据\n";
                break;
            case NFCTypeNameFormatNFCWellKnown:
                TNFString = @"TypeNameFormat:（NFCWellKnown）类型\n";
                break;
            case NFCTypeNameFormatMedia:
                TNFString = @"TypeNameFormat:（Media）类型\n";
                break;
            case NFCTypeNameFormatAbsoluteURI:
                TNFString = @"TypeNameFormat:（AbsoluteURI）类型\n";
                break;
            case NFCTypeNameFormatNFCExternal:
                TNFString = @"TypeNameFormat:（NFCExternal）类型\n";
                break;
            case NFCTypeNameFormatUnknown:
                TNFString = @"TypeNameFormat:（Unknown）未知类型\n";
                break;
            case NFCTypeNameFormatUnchanged:
                TNFString = @"TypeNameFormat:（Unchanged）\n";
                break;
            default:
                TNFString = @"TypeNameFormat: 无效数据\n";
                break;
        }
        [info appendString:TNFString];
    }
//    @property (nonatomic, copy) NSData *type;
//    @property (nonatomic, copy) NSData *identifier;
//    @property (nonatomic, copy) NSData *payload;
    NSString *typeString = [[NSString alloc] initWithData:payload.type encoding:NSUTF8StringEncoding];
    NSString *identifierString = [[NSString alloc] initWithData:payload.identifier encoding:NSUTF8StringEncoding];
    NSString *payloadString = [[NSString alloc] initWithData:payload.payload encoding:NSUTF8StringEncoding];
    if (typeString) {
        [info appendFormat:@"type:%@\n",typeString];
    }
    if (identifierString) {
        [info appendFormat:@"identifier:%@\n",identifierString];
    }
    if (payloadString) {
        [info appendFormat:@"payload:%@\n",payloadString];
    }
    return info;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
