//
//  HomeViewController.m
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeImageListCell.h"
#import <MJRefresh/MJRefresh.h>
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property(nonatomic ,strong)HomeViewModel * viewModel;
@end
static NSString * const imageListCell= @"imageListCell";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self  addNodelistened];
   
//    self.viewModel.parameters.value =
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.viewModel.page = 1;
     [self.listTableView registerNib:[UINib nibWithNibName:@"HomeImageListCell" bundle:nil] forCellReuseIdentifier:imageListCell];
    @ezr_weakify(self)
    self.listTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         @ezr_strongify(self)
        self.viewModel.page = 1;
        [self requestHotData];
         [self requestWeatherData];
//
    }];
    self.listTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        @ezr_strongify(self)
        self.viewModel.page ++;
        [self requestHotData];
       
    }];
    [self.listTableView.mj_header beginRefreshing];
   
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
   self.listTableView.estimatedRowHeight = 300;
}
#pragma mark 请求数据监听
-(void)addNodelistened{
     @ezr_weakify(self)
    [[self.viewModel.resultNode listenedBy:self]withBlockOnMainQueue:^(id  _Nullable next) {
        
         @ezr_strongify(self)
        RequestResultModel * resultModel = (RequestResultModel *)next;
        if ([meituUrl isEqualToString: resultModel.requestUrl] ) {
            if (self.viewModel.page == 1) {
                [self.viewModel.imageListArray removeAllObjects];
            }
            NSArray * data  = [ resultModel.result objectForKey:@"data"];
            for (NSDictionary * dic in data) {
                HomeImageListModel * model = [HomeImageListModel modelWithDictionary:dic];
                [self.viewModel.imageListArray  addObject:model];
            }
             [self.listTableView reloadData];
            [self.listTableView.mj_header endRefreshing];
            [self.listTableView.mj_footer endRefreshing];
        }
 
        if ([weatherUrl isEqualToString:resultModel.requestUrl]) {
            NSDictionary * dataDic  = [ resultModel.result objectForKey:@"data"];
            HomeWeatherModel * model = [HomeWeatherModel modelWithDictionary:dataDic];
            ForecastModel * forecastModel = model.forecast[0];
            
            self.weatherLabel.text  =  [NSString stringWithFormat:@"%@\n%@",forecastModel.date,model.ganmao];
        }

    }];
    [[self.viewModel.errorNode listenedBy:self]withBlockOnMainQueue:^(id  _Nullable next){
         @ezr_strongify(self)
         RequestResultModel * resultModel = (RequestResultModel *)next;
         if ([meituUrl isEqualToString: resultModel.requestUrl] ) {
          [self.listTableView.mj_header endRefreshing];
          [self.listTableView.mj_footer endRefreshing];
         }
    }];
}
//随机推荐热门段子请求
-(void)requestHotData{
    RequestModel * requestModel = [[RequestModel alloc]init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:@(1) forKey:@"type"];
    [params setObject:@(self.viewModel.page) forKey:@"page"];
    requestModel.params = params;
    requestModel.requestUrl = meituUrl;
    [self.viewModel.parameters setValue:requestModel];
    [self.viewModel.parameters clean];
}
-(void)requestWeatherData{
    RequestModel * requestModel = [[RequestModel alloc]init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:@"上海" forKey:@"city"];
    
    requestModel.params = params;
    requestModel.requestUrl = weatherUrl;
    [self.viewModel.parameters setValue:requestModel];
    [self.viewModel.parameters clean];
}
#pragma mark ------tableView delegate------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.imageListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeImageListCell * cell = [tableView dequeueReusableCellWithIdentifier:imageListCell];
    if (self.viewModel.imageListArray.count > 0) {
        HomeImageListModel * listModel = self.viewModel.imageListArray[indexPath.row];
        cell.model = listModel;
    }
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(HomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc]init];
    }
    return _viewModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
