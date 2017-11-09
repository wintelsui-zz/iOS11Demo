//
//  SimpleViewDragAndDropViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/6.
//Copyright © 2017年 wintel. All rights reserved.
//

#import "SimpleViewDragAndDropViewController.h"

#import <Lottie/Lottie.h>

@interface SimpleViewDragAndDropViewController ()
<
UITextDragDelegate,
UITextDropDelegate,
UIDragInteractionDelegate,
UIDropInteractionDelegate
>
{
    UIView *_dropView;
    LOTAnimationView *_scanAnimationView;
    LOTAnimationView *_checkAnimationView;
    LOTAnimationView *_loadingAnimationView;
    
    UIImageView *_dropAndDragView;
}

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation SimpleViewDragAndDropViewController

#pragma mark - SimpleViewDragAndDropViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
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
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    _myTextField.textDragDelegate = self;
    _myTextField.textDropDelegate = self;
    
    _myTextView.textDragDelegate = self;
    _myTextView.textDropDelegate = self;
    
    [self setupDropView];
    [self setupDropAndDragView];
    
    [self showSuccessAnimation:@2];
}


/**
 初始化一个支持拖放的 ImageView
 */
- (void)setupDropAndDragView{
    __weak typeof(self)weakself = self;
    _dropAndDragView = ({
        UIImageView *imageview = [[UIImageView alloc] init];
        [imageview setBackgroundColor:[UIColor lightGrayColor]];
        imageview.userInteractionEnabled = YES;
        
        [weakself.view addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_dropView.mas_top).offset(-20);
            make.centerX.equalTo(weakself.view);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(200);
        }];
        
        //添加拖拽能力
        [weakself addDragAbilityForView:imageview];
        //添加拖放能力
        [weakself addDropAbilityForView:imageview];
        
        imageview;
    });
}

/**
 初始化一个支持放的 View
 */
- (void)setupDropView{
    __weak typeof(self)weakself = self;
    _dropView = ({
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:RGBA(158, 221, 218, 0.5)];
        view.layer.cornerRadius = 5.0;
        view.layer.borderColor = RGBA(43, 150, 245, 0.5).CGColor;
        view.layer.borderWidth = 1.0;
        [view setUserInteractionEnabled:YES];
        
        [weakself.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(100);
            make.bottom.mas_equalTo(0 - 10 - IPHONEX_HEIGHT_SAFE_BOTTOM_VERTICAL);
            make.centerX.equalTo(weakself.view);
        }];
        
        //添加了拖放的能力
        [weakself addDropAbilityForView:view];
        
        view;
    });
    
    _scanAnimationView = ({
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"AnimationScan"];
        animationView.loopAnimation = YES;
        [animationView setUserInteractionEnabled:NO];
        [_dropView addSubview:animationView];
        
        
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
            make.center.equalTo(_dropView);
        }];
        
        animationView;
    });
    [_scanAnimationView setHidden:NO];
    [_scanAnimationView play];
    
    _checkAnimationView = ({
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"AnimationCheck"];
        animationView.loopAnimation = YES;
        [animationView setUserInteractionEnabled:NO];
        [_dropView addSubview:animationView];
        
        
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
            make.center.equalTo(_dropView);
        }];
        
        animationView;
    });
    [_checkAnimationView setHidden:YES];
    
    _loadingAnimationView = ({
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"AnimationTriangle_loading"];
        animationView.loopAnimation = YES;
        [animationView setUserInteractionEnabled:NO];
        [_dropView addSubview:animationView];
        
        
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
            make.center.equalTo(_dropView);
        }];
        
        animationView;
    });
    [_loadingAnimationView setHidden:YES];
}

/**
 为视图添加拖拽能力

 @param view 视图
 */
- (void)addDragAbilityForView:(UIView *)view {
    UIDragInteraction *dragInteratcion = [[UIDragInteraction alloc] initWithDelegate:self];
    dragInteratcion.enabled = YES;
    [view addInteraction:dragInteratcion];
}

/**
 为视图添加拖放能力
 
 @param view 视图
 */
- (void)addDropAbilityForView:(UIView *)view {
    UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    [view addInteraction:dropInteraction];
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
    [preview.view setBackgroundColor:RGB(155, 89, 182)];
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
    [defaultPreview.view setBackgroundColor:RGB(192, 57, 43)];
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

#pragma mark - -- UIDragInteractionDelegate Start --

/**
 开始拖拽 添加了 UIDragInteraction 的控件 会调用这个方法，从而获取可供拖拽的 item
 如果返回 nil，则不会发生任何拖拽事件
 */
- (nonnull NSArray<UIDragItem *> *)dragInteraction:(nonnull UIDragInteraction *)interaction itemsForBeginningSession:(nonnull id<UIDragSession>)session {
    NSLog(@"itemsForBeginningSession");
    // 该方法进行提供数据
    NSItemProvider *provider = [[NSItemProvider alloc] initWithObject:_dropAndDragView.image];
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:provider];
    dragItem.localObject = _dropAndDragView.image;
    return @[dragItem];
}

/**
 对刚开始拖动处于 lift 状态的 item 会有一个 preview 的预览功效，其动画是系统自动生成的，但是需要我们通过该方法提供 preview 的相关信息
 如果返回 nil，就相当于指明该 item 没有预览效果
 如果没有实现该方法，interaction.view 就会生成一个 UITargetedDragPreview
 */
- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForLiftingItem:(UIDragItem *)item session:(id<UIDragSession>)session {
    
    NSLog(@"previewForLiftingItem");
    
    UIDragPreviewParameters *previewParameters = [[UIDragPreviewParameters alloc] init];
    previewParameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:_dropAndDragView.bounds cornerRadius:10];
    UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:interaction.view parameters:previewParameters];
    return dragPreview;
}

// 向当前已经存在的拖拽事件中添加一个新的 UIDragItem
- (NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForAddingToSession:(id<UIDragSession>)session withTouchAtPoint:(CGPoint)point {
    return nil;
}

// 当 lift 动画准备执行的时候会调用该方法，可以在这个方法里面对拖动的 item 添加动画
- (void)dragInteraction:(UIDragInteraction *)interaction willAnimateLiftWithAnimator:(id<UIDragAnimating>)animator session:(id<UIDragSession>)session {
    NSLog(@"willAnimateLiftWithAnimator:session:");
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        if (finalPosition == UIViewAnimatingPositionEnd) {
            _dropAndDragView.alpha = 0.6;
        }
    }];
}

// 当取消动画准备执行的时候会调用这个方法
- (void)dragInteraction:(UIDragInteraction *)interaction item:(UIDragItem *)item willAnimateCancelWithAnimator:(id<UIDragAnimating>)animator {
    NSLog(@"item:willAnimateCancelWithAnimator:");
    [animator addAnimations:^{
        _dropAndDragView.alpha = 1;
    }];
}

// 当用户完成一次拖拽操作，并且所有相关的动画都执行完毕的时候会调用这个方法，这时候被拖动的item 应该恢复正常的展示外观
- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session didEndWithOperation:(UIDropOperation)operation {
    NSLog(@"session:didEndWithOperation:");
    
    [UIView animateWithDuration:0.25 animations:^{
        //        _dropAndDragView.center = [session locationInView:self.view];
        _dropAndDragView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (nullable UITargetedDragPreview *)dragInteraction:(UIDragInteraction *)interaction previewForCancellingItem:(UIDragItem *)item withDefault:(UITargetedDragPreview *)defaultPreview {
    NSLog(@"previewForCancellingItem");
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, interaction.view.bounds.size.width, interaction.view.bounds.size.height)];
    imageView.image = _dropAndDragView.image;
    
    UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:interaction.view center:CGPointMake(interaction.view.bounds.size.width / 2, interaction.view.bounds.size.height / 2)];
    
    UITargetedDragPreview *dragPreview = [[UITargetedDragPreview alloc] initWithView:imageView parameters:[UIDragPreviewParameters new] target:previewTarget];
    return dragPreview;
}

#pragma mark - -- UIDragInteractionDelegate End --

#pragma mark - -- UIDropInteractionDelegate Start --

- (BOOL)dropInteraction:(UIDropInteraction *)interaction canHandleSession:(id<UIDropSession>)session {
    // 可以加载image的控件都可以
    return [session canLoadObjectsOfClass:[UIImage class]];
    
}

- (void)dropInteraction:(UIDropInteraction *)interaction sessionDidEnter:(id<UIDropSession>)session {
    NSLog(@"sessionDidEnter");
}

- (UIDropProposal *)dropInteraction:(UIDropInteraction *)interaction sessionDidUpdate:(id<UIDropSession>)session {
    
    // 如果 session.localDragSession 为nil，说明这一操作源自另外一个app，
    UIDropOperation dropOperation = session.localDragSession ? UIDropOperationMove : UIDropOperationCopy;
    
    UIDropProposal *dropProposal = [[UIDropProposal alloc] initWithDropOperation:dropOperation];
    return dropProposal;
}

- (void)dropInteraction:(UIDropInteraction *)interaction performDrop:(id<UIDropSession>)session {
    NSLog(@"performDrop");
    // 同样的，在这个方法内部也要判断是否源自本app
    if (session.localDragSession) {
        //        CGPoint dropPoint = [session locationInView:interaction.view];
        CGPoint dropPoint = [session locationInView:self.view];
        for (UIDragItem *item in session.items) {
            [self _loadImageWithItemProvider:item.itemProvider center:dropPoint];
        }
    }
}

- (UITargetedDragPreview *)dropInteraction:(UIDropInteraction *)interaction previewForDroppingItem:(UIDragItem *)item withDefault:(UITargetedDragPreview *)defaultPreview {
    NSLog(@"previewForDroppingItem");
    if (item.localObject) {
        CGPoint dropPoint = defaultPreview.view.center;
        UIDragPreviewTarget *previewTarget = [[UIDragPreviewTarget alloc] initWithContainer:_dropAndDragView center:dropPoint];
        return [defaultPreview retargetedPreviewWithTarget:previewTarget];
    } else {
        return nil;
    }
}

// 产生本地动画
- (void)dropInteraction:(UIDropInteraction *)interaction item:(UIDragItem *)item willAnimateDropWithAnimator:(id<UIDragAnimating>)animator {
    
    [animator addAnimations:^{
        _dropAndDragView.alpha = 0;
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        _dropAndDragView.alpha = 1;
    }];
}

#pragma mark - -- UIDropInteractionDelegate End --

- (void)_loadImageWithItemProvider:(NSItemProvider *)itemProvider center:(CGPoint)center {
    NSLog(@"_loadImageWithItemProvider:center:");
    // 该方法用于取出数据
    NSProgress *progress = [itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
        // 回调的代码块默认就在主线程
        UIImage *image = (UIImage *)object;
        _dropAndDragView.image = image;
        _dropAndDragView.center = center;
        
    }];
    // 是否完成
    BOOL isFinished = progress.isFinished;
    // 当前已完成进度
    CGFloat progressSoFar = progress.fractionCompleted;
    
    [progress cancel];
    
}


#pragma mark - Public
 
#pragma mark - Private
 
#pragma mark - Getter
 
#pragma mark - Setter

#pragma mark - Others

- (IBAction)endEditingPressed:(id)sender {
    [self.view endEditing:YES];
}

- (void)showSuccessAnimation:(NSNumber *)mode{
    if ([mode isEqualToNumber:@0]) {
        //Scaning
        [_loadingAnimationView setHidden:YES];
        [_loadingAnimationView stop];
        
        [_checkAnimationView setHidden:YES];
        [_checkAnimationView stop];
        
        [_scanAnimationView setHidden:NO];
        [_scanAnimationView play];
    }else if ([mode isEqualToNumber:@1]) {
        //Loading
        [_checkAnimationView setHidden:YES];
        [_checkAnimationView stop];
        
        [_scanAnimationView setHidden:YES];
        [_scanAnimationView stop];
        
        [_loadingAnimationView setHidden:NO];
        [_loadingAnimationView play];
    }else if ([mode isEqualToNumber:@2]) {
        //Success
        [_loadingAnimationView setHidden:YES];
        [_loadingAnimationView stop];
        
        [_scanAnimationView setHidden:YES];
        [_scanAnimationView stop];
        
        [_checkAnimationView setHidden:NO];
        [_checkAnimationView play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    _myTextField.textDragDelegate = nil;
    _myTextField.textDropDelegate = nil;
    
    _myTextView.textDragDelegate = nil;
    _myTextView.textDropDelegate = nil;
    
}
@end
