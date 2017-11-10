//
//  KSquareBar.h
//  KSquareBarChart
//
//  Created by tenghu on 2017/11/10.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSquareBar : UIView

@property (nonatomic, strong)UIColor *backgroundColor;//背景色
@property (nonatomic, strong)UIColor *barColor;//柱的颜色

@property (nonatomic, assign)float barProgress;//柱子长度 0-1之间

@property (nonatomic, strong)NSString *barText;//数值
@property (nonatomic, strong)NSString *barTitle;//标题

@property (nonatomic, assign)BOOL displayAnimated;


@end
