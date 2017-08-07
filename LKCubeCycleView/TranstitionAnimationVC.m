//
//  TranstitionAnimationVC.m
//  LKCubeCycleView
//
//  Created by 刘康蕤 on 2017/8/4.
//  Copyright © 2017年 lkr. All rights reserved.
//

#import "TranstitionAnimationVC.h"
#import <UIImageView+WebCache.h>

@interface TranstitionAnimationVC ()

@property (nonatomic, strong)NSArray * imageArray;

@property (nonatomic, strong)UIImageView * contentView;

@property (nonatomic , assign) NSInteger index;

@property (nonatomic, strong)NSTimer* timer;

@end

@implementation TranstitionAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"转场动画";
    
    _imageArray = [NSArray arrayWithObjects:
                   @"http://uploadfile.bizhizu.cn/2015/0313/20150313103706263.jpg.220.146.jpg",
                   @"http://img15.3lian.com/2015/a1/45/179.jpg",
                   @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1501841903627&di=06132f4fe133177d9d08218166773e20&imgtype=0&src=http%3A%2F%2Fimg2.ph.126.net%2FpeMOzkFjSG-Ph0IrpfgtQg%3D%3D%2F2223652316015677766.gif",
                   @"http://scimg.jb51.net/allimg/150915/14-1509151604030-L.jpg",@"http://wmimg.sc115.com/tx/new/pic/0729/1607cmgt5kyh3qo.jpg",
                   @"http://img31.photophoto.cn/20140409/0020033066794495_s.jpg",nil];
    
    _contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 160)];
    [self.view addSubview:_contentView];
    
    _contentView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    [_contentView addGestureRecognizer:tap];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self
                                            selector:@selector(transitionAction)
                                            userInfo:nil repeats:YES];
    [self changeView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_timer invalidate];
    _timer = nil;
}

-(void)dealloc {

    NSLog(@"%s",__func__);
    
}


#pragma mark - 图片点击方法
- (void)imageTapAction:(UITapGestureRecognizer *)sender {

    NSLog(@"index = %ld",_index - 1);
    
}


#pragma mark - 定时器方法
- (void)transitionAction {

    [self cubeAnimation];
    
}

/**
 *  立体翻滚效果
 */
-(void)cubeAnimation{
    [self changeView];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromTop; //设置动画的方向
    anima.duration = 1.0f;
    
    [_contentView.layer addAnimation:anima forKey:@"revealAnimation"];
}

/**
 *   设置view的值
 */
-(void)changeView {
    if (_index>_imageArray.count - 1) {
        _index = 0;
    }
    if (_index<0) {
        _index = _imageArray.count - 1;
    }
    
    [_contentView sd_setImageWithURL:[NSURL URLWithString:_imageArray[_index]] placeholderImage:[UIImage imageNamed:@"headImage.jpeg"]];
    
    _index++;
    
}

@end
