//
//  SWPopOCVC.m
//  LearnSwift
//
//  Created by 张君君 on 2020/9/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import "SWPopOCVC.h"
#import "SWUseSwiftFileHeader.h"
#import "UIViewController+SWButtonFunctionIMP.h"
#import "ProtocolKit.h"

@interface SWPopOCVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tablView;

@property (nonatomic, strong) NSMutableArray <SWTestOCModel *> *listArray;


@end

@implementation SWPopOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OC面向协议编程";
    [self.listArray addObjectsFromArray:[self testOCModelArray]];
    [self.view addSubview:self.tablView];
    [self.tablView registerNib:[UINib nibWithNibName:@"SWPOPTableViewCell" bundle:nil]
        forCellReuseIdentifier:@"SWPOPTableViewCell"];
    [self.tablView reloadData];
    
    Forkingdog *dog = [Forkingdog new];
    [dog sayHello:@"李明"];
    NSLog(@"%@", dog.github);
}

- (void)handleButtonEvent:(SWButtonEvent)type indexPath:(NSIndexPath *)indexPath {
    SWTestOCModel *testModel = self.listArray[indexPath.row];
    if (type == SWButtonEventFavor) {
        [self doFavorWithItemID:testModel.IDNumber];
    }
    else if (type == SWButtonEventCollect) {
        [self doCollectWithItemID:testModel.IDNumber];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWPOPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWPOPTableViewCell"
                                                               forIndexPath:indexPath];
    __weak typeof(self) weakSelf     = self;
    cell.ButtonEvent = ^(SWButtonEvent type) {
        [weakSelf handleButtonEvent:type indexPath:indexPath];
    };
    [cell setOCWithModel:self.listArray[indexPath.row]];
    return cell;
}


- (UITableView *)tablView{
    if(!_tablView){
        CGFloat statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
        CGFloat navBarHeight    = 44.0;
        CGFloat maxWidth  = UIScreen.mainScreen.bounds.size.width;
        CGFloat maxHeight = UIScreen.mainScreen.bounds.size.height;
        _tablView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight + navBarHeight, maxWidth, maxHeight - statusBarHeight - navBarHeight)];
        _tablView.delegate = self;
        _tablView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tablView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        _tablView.estimatedRowHeight = 100.0;
        _tablView.rowHeight = UITableViewRowAnimationAutomatic;
    }
    return _tablView;
}


- (NSMutableArray *)listArray{
    if(!_listArray){
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}


@end
