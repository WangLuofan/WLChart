//
//  WLPieChartDataItem.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/11.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLPieChartDataItem.h"

@implementation WLPieChartDataItem

+(instancetype)dataItemWithxAxisValue:(CGFloat)xAxisValue yAxisValue:(CGFloat)yAxisValue
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"Please use +dataItemWithValue:" userInfo:nil];
}

+(instancetype)dataItemWithValue:(CGFloat)value {
    WLPieChartDataItem* dataitem = [[WLPieChartDataItem alloc] init];
    if(dataitem != nil)
        dataitem.value = value;
    return dataitem;
}

@end
