//
//  ViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/9/27.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "ViewController.h"

#import "PDFKitViewController.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITableViewDataSourcePrefetching
>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UITableViewDelegate start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [iOS11DemoAppActionsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSInteger row = indexPath.row;
    iOS11ActionsListModels *actionKey = [iOS11DemoAppActionsList objectAtIndex:row];
    NSString *pagekey     = actionKey.key;
    iOS11ActionsListModels *actionInfo = [iOS11DemoAppVCsList objectForKey:pagekey];
    if (actionInfo) {
        NSString *pageName      = actionInfo.name;
        NSInteger pageStatus    = actionKey.status;
        [cell.textLabel setText:pageName];
        if (pageStatus == iOS11DemoActionStatusNotStarted) {
            [cell.detailTextLabel setText:@"未开始"];
        }else if (pageStatus == iOS11DemoActionStatusDeveloped) {
            [cell.detailTextLabel setText:@"完成"];
        }else if (pageStatus == iOS11DemoActionStatusDeveloping) {
            [cell.detailTextLabel setText:@"开发中"];
        }
    }
    [cell.textLabel setTextColor:[UIColor colorNamed:@"ColorMyPink"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    iOS11ActionsListModels *actionKey = [iOS11DemoAppActionsList objectAtIndex:row];
    NSString *pagekey     = actionKey.key;
    iOS11ActionsListModels *actionInfo = [iOS11DemoAppVCsList objectForKey:pagekey];
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

- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    
}
#pragma mark - UITableViewDelegate end

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
