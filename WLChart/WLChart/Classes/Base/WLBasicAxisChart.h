//
//  WLBasicAxisChart.h
//  WLChart
//
//  Created by 王落凡 on 2018/5/24.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLBasicChart.h"

@interface WLBasicAxisChart : WLBasicChart

@property(nonatomic, copy) NSString* xAxisTitle;
@property(nonatomic, copy) NSString* yAxisTitle;

@property(nonatomic, assign, readonly) CGFloat maxXAxisValue;
@property(nonatomic, assign, readonly) CGFloat maxYAxisValue;

@property(nonatomic, assign, readonly) CGSize xAxisTitleTextSize;
@property(nonatomic, assign, readonly) CGSize yAxisTitleTextSize;

@property(nonatomic, assign, readonly) NSInteger xAxisDiff;
@property(nonatomic, assign, readonly) NSInteger yAxisDiff;

@property(nonatomic, assign, readonly) CGFloat yAxisMaxTextWidth;

@property(nonatomic, assign) NSInteger axisPointCount;

@end
