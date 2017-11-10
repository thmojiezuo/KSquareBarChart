//
//  KSquareBarChart.m
//  KSquareBarChart
//
//  Created by tenghu on 2017/11/10.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "KSquareBarChart.h"
#import "KSquareBar.h"

#define RGB(r,g,b)[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

@implementation KSquareBarChart

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _chartMargin = UIEdgeInsetsMake(0, 0, 0, 0);
        _showXAxis = YES;
        _showYAxis = YES;
        _yMaxNum = 1;
        _showNumber = YES;
        _BarbackGroudColor = [UIColor clearColor];
        _barColor = [UIColor redColor];
        _displayAnimated = YES;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


-(void)show{
    
    [self setNeedsDisplay];
    
    CGFloat groupWidth = 2;
    CGFloat barHeight = self.bounds.size.height - _chartMargin.top - _chartMargin.bottom;
    CGFloat barWidth = 25;
    
    NSInteger aa = _yValues.count;
    for (int i = 0; i < aa; i ++) {
        
        CGFloat bar_x = _chartMargin.left + i*(groupWidth+barWidth);
        KSquareBar *bar = [[KSquareBar alloc]initWithFrame:CGRectMake(bar_x, _chartMargin.top, barWidth, barHeight)];
        
        NSString *yValue = _yValues[i];
        bar.barProgress = yValue.floatValue/_yMaxNum;
        if ([yValue integerValue]< 6) {
            bar.barColor = RGB(174, 126, 80);
        }else if ([yValue integerValue] < 8){
            bar.barColor = RGB(147, 80, 33);
        }else{
            bar.barColor = RGB(134, 54, 9);
        }
       
        bar.backgroundColor = _BarbackGroudColor;
        
        if (_showNumber) {
            bar.barText = yValue;
        }
        
        bar.displayAnimated = _displayAnimated;

        [self addSubview:bar];
        
    }
    
    
    
}


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘 X 轴数据
    if (_xLabels) {
        
        CGFloat xLabelWidth = 27;
        CGFloat xLabelHeight = _chartMargin.bottom-5;
        UIFont  *font = [UIFont systemFontOfSize:11];
        [_xLabels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect rect = CGRectMake(_chartMargin.left + idx*xLabelWidth, self.bounds.size.height-_chartMargin.bottom+5, 25, xLabelHeight);
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.lineBreakMode = NSLineBreakByWordWrapping;
            style.alignment = NSTextAlignmentCenter;
            [obj drawWithRect:rect options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
            
        }];
    }
    
     // 绘 Y 轴数据
     if (_yLabels) {
     
         CGFloat yLabelWidth = _chartMargin.left-5;
         CGFloat yLabelHeight = 15;
         CGFloat yLabelSpace = (self.bounds.size.height-_chartMargin.bottom-_chartMargin.top)/(_yLabels.count-1);
         UIFont  *font = [UIFont systemFontOfSize:11];
         [_yLabels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
         CGRect rect = CGRectMake(0, self.bounds.size.height-_chartMargin.bottom-idx*yLabelSpace-yLabelHeight, yLabelWidth, yLabelHeight);
         
         NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
         style.alignment = NSTextAlignmentCenter;
         [obj drawWithRect:rect options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName: [UIColor whiteColor]} context:nil];
         }];
     }
    
    
    // 绘 x/y 坐标轴
    
    if (_showXAxis) {
        
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1 alpha:0.3].CGColor); //设置线的颜色为灰色
        //            CGFloat heighty = (200.0-_chartMargin.top)/(_data.yLabels.count+1);
        CGContextMoveToPoint(context, 0, (self.bounds.size.height-_chartMargin.bottom)); //设置线的起始点
        CGContextAddLineToPoint(context, self.bounds.size.width, (self.bounds.size.height-_chartMargin.bottom)); //设置线中间的一个点
        CGContextStrokePath(context);//直接把所有的点连起来
        
    }
    if (_showYAxis) {
        
        CGContextSetLineWidth(context, 2);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1].CGColor);
        CGFloat lengths[] = {0.2,5};
        CGContextSetLineDash(context, 0, lengths,2);
        CGContextMoveToPoint(context, _chartMargin.left-5, 0); //设置线的起始点
        CGContextAddLineToPoint(context, _chartMargin.left-5, self.bounds.size.height-_chartMargin.bottom); //设置线中间的一个点
        CGContextStrokePath(context);//直接把所有的点连起来
        
    }
    
}


@end
