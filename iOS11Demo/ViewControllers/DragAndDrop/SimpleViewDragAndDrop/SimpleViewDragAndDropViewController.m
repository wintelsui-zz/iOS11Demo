//
//  SimpleViewDragAndDropViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/6.
//Copyright © 2017年 wintel. All rights reserved.
//

#import "SimpleViewDragAndDropViewController.h"

#import "FaceView.h"

@interface SimpleViewDragAndDropViewController ()
<
UITextDragDelegate,
UITextDropDelegate
>
{
    FaceView *_faceview;
}

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation SimpleViewDragAndDropViewController

#pragma mark - SimpleViewDragAndDropViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTextField.textDragDelegate = self;
    _myTextField.textDropDelegate = self;
    
    _myTextView.textDragDelegate = self;
    _myTextView.textDropDelegate = self;
    
    [self setupFaceView];
}

- (void)setupFaceView{
    __weak typeof(self)weakself = self;
    
    _faceview = [[FaceView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    [self.view addSubview:_faceview];
    
    [_faceview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo((0 - IPHONEX_HEIGHT_SAFE_BOTTOM_VERTICAL));
        make.width.height.mas_equalTo(120);
        make.centerX.equalTo(weakself.view);
    }];
}

#pragma mark - -- UITextDragDelegate Start --

- (NSArray<UIDragItem *> *)textDraggableView:(UIView<UITextDraggable> *)textDraggableView itemsForDrag:(id<UITextDragRequest>)dragRequest{
    NSLog(@"textDraggableView:%@,itemsForDrag:",textDraggableView);
    return dragRequest.suggestedItems;
}

- (nullable UITargetedDragPreview *)textDraggableView:(UIView<UITextDraggable> *)textDraggableView dragPreviewForLiftingItem:(UIDragItem *)item session:(id<UIDragSession>)session{
    NSLog(@"textDraggableView:%@,dragPreviewForLiftingItem:",textDraggableView);
    
    UIDragPreviewParameters* params = [UIDragPreviewParameters new];
    params.backgroundColor = [UIColor clearColor];
    
    UITargetedDragPreview* preview = [[UITargetedDragPreview alloc] initWithView:textDraggableView parameters:params];
    
    return preview;
}

- (void)textDraggableView:(UIView<UITextDraggable> *)textDraggableView willAnimateLiftWithAnimator:(id<UIDragAnimating>)animator session:(id<UIDragSession>)session{
    NSLog(@"textDraggableView:%@,willAnimateLiftWithAnimator:",textDraggableView);
}

- (void)textDraggableView:(UIView<UITextDraggable> *)textDraggableView dragSessionWillBegin:(id<UIDragSession>)session{
    NSLog(@"textDraggableView:%@,dragSessionWillBegin:",textDraggableView);
}

- (void)textDraggableView:(UIView<UITextDraggable> *)textDraggableView dragSessionDidEnd:(id<UIDragSession>)session withOperation:(UIDropOperation)operation{
    NSLog(@"textDraggableView:%@,dragSessionDidEnd:",textDraggableView);
}

#pragma mark - -- UITextDragDelegate End --

#pragma mark - -- UITextDropDelegate Start --

- (UITextDropEditability)textDroppableView:(UIView<UITextDroppable> *)textDroppableView willBecomeEditableForDrop:(id<UITextDropRequest>)drop{
    NSLog(@"textDraggableView:%@,willBecomeEditableForDrop:",textDroppableView);
    //UITextDropEditabilityNo：不可编辑模式，不允许拖拽内容到控件
    //UITextDropEditabilityTemporary：不可编辑模式拖拽内容到控件后仍为不可编辑模式
    //UITextDropEditabilityYes：不可编辑模式拖拽内容到控件后变可编辑模式
    return UITextDropEditabilityYes;
}

- (UITextDropProposal*)textDroppableView:(UIView<UITextDroppable> *)textDroppableView proposalForDrop:(id<UITextDropRequest>)drop{
//    NSLog(@"textDraggableView:%@,proposalForDrop:",textDroppableView);
    //*****该方法在拖拽过程中会多次且频繁的回调，所以尽量尽量做最少的工作。*****
    /**
     * -当拖动进入文本控件时，
     * -当文本位置*变化时，拖动移动到文本控件上
     * -当拖动会话更改时(例如添加的项)
     * 。。。。。。
     * 都会回调该方法
     */
    //改变拖拽行为
    return [[UITextDropProposal alloc] initWithDropOperation:UIDropOperationCopy];
}

- (void)textDroppableView:(UIView<UITextDroppable> *)textDroppableView willPerformDrop:(id<UITextDropRequest>)drop{
    NSLog(@"textDraggableView:%@,willPerformDrop:",textDroppableView);
    
}


- (nullable UITargetedDragPreview *)textDroppableView:(UIView<UITextDroppable> *)textDroppableView previewForDroppingAllItemsWithDefault:(UITargetedDragPreview *)defaultPreview{
    NSLog(@"textDroppableView:%@,previewForDroppingAllItemsWithDefault:",textDroppableView);
    //自定义预览
    return defaultPreview;
}

- (void)textDroppableView:(UIView<UITextDroppable> *)textDroppableView dropSessionDidEnter:(id<UIDropSession>)session{
    NSLog(@"textDroppableView:%@,dropSessionDidEnter:",textDroppableView);
    //当内容被拖拽到支持拖放控件上方时（进入拖放控件frame），回调该方法
}

- (void)textDroppableView:(UIView<UITextDroppable> *)textDroppableView dropSessionDidUpdate:(id<UIDropSession>)session{
    //NSLog(@"textDroppableView:%@,dropSessionDidUpdate:",textDroppableView);
    //*****该方法在拖拽过程中会多次且频繁的回调，所以尽量尽量做最少的工作。*****
    //当内容被拖拽时，不停地回调此方法
}

- (void)textDroppableView:(UIView<UITextDroppable> *)textDroppableView dropSessionDidExit:(id<UIDropSession>)session{
    NSLog(@"textDroppableView:%@,dropSessionDidExit:",textDroppableView);
    //当内容被拖拽时，拖拽离开可放控件时回调此方法
}

- (void)textDroppableView:(UIView<UITextDroppable> *)textDroppableView dropSessionDidEnd:(id<UIDropSession>)session{
    NSLog(@"textDroppableView:%@,dropSessionDidEnd:",textDroppableView);
    //拖放结束时调用
}

#pragma mark - -- UITextDropDelegate End --

#pragma mark - Public
 
#pragma mark - Private
 
#pragma mark - Getter
 
#pragma mark - Setter

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
