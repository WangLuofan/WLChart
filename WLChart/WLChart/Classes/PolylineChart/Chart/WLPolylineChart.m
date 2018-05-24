//
//  WLPolylineChart.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/23.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLPolylineChart.h"

@implementation WLPolylineChart

-(void)stroke:(BOOL)bAnimated {
    [super stroke:bAnimated];
    
    CGFloat xWidthDelta = (self.bounds.size.width - self.yAxisTitleTextSize.height * 2) / self.axisPointCount;
    CGFloat yHeightDelta = (self.bounds.size.height - self.xAxisTitleTextSize.height * 2) / (self.axisPointCount + 1);
    
    return ;
}

@end
