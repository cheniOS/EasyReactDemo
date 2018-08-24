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
 
 
