//
//  LYMimiViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
//秘密 控制器

#import "LYMimiViewController.h"
#import "LYDuanziTableViewCell.h"
#import "AFNetworking.h"
#import "DZDataModel.h"
#import "UIScrollView+QCLRefresh.h"
#define UcmimiUrl @"http://napi.uc.cn/3/classes/topic/lists/%E7%A7%98%E5%AF%86?"

@interface LYMimiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) UITableView *tableView;
/**数据*/
@property (nonatomic, copy) NSMutableArray *ArrMuLYDataModel;

@property (nonatomic ,strong) QCLHeaderView *headerView;

@property (nonatomic ,strong) QCLFooterView *footerView;

@property(nonatomic,strong) NSString *StrMAx_pos;

@property(nonatomic,copy) NSArray *ArrMAx_pos;

@property(nonatomic,assign) NSInteger Intindex;


@end

@implementation LYMimiViewController
-(NSMutableArray *)ArrMuLYDataModel
{
    if (!_ArrMuLYDataModel)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"MMData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *arrMuMain = [NSMutableArray arrayWithCapacity:arrMain.count];
        for (NSDictionary *dict in arrMain)
        {
            DZDataModel *model = [DZDataModel DatamodelWithDictionary:dict];
            [arrMuMain addObject:model];
        }
        
        _ArrMuLYDataModel = [arrMuMain copy];
    }
    return _ArrMuLYDataModel;
}
-(NSArray *)ArrMAx_pos
{
    if (!_ArrMAx_pos)
    {
        _ArrMAx_pos = @[@"9999999999999",@"1454254966037",@"1440919977246",@"1442195300810",@"1465240874874",@"1450151506824",@"1463577437478",@"1454335326078",@"1462011971796",@"1446805086389",@"1458255390984",@"1461684716533",@"1447441013594",@"1468868408864",@"1443404017183",@"1467677247476",@"1457269106688",@"1446870153324",@"1449945574516",@"1461013720320",@"1464679858991",@"1440441146181",@"1461206398104",@"1462224128679",@"1456140441047",@"1458082870991",@"1439434363463"];
    }
    return _ArrMAx_pos;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.title= @"秘密";
    self.Intindex = 0;
    self.StrMAx_pos = self.ArrMAx_pos[0];
    
    self.headerView = [self.tableView addHeaderRefresh:^(UIView *view) {
        
        //NSLog(@"开始刷新");
    }];
    UITableView *DuanziTableview = [UITableView new];
    DuanziTableview.frame = self.view.bounds;
    DuanziTableview.estimatedRowHeight = 40;
    [self.view addSubview:DuanziTableview];
    DuanziTableview.dataSource = self;
    DuanziTableview.delegate = self;
    //DuanziTableview.contentInset = UIEdgeInsetsMake(0, 0, -84, 0);
    self.tableView = DuanziTableview;
    DuanziTableview.showsVerticalScrollIndicator = NO;
   // [self requestInformation];
}
#pragma  mark 请求数据
-(void)requestInformation
{
    NSDictionary *dict = @{@"_app_id":@"hottopic",
                           @"_size":@"10",
                           @"_fetch":@"1",
                           @"_fetch_incrs":@"1",
                           @"_max_pos":self.StrMAx_pos
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:UcmimiUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arrData = responseObject[@"data"];
          NSMutableArray *muarr = [NSMutableArray array];
         for (NSDictionary *dict in arrData)
         {
             DZDataModel *model = [DZDataModel DatamodelWithDictionary:dict];
             [muarr addObject:model];
             //  NSLog(@"%s\n%@",__func__, model.description);
         }
         /**刷新UI*/
           __weak typeof(self) weakSelf = self;
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            weakSelf.ArrMuLYDataModel = muarr;
                            [weakSelf.tableView reloadData];
                        });

        
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         // NSLog(@"%s\n%@",__func__,error);
         NSString *strBar = @"网络连接错误";
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:strBar preferredStyle:  UIAlertControllerStyleAlert];
         
         [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                           {
                               //点击按钮的响应事件；
                           }]];
         
         /**弹出提示框*/
         [self presentViewController:alert animated:true completion:nil];
     }];

}
//当停止拖动,将要减速的时候,判断是否需要加载更多
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat tablecontenoffsetY = -65.5;
    if (self.tableView.contentOffset.y < tablecontenoffsetY)
    {
         self.Intindex += 1;
        /**打印此方法*/
       // NSLog(@"%s\n%@",__func__,scrollView);
        if (self.Intindex > self.ArrMAx_pos.count-1)
        {
            
        }
        else
        {
            self.StrMAx_pos = self.ArrMAx_pos[self.Intindex];
            [self requestInformation];
        }
        
    }
    else
    {
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ArrMuLYDataModel.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //LYDuanziTableViewCell *cell = [LYDuanziTableViewCell LYDuanziTableViewCellWithTableview:tableView];
    LYDuanziTableViewCell  *viewcell = [LYDuanziTableViewCell LYDuanziTableViewCellWithTableview:tableView];
    [viewcell setDzdataModel:self.ArrMuLYDataModel[indexPath.row]];
    return viewcell;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%s",__func__);
}
-(void)dealloc
{
   // NSLog(@"%s",__func__);
}

@end
