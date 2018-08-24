//
//  ViewController.m
//  EasyReactDemo
//
//  Created by hbz on 2018/8/23.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "ViewController.h"
#import <EasyReact/EasyReact.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    EZRMutableNode * nodeXC= [EZRMutableNode value:@23];
//    [nodeXC clean];
//    [nodeXC setValue:@21 forKey:@"试试"];

  
    [nodeXC getValue:^(id  _Nullable value) {
        
    }];
    NSObject *lister = [NSObject new];
    [[nodeXC listenedBy:lister]withBlock:^(id  _Nullable next) {
        
    }];
    [[nodeXC listenedBy:lister]withContextBlock:^(id  _Nullable next, id  _Nullable context) {
        
    }];
    [nodeXC setValue:@43 context:@"订单"];
    nodeXC.value = @234;
    [[nodeXC listenedBy:self]withBlockOnMainQueue:^(id  _Nullable next) {
        
    }];
    EZRNode * nodeD = [EZRNode new];
    EZRTransform * transform  = [EZRTransform new];
    transform.from  = nodeXC;
    transform.to = nodeD;

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
