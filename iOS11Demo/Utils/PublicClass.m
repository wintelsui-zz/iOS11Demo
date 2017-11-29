//
//  PublicClass.m
//  LilysFriends
//
//  Created by wintel on 17/2/9.
//  Copyright © 2017年 wintelsui. All rights reserved.
//

#import "PublicClass.h"
//#import "MBProgressHUD.h"


@implementation PublicClass

+ (CGSize)getLabelWithSize:(NSString*)string width:(CGFloat)width font:(UIFont *)font limit:(CGSize)limitSize
{
    CGSize size;
    if (string == nil || string.length == 0) {
        size = CGSizeMake(0, 0);
    }
    else{
        NSDictionary *attribute = @{NSFontAttributeName:font};
        size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    }
    if (size.height < limitSize.width) {
        size = CGSizeMake(size.width, limitSize.width);
    }
    if (size.height > limitSize.height) {
        size = CGSizeMake(size.width, limitSize.height);
    }
    return size;
}

//+ (void)showMessage:(NSString *)messgae travel:(CGFloat)travel{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:APP_DELEGATE.window animated:YES];
//    hud.detailsLabel.font = [UIFont systemFontOfSize:16.0f];
//    hud.detailsLabel.text = messgae;
//    hud.mode = MBProgressHUDModeText;
//    hud.removeFromSuperViewOnHide = YES;
//    
//    [hud hideAnimated:YES afterDelay:travel];
//}

+ (void)TableViewsetExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


//
//
//+ (NSInteger)connectedToNetwork
//{
//    //SCNetworkReachabilityFlags flags;
//    BOOL receivedFlags=YES;
//
//    //    return 0;
//
//
//    //    SCNetworkReachabilityRef reachability =
//    //    SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"www.360doc.com" UTF8String]);
//    //
//    //    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
//    //
//    //
//    //    CFRelease(reachability);
//
//    if (!receivedFlags)
//        //if (!receivedFlags || (flags == 0) )
//    {
//        NSLog(@"0_______________无网络连接");
//        return 0;
//    } else {
//        //NSInteger currentReachabilityStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
//        //        NSLog(@"currentReachabilityStatus:%ld",(long)currentReachabilityStatus);
//        //        NSLog(@"NotReachable:%ld",(long)NotReachable);
//        //        NSLog(@"ReachableViaWiFi:%ld",(long)ReachableViaWiFi);
//        //        NSLog(@"ReachableViaWWAN:%ld",(long)ReachableViaWWAN);
//        if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) {
//            //            NSLog(@"1_______________WLAN网络连接");
//            return 1;
//        }else{
//            if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
//                //                NSLog(@"2_______________2G/3G网络连接");
//                return 2;
//            }
//        }
//    }
//    return 0;
//}


@end
