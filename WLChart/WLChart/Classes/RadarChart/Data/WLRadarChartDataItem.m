//
//  WLRadarChartDataItem.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/18.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLRadarChartDataItem.h"

@implementation WLRadarChartDataItem

+(instancetype)dataItemWithxAxisValue:(CGFloat)xAxisValue yAxisValue:(CGFloat)yAxisValue
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"Please use +dataItemWithValue:" userInfo:nil];
}

+(instancetype)dataItemWithValue:(CGFloat)value {
    WLRadarChartDataItem* dataitem = [[WLRadarChartDataItem alloc] init];
    if(dataitem != nil)
        dataitem.value = value;
    return dataitem;
}

@end
