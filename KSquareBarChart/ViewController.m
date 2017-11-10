//
//  ViewController.m
//  KSquareBarChart
//
//  Created by tenghu on 2017/11/10.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "ViewController.h"
#import "KSquareBarChart.h"

@interface ViewController ()

@property (nonatomic ,strong)KSquareBarChart *barChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray *result = @[@"10",@"9",@"6",@"8",@"10",@"5",@"10"];
    NSArray *xLabels = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑"];
    NSArray *yLabels = @[@"2",@"4",@"6",@"8",@"10"];
    
    _barChart = [[KSquareBarChart alloc]initWithFrame:CGRectMake(30, 80, result.count*27+20 , 190)];
    _barChart.xLabels = xLabels;
    _barChart.yLabels = yLabels;
    _barChart.yMaxNum = 10;
    _barChart.yValues = result;
    _barChart.displayAnimated = YES;
    _barChart.showNumber = YES;
    _barChart.chartMargin = UIEdgeInsetsMake(20, 30, 30, 0);// 上左下右
    
    [self.view addSubview:_barChart];
    [_barChart show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
