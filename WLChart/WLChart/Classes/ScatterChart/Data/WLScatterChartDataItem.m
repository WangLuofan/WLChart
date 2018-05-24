//
//  WLScatterChartDataItem.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/23.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLScatterChartDataItem.h"

@implementation WLScatterChartDataItem

+(instancetype)dataItemWithValue:(CGFloat)value {
    @throw [NSException exceptionWithName:NSGenericException reason:@"Please use +dataItemWithAxisValue:yAxisValue:" userInfo:nil];
}

+(instancetype)dataItemWithxAxisValue:(CGFloat)xAxisValue yAxisValue:(CGFloat)yAxisValue
{
    WLScatterChartDataItem* dataItem = [[WLScatterChartDataItem alloc] init];
    if(dataItem != nil) {
        dataItem.xAxisValue = xAxisValue;
        dataItem.yAxisValue = yAxisValue;
    }
    
    return dataItem;
}

@end
