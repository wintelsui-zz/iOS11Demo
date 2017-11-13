//
//  DragAndDropViewController.m
//  iOS11Demo
//
//  Created by wintelsui on 2017/10/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "DragAndDropViewController.h"


static NSString * const actionSimple = @"SimpleViewDragAndDrop";
static NSString * const actionTable = @"TableViewDragAndDrop";
static NSString * const actionCollection = @"SimpleViewDragAndDrop";

@interface DragAndDropViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
{
    NSArray *_actions;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation DragAndDropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    
    _actions = @[actionSimple,actionTable];
}


#pragma mark - UITableViewDelegate start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_actions count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *key = [_actions objectAtIndex:row];
    [cell.textLabel setText:NSLocalizedString(key, nil)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = [_actions objectAtIndex:row];
    [self actionWithKey:key];
}

#pragma mark - UITableViewDelegate end

- (void)actionWithKey:(NSString *)key{
    if (key != nil && key.length > 0) {
        iOS11ActionsListModels *actionInfo = [iOS11DemoAppVCsList objectForKey:key];
        if (actionInfo) {
            NSString *className = actionInfo.className;
            NSString *pageName = actionInfo.name;
            
            UIStoryboard *storyboard = [self storyboardByMyName:actionInfo.storyboard];
            UIViewController *page;
            if (storyboard && actionInfo.storyboardid) {
                page = [storyboard instantiateViewControllerWithIdentifier:actionInfo.storyboardid];
            }
            if (!page) {
                page = [[NSClassFromString(className) alloc] init];
            }
            page.title = pageName;
            [self.navigationController pushViewController:page animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
