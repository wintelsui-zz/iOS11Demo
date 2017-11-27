//
//  TableViewDragAndDropViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/13.
//Copyright © 2017年 wintel. All rights reserved.
//

#import "TableViewDragAndDropViewController.h"

#import "TableViewDragAndDropCell.h"

#import "ImageDataModels.h"

#define SwitchShowDragLog 0
#define SwitchShowDropLog 1

@interface TableViewDragAndDropViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITableViewDragDelegate,
UITableViewDropDelegate
>
{
    NSMutableArray *_arrayImages;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation TableViewDragAndDropViewController

#pragma mark - TableViewDragAndDropViewController

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
    
    _arrayImages = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 13; i++){
        NSString *imageName = [NSString stringWithFormat:@"Aragaki_%ld.jpg",(long)i];
        
        ImageDataModels *imageData = [ImageDataModels modelObjectWithName:imageName source:ImageDataSourceTypeInApp];
        if (imageData) {
            [_arrayImages addObject:imageData];
        }
    }
    
    _tableview.dragDelegate = self;
    _tableview.dropDelegate = self;
    _tableview.dragInteractionEnabled = YES;
}

#pragma mark - UITableViewDelegate start

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_arrayImages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    TableViewDragAndDropCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TableViewDragAndDropCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ImageDataModels *imageData = [_arrayImages objectAtIndex:indexPath.row];
    [cell.myImageView setImage:[imageData image]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - -- 新的 Swipe 侧滑 --
/** 尾部侧滑，右遍侧滑菜单 */
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"tableView:%@ trailingSwipeActionsConfigurationForRowAtIndexPath:%@",tableView,indexPath);
    
    UIContextualAction *deleteRowAction01 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除01" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [_arrayImages removeObjectAtIndex:indexPath.row];
        
        completionHandler(YES);
    }];
    
    UIContextualAction *deleteRowAction02 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"右滑02" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor randomColor];
        
        completionHandler(YES);
    }];
    
    if (indexPath.row % 2 == 0) {
        //无法使用 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal 显示原图
        deleteRowAction01.image = [UIImage imageNamed:@"icon_bianping-yuanicon-5"];
        deleteRowAction02.image = [UIImage imageNamed:@"icon_bianping-yuanicon-6"];
    }
    
    UISwipeActionsConfiguration *trailingSwipeRowConfiguration = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction01,deleteRowAction02]];
    return trailingSwipeRowConfiguration;
}

/** 头部侧滑，左遍侧滑菜单 */
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"tableView:%@ leadingSwipeActionsConfigurationForRowAtIndexPath:%@",tableView,indexPath);
    
    UIContextualAction *leadingSwipeRowAction01 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"左滑01" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor randomColor];
        
        completionHandler(YES);
    }];
    leadingSwipeRowAction01.backgroundColor = [UIColor randomColor];
    
    UIContextualAction *leadingSwipeRowAction02 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"左滑02" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor randomColor];
        
        completionHandler(YES);
    }];
    leadingSwipeRowAction02.backgroundColor = [UIColor randomColor];
    
    if (indexPath.row % 2 == 0) {
        leadingSwipeRowAction01.image = [UIImage imageNamed:@"icon_bianping-yuanicon-7"];
        leadingSwipeRowAction02.image = [UIImage imageNamed:@"icon_bianping-yuanicon-8"];
    }
    
    UISwipeActionsConfiguration *leadingSwipeRowConfiguration = [UISwipeActionsConfiguration configurationWithActions:@[leadingSwipeRowAction01,leadingSwipeRowAction02]];
    return leadingSwipeRowConfiguration;
}

#pragma mark - UITableViewDelegate end

#pragma mark - UITableViewDragDelegate start

/**
 第一个方法
 支持拖拽的控件，可拖拽的UIDragItem
 返回 nil，不允许拖拽
 */
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath{
    if (SwitchShowDragLog) {
        NSLog(@"tableView:%@ itemsForBeginningDragSession:%@ atIndexPath:%@",tableView,session,indexPath);
    }
    NSString *info = @"";
    ImageDataModels *imageData = [_arrayImages objectAtIndex:indexPath.row];
    if (imageData) {
        info = [[imageData dictionaryRepresentation] JSONString];
        //- (instancetype)initWithObject:(id<NSItemProviderWriting>)object
        NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:info];
        
        UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
        
        return @[item];
    }
    return nil;
}

//@optional

// Allows customization of the preview used for the row when it is lifted or if the drag cancels.
// If not implemented or if nil is returned, the entire cell will be used for the preview.
/**
 第二个方法
 支持拖拽的控件在拖拽是展现的预览视图的参数
 返回 nil 则预览整行
 */
- (nullable UIDragPreviewParameters *)tableView:(UITableView *)tableView dragPreviewParametersForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (SwitchShowDragLog) {
        NSLog(@"tableView:%@ dragPreviewParametersForRowAtIndexPath:%@",tableView,indexPath);
    }
    
    UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
    CGRect rect = CGRectMake(20, 0, tableView.bounds.size.width - 40, 150);
    parameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:30];
    return parameters;
}

// Controls whether move operations are allowed for the drag session.
// If not implemented, defaults to YES.
/**
 第二个方法
 拖动是否可以移动
 */
- (BOOL)tableView:(UITableView *)tableView dragSessionAllowsMoveOperation:(id<UIDragSession>)session;{
    if (SwitchShowDragLog) {
        NSLog(@"tableView:%@ dragSessionAllowsMoveOperation:%@",tableView,session);
    }
    return YES;
}

// Called after the lift animation has completed to signal the start of a drag session.
// This call will always be balanced with a corresponding call to -tableView:dragSessionDidEnd:
/**
 第三个方法
 拖动开始
 */
- (void)tableView:(UITableView *)tableView dragSessionWillBegin:(id<UIDragSession>)session{
    if (SwitchShowDragLog) {
        NSLog(@"tableView:%@ dragSessionWillBegin:%@",tableView,session);
    }
    
}

// Called to signal the end of the drag session.
/**
 第四个方法
 拖动结束
 */
- (void)tableView:(UITableView *)tableView dragSessionDidEnd:(id<UIDragSession>)session{
    if (SwitchShowDragLog) {
        NSLog(@"tableView:%@ dragSessionDidEnd:%@",tableView,session);
    }
    
}

// Controls whether the drag session is restricted to the source application.
// If not implemented, defaults to NO.
/**
 限制拖动只能在应用内，当拖动离开应用时调用（iPad 分屏模式），
 */
- (BOOL)tableView:(UITableView *)tableView dragSessionIsRestrictedToDraggingApplication:(id<UIDragSession>)session{
    if (SwitchShowDragLog) {
        NSLog(@"tableView:%@ dragSessionIsRestrictedToDraggingApplication:%@",tableView,session);
    }
    return YES;
}

/**
 向当前拖拽事件中追加UIDragItem
 */
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point{
    if (SwitchShowDragLog) {
        NSLog(@"tableView:%@ itemsForAddingToDragSession:%@ atIndexPath:%@ point:%@",tableView,session,indexPath,@(point));
    }
    
    NSString *info = @"";
    ImageDataModels *imageData = [_arrayImages objectAtIndex:indexPath.row];
    if (imageData) {
        info = [[imageData dictionaryRepresentation] JSONString];
        //- (instancetype)initWithObject:(id<NSItemProviderWriting>)object
        NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:info];
        
        UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
        
        return @[item];
    }
    return nil;
}

#pragma mark - UITableViewDragDelegate end

#pragma mark - UITableViewDropDelegate start

//@required
//
// Called when the user initiates the drop.
// Use the drop coordinator to access the items in the drop and the final destination index path and proposal for the drop,
// as well as specify how you wish to animate each item to its final position.
// If your implementation of this method does nothing, default drop animations will be supplied and the table view will
// revert back to its initial state before the drop session entered.
/**
    这里执行拖放成功后的操作，是插入，还是移动等等
 */
- (void)tableView:(UITableView *)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator{
    if (SwitchShowDropLog) {
        NSLog(@"tableView:%@ performDropWithCoordinator:%@",tableView,coordinator);
        /**
         tableView:
         <UITableView: 0x7fd1ff083e00; frame = (0 116; 1366 908); clipsToBounds = YES; autoresize = RM+BM; gestureRecognizers = <NSArray: 0x6000006556f0>; layer = <CALayer: 0x60000042fcc0>; contentOffset: {0, 0}; contentSize: {1366, 1800}; adjustedContentInset: {0, 0, 0, 0}>
         performDropWithCoordinator:<_UITableViewDropCoordinatorImpl: 0x604000865e00>
         */
        NSLog(@"coordinator:\n%@\n%@\n%@\n%@",coordinator.destinationIndexPath,coordinator.proposal,coordinator.items,coordinator.session);
    }
    NSIndexPath *sourceIndexPath = nil;
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    UITableViewDropProposal *dropProposal = coordinator.proposal;
    NSArray *items = coordinator.items;
    //id<UIDropSession> session = coordinator.session;
    
    id<UITableViewDropItem> item;
    if (items) {
        item = [items firstObject];
        NSLog(@"item:%@",item);
        sourceIndexPath = item.sourceIndexPath;
    }
    if (sourceIndexPath) {
        ImageDataModels *imageData = [_arrayImages objectAtIndex:sourceIndexPath.row];
        if (UIDropOperationCopy == dropProposal.operation) {
            //拷贝
            [tableView performBatchUpdates:^{
                [_arrayImages insertObject:imageData atIndex:destinationIndexPath.row];
                [_tableview insertRowsAtIndexPaths:@[destinationIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            } completion:nil];
        }else if (UIDropOperationMove == dropProposal.operation) {
            //移动
            [tableView performBatchUpdates:^{
                [_arrayImages removeObjectAtIndex:sourceIndexPath.row];
                [_arrayImages insertObject:imageData atIndex:destinationIndexPath.row];
                [_tableview deleteRowsAtIndexPaths:@[sourceIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                [_tableview insertRowsAtIndexPaths:@[destinationIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            } completion:nil];
        }
    }
}

//@optional

// If NO is returned no further delegate methods will be called for this drop session.
// If not implemented, a default value of YES is assumed.
/**
 方法一
 一个支持拖放的视图，判断是否允许当前拖拽到该视图上的类型拖放至此
 */
- (BOOL)tableView:(UITableView *)tableView canHandleDropSession:(id<UIDropSession>)session{
    if (SwitchShowDropLog) {
        NSLog(@"tableView:%@ canHandleDropSession:%@",tableView,session);
    }
    return YES;
}


// Allows customization of the preview used when dropping to a newly inserted row.
// If not implemented or if nil is returned, the entire cell will be used for the preview.
/**
 第二个方法
 支持拖拽的控件在拖拽是展现的预览视图的参数
 返回 nil 则预览整行
 */
- (nullable UIDragPreviewParameters *)tableView:(UITableView *)tableView dropPreviewParametersForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
    CGRect rect = CGRectMake(20, 0, tableView.bounds.size.width - 40, 150);
    parameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:30];
    return parameters;
    return nil;
}

// Called when the drop session begins tracking in the table view's coordinate space.
/**
 当拖拽内容到支持拖放控件区域内时，如果willBecomeEditableForDrop方法返回允许，则回调该方法
 */
- (void)tableView:(UITableView *)tableView dropSessionDidEnter:(id<UIDropSession>)session{
    
}

// Called frequently while the drop session being tracked inside the table view's coordinate space.
// When the drop is at the end of a section, the destination index path passed will be for a row that does not yet exist (equal
// to the number of rows in that section), where an inserted row would append to the end of the section.
// The destination index path may be nil in some circumstances (e.g. when dragging over empty space where there are no cells).
// Note that in some cases your proposal may not be allowed and the system will enforce a different proposal.
// You may perform your own hit testing via -[session locationInView:]
/**
    当拖拽手势，拖动控件在支持拖放的区域上时，会频繁调用
 */
- (UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath{
    if (SwitchShowDropLog) {
        NSLog(@"tableView:%@ dropSessionDidUpdate:%@ withDestinationIndexPath:%@",tableView,session,destinationIndexPath);
    }
    UITableViewDropProposal *dropProposal;
    if (session.localDragSession) {
        //来自本应用内，所以可以是移动操作
        dropProposal = [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UITableViewDropIntentInsertAtDestinationIndexPath];
    } else {
        dropProposal = [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UITableViewDropIntentInsertAtDestinationIndexPath];
    }
    return dropProposal;
}

// Called when the drop session is no longer being tracked inside the table view's coordinate space.
/**
 
 当拖拽内容离开支持拖放控件区域内时，并未拖放至此时，则回调该方法
 */
- (void)tableView:(UITableView *)tableView dropSessionDidExit:(id<UIDropSession>)session{
    
}

// Called when the drop session completed, regardless of outcome. Useful for performing any cleanup.
/**

拖放结束，拖放成功，或者取消了拖放，最后都会回调该方法
*/
- (void)tableView:(UITableView *)tableView dropSessionDidEnd:(id<UIDropSession>)session{
    
}

#pragma mark - UITableViewDropDelegate end



#pragma mark - Public
 
#pragma mark - Private
 
#pragma mark - Getter
 
#pragma mark - Setter

#pragma mark - Others

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    _tableview.delegate = nil;
    _tableview.dragDelegate = nil;
    _tableview.dropDelegate = nil;
}

@end
