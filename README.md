# EasyReactDemo

# 对美团开源的EasyReact框架做了关于网络请求的demo,支持一个页面同时进行多个请求


![image](https://github.com/cheniOS/EasyReactDemo/blob/master/yulan.gif)

##实现过程
* 通过节点对model进行监听，并通过requestUrl对监听得到的数据进行区分
<pre><code>
@interface RequestResultModel : NSObject
@property(nonatomic ,copy)NSString * requestUrl;//请求的接口
@property(nonatomic ,copy)id  result;//请求的结果
@end
@interface RequestModel : NSObject
@property(nonatomic ,copy)NSString * requestUrl;//请求的接口
@property(nonatomic ,copy)NSMutableDictionary * params;//请求参数
@property(nonatomic ,assign)BOOL isPOST;  //默认GET请求
@end
</code></pre>

* 在viewModel的基类里对节点和网络请求进行绑定
<pre><code>
- (instancetype)init {
    if (self = [super init]) {
        _parameters = [EZRMutableNode new];
        EZRMutableNode *returnedNode = [EZRMutableNode new];
        EZRNode *  result= [_parameters flattenMap:^EZRNode * _Nullable(RequestModel * _Nullable requestModel) {
            if (requestModel.isPOST) {
                [self postRequestDataWithUrl:requestModel.requestUrl params:requestModel.params returnedNode:returnedNode];
            }else{
                [self getRequestDataWithUrl:requestModel.requestUrl params:requestModel.params returnedNode:returnedNode];
            }
            return returnedNode;
        }];
        EZRIFResult *ifResultNode = [result if:^BOOL(id  _Nullable next) {
            RequestResultModel * model = (RequestResultModel *)next;
            return [model.result isKindOfClass:NSDictionary.class];
        }];
        _resultNode = ifResultNode.thenNode;
        _errorNode  = ifResultNode.elseNode;
  
}
    return self;
}
</code></pre>
 
 * 在VC使用过程中对viewmodel的resultNode进行监听，通过监听到RequestResultModel的requestUrl去区分不同的请求【用这种方式可能比较迂回,有更好的方式欢迎指正】
 <pre><code>
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
            ForecastModel * forecastModel = model.forecast[0];
            ForecastModel * forecastModel = model.forecast[0];
            self.weatherLabel.text  =  [NSString stringWithFormat:@"%@\n%@",forecastModel.date,model.ganmao];
        }

    }];
</code></pre>
