//
//  LYGIFtuViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
// GIF图 控制器

#import <AFNetworking/AFNetworking.h>
#import "LYGIFtuViewController.h"
#import "LYGIFTableViewCell.h"
#import "SHFDataModel.h"

#define UCGIFURL @"http://napi.uc.cn/3/classes/topic/lists/GIF%E5%9B%BE?"

@interface LYGIFtuViewController ()<UITableViewDataSource,UITableViewDelegate>
/**存放数据的数组*/
@property(nonatomic,copy) NSMutableArray *ArrMuLYDataModel;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSString *StrMAx_pos;

@property(nonatomic,copy) NSArray *ArrMAx_pos;

@property(nonatomic,assign) NSInteger Intindex;


@end

@implementation LYGIFtuViewController
-(NSMutableArray *)ArrMuLYDataModel
{
    if (!_ArrMuLYDataModel)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"GIFData" ofType:@"plist"];
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
        _ArrMAx_pos = @[@"9999999999999",@"1461933901205",@"1435545622477",@"1468150039351",@"1469395819089",@"1431075969677",@"1444190123375",@"1430933430287",@"1469145098655",@"1439122600263",@"1454812463151",@"1465263956772",@"1452861336706",@"1468586049824",@"1458086379315",@"1456864910908",@"1439629218817",@"1463769529001",@"9999999999999",@"1440541928143",@"1461429274344",@"1467152711923",@"1468871965383",@"1448743681739",@"1464340530910",@"1448731743789",@"1444027048145",@"1420713449040",@"1441084594416",@"1428220287161",@"1462965383355",@"1418391705709",@"1445445015511",@"1446937714070",@"1442939978547",@"1429187118640",@"1462932221554",@"1437872864941",@"1470694631634",@"1437827216351",@"1449845557438"];
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
    self.title =  @"GIF图";
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
   // [self requestInformation];
}

#pragma  mark 请求数据
-(void)requestInformation
{
    NSDictionary *param = @{@"_app_id":@"hottopic",
                            @"_size":@"10",
                            @"_fetch":@"1",
                            @"_max_pos":self.StrMAx_pos
                            };
    //@"_select":@"like_start%2Cdislike_start%2Ctitle%2Ctag%2Cmedia_data%2Clist_info%2Ccontent%2Cavatar%2Cuser_name%2Cis_hot%2Chot_comment%2Ccomment_total%2Coriginal%2Ctv_duration"
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:UCGIFURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arrData = responseObject[@"data"];
         _ArrMuLYDataModel = [NSMutableArray arrayWithCapacity:arrData.count];
         NSMutableArray *muarr = [NSMutableArray arrayWithCapacity:arrData.count];
         for (NSDictionary *dict in arrData)
         {
             SHFDataModel *model = [SHFDataModel SHFDataModelWithDictionary:dict];
             [muarr addObject:model];
             //  //NSlog(@"%s\n%@",__func__, model.description);
         }
         __weak typeof(self) weakSelf = self;
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            _ArrMuLYDataModel = [muarr copy];
                            
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
    SHFDataModel *gifmodel = self.ArrMuLYDataModel[indexPath.row];
    LYGIFTableViewCell *cell =[LYGIFTableViewCell LYGIFTableViewCellWithTableView:tableView];
    //覆盖数据
    cell.shfDataModel = gifmodel;
    return cell;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc
{
    //NSLog(@"%s",__func__);
}


@end
