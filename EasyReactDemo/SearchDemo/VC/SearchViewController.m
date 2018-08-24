//
//  SearchViewController.m
//  EasyReactDemo
//
//  Created by hbz on 2018/8/23.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "SearchViewController.h"
 
#import <EasyReact/EasyReact.h>
@interface SearchViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) EZRMutableNode * searchNode ;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchNode = [EZRMutableNode new];
    
    //此处用到了throttle节流  
    EZRNode<NSString *> *inputNode = [self.searchNode throttle:1 queue:dispatch_get_main_queue()];
    @ezr_weakify(self)
    [[inputNode listenedBy:self] withBlock:^(id  _Nullable next) {
      @ezr_strongify(self)
        self.contentLabel.text = next;
    }];
    // Do any additional setup after loading the view from its nib.
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchNode.value =searchText;
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
