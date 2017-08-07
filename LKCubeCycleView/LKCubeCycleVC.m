//
//  LKCubeCycleVC.m
//  LKCubeCycleView
//
//  Created by 刘康蕤 on 2017/8/4.
//  Copyright © 2017年 lkr. All rights reserved.
//

#import "LKCubeCycleVC.h"
#import "LKCubeCycleViewView.h"
@interface LKCubeCycleVC ()

@property (nonatomic, strong) LKCubeCycleViewView * cubeView;

@end

@implementation LKCubeCycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //@"http://scimg.jb51.net/allimg/150915/14-1509151604030-L.jpg",
    //@"http://wmimg.sc115.com/tx/new/pic/0729/1607cmgt5kyh3qo.jpg",
    //@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1501841903627&di=06132f4fe133177d9d08218166773e20&imgtype=0&src=http%3A%2F%2Fimg2.ph.126.net%2FpeMOzkFjSG-Ph0IrpfgtQg%3D%3D%2F2223652316015677766.gif", @"http://scimg.jb51.net/allimg/150915/14-1509151604030-L.jpg",@"http://wmimg.sc115.com/tx/new/pic/0729/1607cmgt5kyh3qo.jpg",
    NSArray *imageArray = [NSArray arrayWithObjects:@"http://uploadfile.bizhizu.cn/2015/0313/20150313103706263.jpg.220.146.jpg",@"http://img15.3lian.com/2015/a1/45/179.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1501841903627&di=06132f4fe133177d9d08218166773e20&imgtype=0&src=http%3A%2F%2Fimg2.ph.126.net%2FpeMOzkFjSG-Ph0IrpfgtQg%3D%3D%2F2223652316015677766.gif", @"http://scimg.jb51.net/allimg/150915/14-1509151604030-L.jpg",@"http://wmimg.sc115.com/tx/new/pic/0729/1607cmgt5kyh3qo.jpg",@"http://img31.photophoto.cn/20140409/0020033066794495_s.jpg",nil];
    
    _cubeView = [[LKCubeCycleViewView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 160)
                                                                  AndImageArray:imageArray];
    [self.view addSubview:_cubeView];
    [_cubeView loadCubeImage];
    _cubeView.CubeBlcok = ^(NSInteger index) {
        NSLog(@"index = %ld",index);
    };
    
    /*
    LKCubeCycleViewView * cubeView2 = [[LKCubeCycleViewView alloc] initWithFrame:CGRectMake(0, 320, CGRectGetWidth(self.view.frame), 180)
                                                                   AndImageArray:imageArray];
    [self.view addSubview:cubeView2];
    [cubeView2 loadCubeImage];
    cubeView2.CubeBlcok = ^(NSInteger index) {
        NSLog(@"index = %ld",index);
    };
    */
}

-(void)dealloc {

    NSLog(@"%s",__func__);
    
    // 此方法是释放轮播界面  摧毁定时器 释放界面
    [_cubeView destory];
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
