//
//  LYSehnhuifu.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYShenhuifuController.h"
#import "LYSHFPNGTableViewCell.h"
#import "LYSHFTEXTTableViewCell.h"
#import "SHFDataModel.h"
#import <AFNetworking/AFNetworking.h>
#define UCqiqushenhuifu @"http://napi.uc.cn/3/classes/topic/lists/%E7%A5%9E%E5%9B%9E%E5%A4%8D?"

@interface LYShenhuifuController ()<UITableViewDataSource,UITableViewDelegate>
/**存放数据的数组*/
@property(nonatomic,copy) NSMutableArray *ArrMuLYDataModel;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSString *StrMAx_pos;

@property(nonatomic,copy) NSArray *ArrMAx_pos;

@property(nonatomic,assign) NSInteger Intindex;


@end

@implementation LYShenhuifuController
-(NSMutableArray *)ArrMuLYDataModel
{
    if (!_ArrMuLYDataModel)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"SHFData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *arrMuMain = [NSMutableArray arrayWithCapacity:arrMain.count];
        for (NSDictionary *dict in arrMain)
        {
            SHFDataModel *model = [SHFDataModel SHFDataModelWithDictionary:dict];
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
        _ArrMAx_pos =@[@"9999999999999",@"1432835348607",@"1426409003308",@"1437616674790",@"1423326519302",@"1436804867712",@"1424643394053",@"1428752866983",@"1440429142230",@"1432501844928",@"1425487870830",@"1428673226235",@"1436583787374",@"1438068994004",@"1433594667380",@"1425308411569",@"1437227323822",@"1440091547209",@"1427889481558",@"1445170551446",@"1423584195298",@"1446171213861",@"1447708475604",@"1446549841631",@"1423945964996",@"1436623723265",@"1425494025231",@"1440393100497",@"1432017079563",@"1442154539854",@"1440204194939",@"1433640736684"];
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
   self.title = @"神回复";
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
    //tableView.contentInset = UIEdgeInsetsMake(0, 0, 84, 0);
    tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    //[self requestInformation];
}
#pragma  mark 请求数据
-(void)requestInformation
{
    NSDictionary *param = @{@"_app_id":@"hottopic",
                            @"_fetch":@"1",
                            @"_size":@"10",
                            @"_max_pos":self.StrMAx_pos
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:UCqiqushenhuifu parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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
        if (self.Intindex > self.ArrMAx_pos.count-1)
        {
    
        }else
        {
            self.StrMAx_pos = self.ArrMAx_pos[self.Intindex];
            [self requestInformation];

        }
    }
    else
    {
        //[self.tableView reloadData];
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
    SHFDataModel *Smodel = self.ArrMuLYDataModel[indexPath.row];
     LYSHFPNGTableViewCell *Pcell =[LYSHFPNGTableViewCell LYSHFTableViewCellWithTableView:tableView];
    if ([Smodel.StrTag isEqualToString:@"图文"])
    {
        //覆盖数据
        Pcell.shfDataModel = Smodel;
        return Pcell;
    }
    else
    {
        LYSHFTEXTTableViewCell *Tcell = [LYSHFTEXTTableViewCell LYSHFTEXTTableViewCellWithTableView:tableView];
        Tcell.shfDataModel = Smodel;
        return Tcell;
    }
    
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
