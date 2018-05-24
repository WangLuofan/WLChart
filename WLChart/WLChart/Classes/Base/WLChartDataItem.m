//
//  WLChartDataItem.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/11.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLChartDataItem.h"

@implementation WLChartDataItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultValues];
    }
    return self;
}

-(void)initDefaultValues {
    _tintColor = [UIColor blackColor];
    _value = 0.0f;
    _title = nil;
    _fontSize = 12.0f;
    return ;
}

+(instancetype)dataItemWithValue:(CGFloat)value {
    @throw [NSException exceptionWithName:NSGenericException reason:@"Method Unimplementation" userInfo:nil];
}

+(instancetype)dataItemWithxAxisValue:(CGFloat)xAxisValue yAxisValue:(CGFloat)yAxisValue
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"Method Unimplementation" userInfo:nil];
}

@end
