//
//  TableViewDragAndDropViewController.m
//  iOS11Demo
//
//  Created by 隋文涛 on 2017/11/13.
//Copyright © 2017年 wintel. All rights reserved.
//

#import "TableViewDragAndDropViewController.h"

#import "TableViewDragAndDropCell.h"

#import "ImageDataModels.h"

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

#pragma mark - UITableViewDelegate end

#pragma mark - UITableViewDragDelegate start

/**
 第一个方法
 支持拖拽的控件，可拖拽的UIDragItem
 返回 nil，不允许拖拽
 */
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"tableView:%@ itemsForBeginningDragSession:%@ atIndexPath:%@",tableView,session,indexPath);
    
    ImageDataModels *imageData = [_arrayImages objectAtIndex:indexPath.row];
    if (imageData) {
        NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:imageData];
        
        UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
        
        return @[item];
    }
    return nil;
}

//@optional

// Allows customization of the preview used for the row when it is lifted or if the drag cancels.
// If not implemented or if nil is returned, the entire cell will be used for the preview.
- (nullable UIDragPreviewParameters *)tableView:(UITableView *)tableView dragPreviewParametersForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
    
    CGRect rect = CGRectMake(0, 0, tableView.bounds.size.width, tableView.rowHeight);
    parameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15];
    return parameters;
}

// Called after the lift animation has completed to signal the start of a drag session.
// This call will always be balanced with a corresponding call to -tableView:dragSessionDidEnd:
- (void)tableView:(UITableView *)tableView dragSessionWillBegin:(id<UIDragSession>)session{
    
}

// Called to signal the end of the drag session.
- (void)tableView:(UITableView *)tableView dragSessionDidEnd:(id<UIDragSession>)session{
    
}

// Controls whether move operations are allowed for the drag session.
// If not implemented, defaults to YES.
- (BOOL)tableView:(UITableView *)tableView dragSessionAllowsMoveOperation:(id<UIDragSession>)session;{
    return YES;
}
// Controls whether the drag session is restricted to the source application.
// If not implemented, defaults to NO.
- (BOOL)tableView:(UITableView *)tableView dragSessionIsRestrictedToDraggingApplication:(id<UIDragSession>)session{
    return YES;
}

/**
 向当前拖拽事件中追加UIDragItem
 */
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point{
    
    ImageDataModels *imageData = [_arrayImages objectAtIndex:indexPath.row];
    if (imageData) {
        NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:imageData];
        
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
- (void)tableView:(UITableView *)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator{
    
}

//@optional

// If NO is returned no further delegate methods will be called for this drop session.
// If not implemented, a default value of YES is assumed.
- (BOOL)tableView:(UITableView *)tableView canHandleDropSession:(id<UIDropSession>)session{
    
    return YES;
}

// Called when the drop session begins tracking in the table view's coordinate space.
- (void)tableView:(UITableView *)tableView dropSessionDidEnter:(id<UIDropSession>)session{
    
}

// Called frequently while the drop session being tracked inside the table view's coordinate space.
// When the drop is at the end of a section, the destination index path passed will be for a row that does not yet exist (equal
// to the number of rows in that section), where an inserted row would append to the end of the section.
// The destination index path may be nil in some circumstances (e.g. when dragging over empty space where there are no cells).
// Note that in some cases your proposal may not be allowed and the system will enforce a different proposal.
// You may perform your own hit testing via -[session locationInView:]
- (UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath{
    if (session.localDragSession) {
        //来自本应用内，所以可以是移动操作
    }
    return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy];
}

// Called when the drop session is no longer being tracked inside the table view's coordinate space.
- (void)tableView:(UITableView *)tableView dropSessionDidExit:(id<UIDropSession>)session{
    
}

// Called when the drop session completed, regardless of outcome. Useful for performing any cleanup.
- (void)tableView:(UITableView *)tableView dropSessionDidEnd:(id<UIDropSession>)session{
    
}

// Allows customization of the preview used when dropping to a newly inserted row.
// If not implemented or if nil is returned, the entire cell will be used for the preview.
- (nullable UIDragPreviewParameters *)tableView:(UITableView *)tableView dropPreviewParametersForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
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
