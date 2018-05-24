//
//  WLChart.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/11.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLBasicChart.h"
#import "WLChartDataItem.h"

@interface WLBasicChart()

@end

@implementation WLBasicChart

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultValues];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultValues];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initDefaultValues];
    }
    return self;
}

-(void)initDefaultValues {
    self.backgroundColor = [UIColor clearColor];
    
    _dataItems = nil;
    return ;
}

-(void)stroke:(BOOL)bAnimated {
    return ;
}

@end
