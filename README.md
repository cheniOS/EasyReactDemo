# EasyReactDemo
对美团开源的EasyReact框架做了关于网络请求的demo,支持一个页面同时进行多个请求
![image](https://github.com/cheniOS/EasyReactDemo/blob/master/yulan.gif)

<p>通过节点对model进行监听，并通过requestUrl对监听得到的数据进行区分</p>
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

 
