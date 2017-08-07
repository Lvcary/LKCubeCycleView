//
//  ViewController.m
//  LKCubeCycleView
//
//  Created by 刘康蕤 on 2017/8/4.
//  Copyright © 2017年 lkr. All rights reserved.
//

#import "ViewController.h"
#import "LKCubeCycleVC.h"
#import "TranstitionAnimationVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"无限轮播图";
    
    UIButton * cubeCycButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cubeCycButton.frame = CGRectMake(20, 80, 230, 40);
    [cubeCycButton setTitle:@"立方体轮放图-CATransform3D" forState:0];
    [cubeCycButton addTarget:self action:@selector(cubeCycButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cubeCycButton];
    
    UIButton * transitionCycButton = [UIButton buttonWithType:UIButtonTypeSystem];
    transitionCycButton.frame = CGRectMake(20, 150, 230, 40);
    [transitionCycButton setTitle:@"立方体轮放图2-CATransition" forState:0];
    [transitionCycButton addTarget:self action:@selector(transitionCycButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transitionCycButton];
    
    
    
}


- (void)cubeCycButton:(UIButton *)sender {

    LKCubeCycleVC * cubeCycleVC = [[LKCubeCycleVC alloc] init];
    [self.navigationController pushViewController:cubeCycleVC animated:YES];
}

- (void)transitionCycButtonAction:(UIButton *)sender {

    Class class = NSClassFromString(@"TranstitionAnimationVC");
    id obj = [[class alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
