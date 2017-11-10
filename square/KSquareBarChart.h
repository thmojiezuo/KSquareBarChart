//
//  KSquareBarChart.h
//  KSquareBarChart
//
//  Created by tenghu on 2017/11/10.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSquareBarChart : UIView

@property (nonatomic, assign)UIEdgeInsets chartMargin;

@property (nonatomic, strong)NSArray<NSString *> *yValues; //数据源

@property (nonatomic ,assign)CGFloat yMaxNum;//y 轴最大值

@property (nonatomic, strong)UIColor *barColor;

@property (nonatomic, strong)UIColor *BarbackGroudColor;

@property (nonatomic, strong)NSArray<NSString *> *xLabels;

@property (nonatomic, strong)NSArray<NSString *> *yLabels;

@property (nonatomic, assign)BOOL showNumber;
@property (nonatomic, assign)BOOL showYAxis;
@property (nonatomic, assign)BOOL showXAxis;

@property (nonatomic, assign)BOOL displayAnimated;

- (void)show;//显示柱状图

@end
