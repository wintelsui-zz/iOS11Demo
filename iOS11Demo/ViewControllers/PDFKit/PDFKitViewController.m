//
//  PDFKitViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/9/27.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "PDFKitViewController.h"
#import <PDFKit/PDFKit.h>

#import "PDFWatermarkPage.h"

@interface PDFKitViewController ()
<
PDFViewDelegate,
PDFDocumentDelegate
>
{
    PDFView *_pdfView;
    
    UIView *_actionView;
    UILabel *_modeLabel;
    UIButton *_modeButton;
    UIButton *_waterMarkButton;
    
    UIButton *_upButton;
    UIButton *_downButton;
    UIButton *_firstButton;
    UIButton *_lastButton;
    
    BOOL _waterMark;
}
@end

@implementation PDFKitViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakself = self;
    if (_openUrl == nil) {
        NSString *pdfPath = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"pdf"];
        _openUrl = [NSURL fileURLWithPath:pdfPath];
    }
    _waterMark = NO;
    
    _actionView = [[UIView alloc] init];
    [_actionView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:_actionView];
    [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(88 + IPHONEX_HEIGHT_SAFE_BOTTOM_VERTICAL);
    }];
    
    _pdfView = [[PDFView alloc] init];
    _pdfView.backgroundColor = [UIColor whiteColor];
    _pdfView.autoScales = YES;
    _pdfView.delegate = self;
    [self.view addSubview:_pdfView];
    [_pdfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(_actionView.mas_top);
        make.right.mas_equalTo(0);
    }];
    
    _modeLabel = [[UILabel alloc] init];
    [_modeLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [_modeLabel setText:@"Mode:"];
    [_modeLabel sizeToFit];
    [_actionView addSubview:_modeLabel];
    
    _modeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_modeButton setBackgroundColor:[UIColor whiteColor]];
    _modeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _modeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self refreshModeButtonTitle];
    [_actionView addSubview:_modeButton];
    
    [[_modeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSInteger dm = _pdfView.displayMode;
        if (dm == kPDFDisplayTwoUpContinuous) {
            dm = kPDFDisplaySinglePage;
        }else{
            dm ++;
        }
        _pdfView.displayMode = dm;
        _pdfView.autoScales = YES;
        [weakself refreshModeButtonTitle];
    }];
    
    _waterMarkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_waterMarkButton setBackgroundColor:[UIColor whiteColor]];
    _waterMarkButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_waterMarkButton setTitle:NSLocalizedString(@"WaterMark", nil) forState:UIControlStateNormal];
    [_actionView addSubview:_waterMarkButton];
    
    [[_waterMarkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        _waterMark = !_waterMark;
        [weakself loadPDF];
    }];
    
    
    _firstButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_firstButton setBackgroundColor:[UIColor whiteColor]];
    [_firstButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_firstButton setTitle:@"first" forState:UIControlStateNormal];
    [_actionView addSubview:_firstButton];
    [[_firstButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (_pdfView.canGoToFirstPage) {
            
        }
        [_pdfView goToFirstPage:nil];
    }];
    
    _lastButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_lastButton setBackgroundColor:[UIColor whiteColor]];
    [_lastButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_lastButton setTitle:@"last" forState:UIControlStateNormal];
    [_actionView addSubview:_lastButton];
    [[_lastButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (_pdfView.canGoToLastPage) {
            [_pdfView goToLastPage:nil];
        }
    }];
    
    _upButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_upButton setBackgroundColor:[UIColor whiteColor]];
    [_upButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_upButton setTitle:@"previous" forState:UIControlStateNormal];
    [_actionView addSubview:_upButton];
    [[_upButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (_pdfView.canGoToPreviousPage) {
            [_pdfView goToPreviousPage:nil];
        }
    }];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_downButton setBackgroundColor:[UIColor whiteColor]];
    [_downButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_downButton setTitle:@"next" forState:UIControlStateNormal];
    [_actionView addSubview:_downButton];
    [[_downButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (_pdfView.canGoToNextPage) {
            [_pdfView goToNextPage:nil];
        }
    }];
    
    [_modeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(34);
    }];
    
    [_modeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(_modeLabel.mas_right);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(150);
    }];
    
    [_waterMarkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(70);
    }];
    
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_modeLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(70);
    }];
    [_upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstButton.mas_top);
        make.left.mas_equalTo(_firstButton.mas_right).mas_offset(1);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(70);
    }];
    [_downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstButton.mas_top);
        make.left.mas_equalTo(_upButton.mas_right).mas_offset(1);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(70);
    }];
    [_lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstButton.mas_top);
        make.left.mas_equalTo(_downButton.mas_right).mas_offset(1);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(70);
    }];
    
    [self loadPDF];
}

- (void)refreshModeButtonTitle{
    if (_pdfView.displayMode == kPDFDisplaySinglePage) {
        [_modeButton setTitle:@"SinglePage" forState:UIControlStateNormal];
    }
    else if (_pdfView.displayMode == kPDFDisplaySinglePageContinuous) {
        [_modeButton setTitle:@"SinglePageContinuous" forState:UIControlStateNormal];
    }
    else if (_pdfView.displayMode == kPDFDisplayTwoUp) {
        [_modeButton setTitle:@"TwoUp" forState:UIControlStateNormal];
    }
    else if (_pdfView.displayMode == kPDFDisplayTwoUpContinuous) {
        [_modeButton setTitle:@"TwoUpContinuous" forState:UIControlStateNormal];
    }
}

- (void)loadPDF{
    if (_openUrl) {
        PDFDocument *pdfDoc = [[PDFDocument alloc] initWithURL:_openUrl];
        if (pdfDoc) {
            pdfDoc.delegate = self;
            [_pdfView setDocument:pdfDoc];
            _pdfView.autoScales = YES;
        }
    }
}

#pragma mark - -- PDFDocumentDelegate --
- (Class)classForPage{
    return (_waterMark ? [PDFWatermarkPage class] : [PDFPage class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
