//
//  LYMengchongjizhongying.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import <AFNetworking.h>
#import "LYMengchongjizhongying.h"
#import "LYMCJZYTableViewCell.h"

#define UCMCJZYURL @"http://napi.uc.cn/3/classes/topic/lists/%E8%90%8C%E5%AE%A0?"
@interface LYMengchongjizhongying ()<UITableViewDataSource,UITableViewDelegate>
/**存放数据的数组*/
@property(nonatomic,copy) NSMutableArray *ArrMuLYDataModel;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSString *StrMAx_pos;

@property(nonatomic,copy) NSArray *ArrMAx_pos;

@property(nonatomic,assign) NSInteger Intindex;
@end

@implementation LYMengchongjizhongying
-(NSMutableArray *)ArrMuLYDataModel
{
    if (!_ArrMuLYDataModel)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"MCJZJData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *arrMuMain = [NSMutableArray arrayWithCapacity:arrMain.count];
        for (NSDictionary *dict in arrMain)
        {
            SHFDataModel *model = [SHFDataModel SHFDataModelWithDictionary:dict];
            [arrMuMain addObject:model];
        }
        
        _ArrMuLYDataModel = [arrMuMain copy];    }
    return _ArrMuLYDataModel;
}

-(NSArray *)ArrMAx_pos
{
    if (!_ArrMAx_pos)
    {
        _ArrMAx_pos = @[@"9999999999999",@"1443631304523",@"1463044303562",@"1447157770633",@"1437389989282",@"1468396544971",@"1455536193680",@"1459640183341",@"1442857408731",@"1456369640207",@"1467241372471",@"1435401747918",@"1448996245538",@"1445745844503",@"1466510623281",@"1464064833864",@"1448309574556",@"1456533938510",@"1453667749586",@"1455538968516",@"1437783669056",@"1437901759055",@"1464062925548",@"1447909274777",@"1467964871103",@"1435757632644",@"1450145284393",@"1439368088660",@"1437563659703",@"1437925793764",@"1444499961054",@"1462541890216",@"1440000115450",@"1464066206727",@"1453530725795",@"1438544047544",@"1448217811520",@"1468323069434",@"1466701839454",@"1438024679251",@"1442560114252",@"1461394166856",@"1470169171193",@"1447247593957"];
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
    self.title =  @"萌宠联盟";
    self.Intindex = 0;
    self.StrMAx_pos = self.ArrMAx_pos[0];
    self.view.userInteractionEnabled = YES;
    UITableView *tableView = [UITableView new];
    tableView.frame = self.view.bounds;
    tableView.estimatedRowHeight= 100;
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    //tableView.contentInset = UIEdgeInsetsMake(0, 0, -84, 0);
    tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    //[self requestInformation];
}
#pragma  mark 请求数据
-(void)requestInformation
{
    NSDictionary *param = @{@"_app_id":@"hottopic",
                            @"_size":@"10",
                            @"_fetch":@"1",
                            @"_max_pos":self.StrMAx_pos
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:UCMCJZYURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arr  = responseObject[@"data"];
         NSMutableArray *muarrdata = [NSMutableArray array];
         for (NSDictionary *dict in arr)
         {
             SHFDataModel *modeldata =[SHFDataModel SHFDataModelWithDictionary:dict];
             [muarrdata addObject:modeldata];
             
         }
         __weak typeof(self) weakSelf = self;
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            _ArrMuLYDataModel = [muarrdata copy];
                            
                            [weakSelf.tableView reloadData];
                        });
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         // //NSlog(@"%s\n%@",__func__,error);
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
        //NSLog(@"%s\n%@",__func__,scrollView);
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


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ArrMuLYDataModel.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    SHFDataModel *model = self.ArrMuLYDataModel[indexPath.row];
    LYMCJZYTableViewCell *cell =[LYMCJZYTableViewCell LYMCJZYTableViewCellWithTableView:tableView];
    //覆盖数据
    cell.shfDataModel = model;
    return cell;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}
-(void)dealloc
{
    //NSLog(@"%s",__func__);
}
@end
