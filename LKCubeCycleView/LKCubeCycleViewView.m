//
//  LKCubeCycleViewView.m
//  LKCubeCycleView
//
//  Created by 刘康蕤 on 2017/8/4.
//  Copyright © 2017年 lkr. All rights reserved.
//

#import "LKCubeCycleViewView.h"

#import <UIImageView+WebCache.h>

// 滚动时间
#define INTERVALTIME 3.0

// m34距离
#define M34 1000

@interface LKCubeCycleViewView()

// 容器的宽与高
@property (nonatomic, assign) CGFloat sWidth;
@property (nonatomic, assign) CGFloat sHeight;

// 临时数组
@property (nonatomic, strong) NSMutableArray * tempArray;

// imageView的array
@property (nonatomic, strong) NSMutableArray * imageViewArray;

// 计时器 3秒旋转一次
@property (nonatomic, strong) NSTimer * timer;

// 旋转过程的计数器
@property (nonatomic, strong) NSTimer * rotateTimer;

//旋转的角度
@property (nonatomic, assign) CGFloat currentAngle;

//总共旋转的次数
@property (nonatomic, assign) NSInteger totalRotateCount;

@end

@implementation LKCubeCycleViewView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _sWidth = frame.size.width;
        _sHeight = frame.size.height;
        _currentAngle = 0;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndImageArray:(NSArray *)imageArray {

    if (self = [super initWithFrame:frame]) {
        
        _sWidth = frame.size.width;
        _sHeight = frame.size.height;
        _imageArray = imageArray;
        _currentAngle = 0;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray {

    _imageArray = imageArray;
}

-(void)dealloc {

    NSLog(@"%s",__func__);
}

- (void)destory {

    [_timer invalidate];
    _timer = nil;
}

#pragma mark - getter
- (NSMutableArray *)imageViewArray {

    // 创建四个滚动的imageView
    if (!_imageViewArray) {
        
        _imageViewArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 4; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _sWidth, _sHeight)];
            imageView.backgroundColor = [UIColor whiteColor];
            [_imageViewArray addObject:imageView];
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = 1000+i;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
        }
    }
    return _imageViewArray;
}

#pragma mark /** 循环前先创建控件 **/
- (void)loadCubeImage {

    if (_imageArray.count == 0) {
        
    }else if (_imageArray.count == 1) {
    
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _sWidth, _sHeight)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"headImage.jpeg"]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1000;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
    }else {
        
        if (_imageArray.count == 2) {
            _tempArray = [[NSMutableArray alloc] initWithArray:_imageArray];
            [_tempArray addObjectsFromArray:_imageArray];
        }else if(_imageArray.count == 3) {
            
            _tempArray = [[NSMutableArray alloc] initWithArray:_imageArray];
            [_tempArray addObject:[_imageArray objectAtIndex:0]];
            
        }else {
            _tempArray = [[NSMutableArray alloc] initWithArray:_imageArray];
        }
        
        // 添加面到父视图
        [self crateFaceAndAddFace];
        [self startTimer];
        
    }
}

// 点击事件  回调函数
- (void)tapAction:(UITapGestureRecognizer *)sender {

    
    self.CubeBlcok(sender.view.tag-1000);
    
}

#pragma  mark - 计时器
- (void)startTimer {

    [self rotateCubeView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:INTERVALTIME
                                              target:self
                                            selector:@selector(rotateCubeView)
                                            userInfo:nil
                                             repeats:YES];
    
    
}

- (void)rotateCubeView {

    // 旋转的时候 不可点击
    for (UIImageView *imageview in _imageViewArray) {
        imageview.userInteractionEnabled = NO;
    }
    
    _rotateTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rotate) userInfo:nil repeats:YES];
    
}

// 旋转
- (void)rotate {

    CATransform3D transform = self.layer.transform;
    transform.m34 = -1.0/M34;
    transform = CATransform3DRotate(transform, _currentAngle * M_PI/180, 1, 0, 0);
    self.layer.sublayerTransform = transform;
    _currentAngle += 1;
    
    if ((int)_currentAngle % 90 == 1) {
        
        // 结束旋转
        [_rotateTimer invalidate];
        _rotateTimer = nil;
        
        int index = _currentAngle/90;
        UIImageView *image = _imageViewArray[index];
        [self insertSubview:image atIndex:0];
        image.userInteractionEnabled = YES;
        
        [self resetCubeViewWithCurrentINdex:index];
        
    }
    if (_currentAngle == 360) {
        _currentAngle = 0;
    }
}

// 预备下一张出现的图片
- (void)resetCubeViewWithCurrentINdex:(NSInteger)index {

    _totalRotateCount++;
    
    if (_imageArray.count !=4 && _totalRotateCount >1) {
        
        // 下一张出现的照片在数组的哪个位置
        NSInteger row = _totalRotateCount % _imageArray.count;
        
        // 下一张出现的照片在哪个imageView上
        NSInteger imageIndex = _totalRotateCount % 4;
        
        UIImageView * imageView = _imageViewArray[imageIndex];
        imageView.tag = 1000 + row;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:row]]
                     placeholderImage:[UIImage imageNamed:@"headImage.jpeg"]];
        
    }
}

#pragma  mark - 添加视图
- (void)crateFaceAndAddFace {
    // 父视图 默认的3D转换  子视图会继承
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -0.1/M34;
    self.layer.sublayerTransform = perspective;
    
    // 添加第一个面，前面
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, _sHeight/2);
    [self addFace:0 withTransform:transform];
    
    // 添加第二个面，下面
    transform = CATransform3DMakeTranslation(0, _sHeight/2, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:1 withTransform:transform];
    
    // 添加第三个面，后面
    transform = CATransform3DMakeTranslation(0, 0, -_sHeight/2);
    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    // 添加第四个面，上面
    transform = CATransform3DMakeTranslation(0, -_sHeight/2, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];

}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    
    UIImageView *face = self.imageViewArray[index];
    [self addSubview:face];
    
    CGSize  containerSize = self.bounds.size;
    face.center = CGPointMake(containerSize.width/2, containerSize.height/2);
    
    face.layer.transform = transform;
    
    [face sd_setImageWithURL:[NSURL URLWithString:[_tempArray objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"headImage.jpeg"]];
}





















@end
