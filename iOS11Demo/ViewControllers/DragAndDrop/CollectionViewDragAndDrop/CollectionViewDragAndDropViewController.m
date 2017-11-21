//
//  CollectionViewDragAndDropViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "CollectionViewDragAndDropViewController.h"

#import "CollectionViewDragAndDropCell.h"

#import "ImageDataModels.h"

#define SwitchShowDragLog 0
#define SwitchShowDropLog 1

static NSString *cellIdentifier = @"CellIdentifier";

@interface CollectionViewDragAndDropViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDragDelegate,
UICollectionViewDropDelegate
>
{
    NSMutableArray *_arrayImages;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation CollectionViewDragAndDropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat itemwidth = [UIScreen mainScreen].bounds.size.width / 4;
    CGFloat itemHeight = [UIScreen mainScreen].bounds.size.height / 4;
    flowLayout.itemSize = CGSizeMake(itemwidth, itemHeight);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [_collectionView setCollectionViewLayout:flowLayout];
    [_collectionView registerClass:[CollectionViewDragAndDropCell class] forCellWithReuseIdentifier:cellIdentifier];
    _collectionView.reorderingCadence = UICollectionViewReorderingCadenceImmediate;
    
    {//添加拖拽代理
        _collectionView.dragDelegate = self;
        _collectionView.dropDelegate = self;
        // 该属性在 iPad 上默认是YES，在 iPhone 默认是 NO
        _collectionView.dragInteractionEnabled = YES;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewDragAndDropCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = ((ImageDataModels *)self.dataSource[indexPath.item]).image;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDragDelegate

/**
 第一个方法
 支持拖拽的控件，可拖拽的UIDragItem
 返回 nil，不允许拖拽
 */
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *info = @"";
    ImageDataModels *imageData = [_arrayImages objectAtIndex:indexPath.item];
    if (imageData) {
        info = [[imageData dictionaryRepresentation] JSONString];
        //- (instancetype)initWithObject:(id<NSItemProviderWriting>)object
        NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:info];
        
        UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
        
        return @[item];
    }
    return nil;
}

/**
 向当前拖拽事件中追加UIDragItem
 */
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {
    NSString *info = @"";
    ImageDataModels *imageData = [_arrayImages objectAtIndex:indexPath.item];
    if (imageData) {
        info = [[imageData dictionaryRepresentation] JSONString];
        //- (instancetype)initWithObject:(id<NSItemProviderWriting>)object
        NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:info];
        
        UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
        
        return @[item];
    }
    return nil;
}

/**
 第二个方法
 支持拖拽的控件在拖拽是展现的预览视图的参数
 返回 nil 则预览整行
 */
- (nullable UIDragPreviewParameters *)collectionView:(UICollectionView *)collectionView dragPreviewParametersForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
    
    CGFloat itemwidth = [UIScreen mainScreen].bounds.size.width / 4;
    CGFloat itemHeight = [UIScreen mainScreen].bounds.size.height / 4;
    
    CGRect rect = CGRectMake(0, 0, itemwidth, itemHeight);
    parameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10];
    parameters.backgroundColor = [UIColor clearColor];
    
    return parameters;
}

/**
 第三个方法
 拖动开始
 */
- (void)collectionView:(UICollectionView *)collectionView dragSessionWillBegin:(id<UIDragSession>)session {
    
}

/**
 第四个方法
 拖动结束
 */
- (void)collectionView:(UICollectionView *)collectionView dragSessionDidEnd:(id<UIDragSession>)session {
    
}



#pragma mark --- UICollectionViewDropDelegate Start ---

/**
 这里执行拖放成功后的操作，是插入，还是移动等等
 */
- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
    
    NSIndexPath *sourceIndexPath = nil;
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    UICollectionViewDropProposal *dropProposal = coordinator.proposal;
    
    NSArray *items = coordinator.items;
    id<UICollectionViewDropItem> dragItem;
    if (items) {
        dragItem = [items firstObject];
        NSLog(@"item:%@",dragItem);
        sourceIndexPath = dragItem.sourceIndexPath;
    }
    
    // 如果开始拖拽的 indexPath 和 要释放的目标 indexPath 一致，就不做处理
    if (sourceIndexPath.section == destinationIndexPath.section && sourceIndexPath.item == destinationIndexPath.item) {
        return;
    }

    ImageDataModels *imageData = (ImageDataModels *)self.dataSource[sourceIndexPath.item];
    
    if (imageData) {
        if (UIDropOperationCopy == dropProposal.operation) {
            //拷贝
            [collectionView performBatchUpdates:^{
                [self.dataSource  insertObject:imageData atIndex:destinationIndexPath.item];
                
                [collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
            } completion:nil];
        }else if (UIDropOperationMove == dropProposal.operation) {
            //移动
            [collectionView performBatchUpdates:^{
                
                [self.dataSource removeObjectAtIndex:sourceIndexPath.item];
                [self.dataSource insertObject:imageData atIndex:destinationIndexPath.item];
                
                [collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
            } completion:nil];
        }
    }
    [coordinator dropItem:dragItem.dragItem toItemAtIndexPath:destinationIndexPath];
}

/**
 当拖拽手势，拖动控件在支持拖放的区域上时，会频繁调用
 */
- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath {
    
    UICollectionViewDropProposal *dropProposal;
    if (session.localDragSession) {
        dropProposal = [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
    } else {
        dropProposal = [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
    }
    
    return dropProposal;
}

/*
 方法一
 一个支持拖放的视图，判断是否允许当前拖拽到该视图上的类型拖放至此
 */
- (BOOL)collectionView:(UICollectionView *)collectionView canHandleDropSession:(id<UIDropSession>)session {
    if (session.localDragSession == nil) {
        return NO;
    }
    return YES;
}

/**
 当拖拽内容到支持拖放控件区域内时，如果willBecomeEditableForDrop方法返回允许，则回调该方法
 */
- (void)collectionView:(UICollectionView *)collectionView dropSessionDidEnter:(id<UIDropSession>)session {
    
}

/**
 
 当拖拽内容离开支持拖放控件区域内时，并未拖放至此时，则回调该方法
 */
- (void)collectionView:(UICollectionView *)collectionView dropSessionDidExit:(id<UIDropSession>)session {
    
}

/**
 
 拖放结束，拖放成功，或者取消了拖放，最后都会回调该方法
 */
- (void)collectionView:(UICollectionView *)collectionView dropSessionDidEnd:(id<UIDropSession>)session {
    
}

/**
 第二个方法
 支持拖拽的控件在拖拽是展现的预览视图的参数
 返回 nil 则预览整行
 */
- (nullable UIDragPreviewParameters *)collectionView:(UICollectionView *)collectionView dropPreviewParametersForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - -- UICollectionViewDropDelegate End --


- (NSMutableArray *)dataSource{
    if (_arrayImages == nil) {
        _arrayImages = [[NSMutableArray alloc] init];
    }
    if ([_arrayImages count] == 0) {
        for (NSInteger i = 1; i < 13; i++){
            NSString *imageName = [NSString stringWithFormat:@"Aragaki_%ld.jpg",(long)i];
            
            ImageDataModels *imageData = [ImageDataModels modelObjectWithName:imageName source:ImageDataSourceTypeInApp];
            if (imageData) {
                [_arrayImages addObject:imageData];
            }
        }
    }
    return _arrayImages;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
