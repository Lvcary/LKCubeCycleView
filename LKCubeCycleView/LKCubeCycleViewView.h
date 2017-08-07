//
//  LKCubeCycleViewView.h
//  LKCubeCycleView
//
//  Created by 刘康蕤 on 2017/8/4.
//  Copyright © 2017年 lkr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKCubeCycleViewView : UIView

@property (nonatomic, strong) NSArray * imageArray;

@property (nonatomic, copy)void(^CubeBlcok)(NSInteger);

- (id)initWithFrame:(CGRect)frame AndImageArray:(NSArray *)imageArray;
- (void)loadCubeImage;

- (void)destory;

@end
