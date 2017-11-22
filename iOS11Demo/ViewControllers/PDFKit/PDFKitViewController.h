//
//  PDFKitViewController.h
//  iOS11Demo
//
//  Created by wintel on 2017/9/27.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFKitViewController : UIViewController

@property (nonatomic, retain) NSURL *openUrl;

- (void)loadPDF;

@end
