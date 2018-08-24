//
//  RequestTool.m
//  EasyReactDemo
//
//  Created by hbz on 2018/8/23.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "RequestTool.h"
#import <AFNetworking/AFNetworking.h>
@implementation RequestTool
 
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
 
-(void)postRequestDataWithUrl:(NSString *)url params:(NSMutableDictionary*)params returnedNode:(EZRMutableNode *)returnedNode {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString * rqUrl = [self requestCompleteUrl:url];
    [manager POST:rqUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        RequestResultModel *resultModel  = [[RequestResultModel alloc]init];
        resultModel.requestUrl = url;
        resultModel.result = responseObject;
        returnedNode.value = resultModel;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RequestResultModel *resultModel  = [[RequestResultModel alloc]init];
        resultModel.requestUrl = url;
        resultModel.result = error;
       
        returnedNode.value = resultModel;
    }];
}
-(void)getRequestDataWithUrl:(NSString *)url params:(NSMutableDictionary*)params returnedNode:(EZRMutableNode *)returnedNode {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     NSString * rqUrl = [self requestCompleteUrl:url];
    [manager GET:rqUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        RequestResultModel *resultModel  = [[RequestResultModel alloc]init];
        resultModel.requestUrl = url;
        resultModel.result = responseObject;
        returnedNode.value = resultModel;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RequestResultModel *resultModel  = [[RequestResultModel alloc]init];
        resultModel.requestUrl = url;
        resultModel.result = error;
        
        returnedNode.value = resultModel;
    }];
}
-(NSString *)requestCompleteUrl:(NSString *)requestUrl{
    return  [NSString stringWithFormat:@"%@%@",rootUrlHost,requestUrl];
}

@end
