//
//  ViewController.m
//  WLChartDemo
//
//  Created by 王落凡 on 2018/5/11.
//  Copyright © 2018年 王落凡. All rights reserved.
//
#import <WLChart/WLChart.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLScatterChart* scatterChart = [[WLScatterChart alloc] initWithFrame:CGRectMake(10.0f, 64.0f, 300.0f, 200.0f)];
    scatterChart.xAxisTitle = @"平均速度";
    scatterChart.yAxisTitle = @"每加仑行驶的英里数";

    WLScatterChartDataItem* dataItem1 = [WLScatterChartDataItem dataItemWithxAxisValue:25 yAxisValue:13];
    WLScatterChartDataItem* dataItem2 = [WLScatterChartDataItem dataItemWithxAxisValue:28 yAxisValue:12];
    WLScatterChartDataItem* dataItem3 = [WLScatterChartDataItem dataItemWithxAxisValue:34 yAxisValue:17];
    WLScatterChartDataItem* dataItem4 = [WLScatterChartDataItem dataItemWithxAxisValue:35 yAxisValue:18];
    WLScatterChartDataItem* dataItem5 = [WLScatterChartDataItem dataItemWithxAxisValue:43 yAxisValue:18];
    WLScatterChartDataItem* dataItem6 = [WLScatterChartDataItem dataItemWithxAxisValue:48 yAxisValue:21];
    WLScatterChartDataItem* dataItem7 = [WLScatterChartDataItem dataItemWithxAxisValue:55 yAxisValue:26];
    WLScatterChartDataItem* dataItem8 = [WLScatterChartDataItem dataItemWithxAxisValue:62 yAxisValue:30];
    WLScatterChartDataItem* dataItem9 = [WLScatterChartDataItem dataItemWithxAxisValue:65 yAxisValue:29];
    WLScatterChartDataItem* dataItem10 = [WLScatterChartDataItem dataItemWithxAxisValue:67 yAxisValue:28];

    scatterChart.dataItems = @[dataItem1, dataItem2, dataItem3, dataItem4, dataItem5, dataItem6, dataItem7, dataItem8, dataItem9, dataItem10];
    scatterChart.scatterTintColor = [UIColor redColor];
    [self.view addSubview:scatterChart];

    [scatterChart stroke:YES];
    
//    WLPieChart* pieChart = [[WLPieChart alloc] initWithFrame:CGRectMake(10.0f, 64.0f, 300.0f, 300.0f)];
//
//    WLPieChartDataItem* dataItem0 = [WLPieChartDataItem dataItemWithValue:11.0f];
//    dataItem0.tintColor = [UIColor redColor];
//
//    WLPieChartDataItem* dataItem1 = [WLPieChartDataItem dataItemWithValue:15.0f];
//    dataItem1.tintColor = [UIColor purpleColor];
//
//    WLPieChartDataItem* dataItem2 = [WLPieChartDataItem dataItemWithValue:9.0f];
//    dataItem2.tintColor = [UIColor greenColor];
//
//    WLPieChartDataItem* dataItem3 = [WLPieChartDataItem dataItemWithValue:14.0f];
//    dataItem3.tintColor = [UIColor orangeColor];
//
//    WLPieChartDataItem* dataItem4 = [WLPieChartDataItem dataItemWithValue:21.0f];
//    dataItem4.tintColor = [UIColor blueColor];
//
//    pieChart.dataItems = @[dataItem0, dataItem1, dataItem2, dataItem3, dataItem4];
//    [self.view addSubview:pieChart];
//    [pieChart stroke:YES];
    
    return ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
