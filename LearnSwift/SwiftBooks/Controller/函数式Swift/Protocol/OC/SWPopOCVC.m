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
#import "UIViewController+SWPresentationTools.h"
#import "SWBottomPopOCViewController.h"
#import "SWPresentationViewController.h"
#import "ZJInheritHeader.h"
#import "ZJProtocolHeader.h"

@interface SWPopOCVC ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tablView;

@property (nonatomic, strong) NSMutableArray <SWTestOCModel *> *listArray;

@property (nonatomic, strong) SWBottomPopOCViewController  *bottomPopVC;


@property (nonatomic, strong) SWPOPTableViewCell  * footView;

//@property (nonatomic, strong) NSMapTable  * mapTable;

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
    self.tablView.tableFooterView = self.footView;
    
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

- (void)p_testInheritInstance {
    ZJAnimalDuck *animalDuck = [ZJAnimalDuck new];
    [animalDuck quack];
    [animalDuck swim];
    
    
    ZJRubberDuck *rubberDuck = [ZJRubberDuck new];
    [rubberDuck quack];
    [rubberDuck swim];
    
}

- (void)p_testProtocalInstance {
    ZJNewAnimalDuck *animalDuck = [ZJNewAnimalDuck new];
//    ZJNewRubberDuck *rubberDuck = [ZJNewRubberDuck new];
    ZJAbstractDuckFactory *duckFactory = [ZJAbstractDuckFactory new];
    [duckFactory setDuckModel:animalDuck];
//  鸭子行为
    [duckFactory duckAction];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self bottomPresentedVC:self.bottomPopVC];
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



- (SWBottomPopOCViewController *)bottomPopVC{
    if(!_bottomPopVC){
        _bottomPopVC = [SWBottomPopOCViewController new];
    }
    return _bottomPopVC;
}



- (SWPOPTableViewCell *)footView{
    if(!_footView){
        __weak typeof(self) weakSelf     = self;
        SWTestOCModel *testModel = [[SWTestOCModel alloc] init];
        testModel.name = @"这是用来测试继承和面向协议相关的";
        testModel.IDNumber = @"1000";
        _footView = [[[NSBundle mainBundle] loadNibNamed:@"SWPOPTableViewCell"
                                                   owner:self
                                                 options:nil] lastObject];
        [_footView.contentView setBackgroundColor:[UIColor yellowColor]];
        _footView.ButtonEvent = ^(SWButtonEvent eventType) {
            //继承测试案例  (点赞)
            if (eventType == SWButtonEventFavor) {
                [weakSelf p_testInheritInstance];
            }
            //协议测试案例 (收藏事件)
            else {
                [weakSelf p_testProtocalInstance];
            }
        };
        [_footView setBackgroundColor:[UIColor whiteColor]];
        [_footView setOCWithModel:testModel];
    }
    return _footView;
}

//- (void)bottomPresentedVC:(SWBottomPopOCViewController *)presentedVC {
//    NSAssert([presentedVC isKindOfClass:[UIViewController class]], @"参数类型有误,需要UIViewController相关类型");
//    if (![presentedVC isKindOfClass:[UIViewController class]]) {
//        return;
//    }
//    presentedVC.modalPresentationStyle = UIModalPresentationCustom;
//    presentedVC.transitioningDelegate  = self;
//    [self presentViewController:presentedVC animated:true completion:nil];
//}



//- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//
//    CGFloat viewH = 300.f;
//    if ([presented isKindOfClass:[SWBottomPopOCViewController class]]) {
//        viewH = [(SWBottomPopOCViewController *)presented  viewHeight];
//    }
//
//    NSString *hashKey = [self keyWithPresentedVC:presented presentingVC:presenting];
//
//    SWPresentationViewController *presentationVC = [self.mapTable objectForKey:hashKey];
//    if (!presentationVC) {
//        presentationVC = [[SWPresentationViewController alloc]
//                          initWithPresentedViewController:presented
//                          presentingViewController:presenting
//                          viewHeight:viewH];
//        [self.mapTable setObject:presentationVC forKey:hashKey];
//    }
//    return presentationVC;
//}
//
//
//- (NSString *)keyWithPresentedVC:(UIViewController *)presented
//                    presentingVC:(UIViewController *)presenting {
//    NSString *hashKey = [NSString stringWithFormat:@"%lu_%lu",presented.hash,presenting.hash];
//    return  hashKey;
//}
//
//
//- (NSMapTable *)mapTable {
//    if (!_mapTable) {
//        _mapTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory
//                                              valueOptions:NSPointerFunctionsWeakMemory
//                                                  capacity:0];
//
//
//    }
//    return _mapTable;
//}



@end
