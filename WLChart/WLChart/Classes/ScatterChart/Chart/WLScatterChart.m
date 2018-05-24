//
//  WLScatterChart.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/23.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLScatterChart.h"
#import "WLScatterChartDataItem.h"

#define kScatterDotSize 4.0f

@interface WLScatterChart()

@end

@implementation WLScatterChart

-(void)stroke:(BOOL)bAnimated {
    [super stroke:bAnimated];
    
    CGFloat xWidthDelta = (self.bounds.size.width - self.yAxisTitleTextSize.height * 2) / self.axisPointCount;
    CGFloat yHeightDelta = (self.bounds.size.height - self.xAxisTitleTextSize.height * 2) / (self.axisPointCount + 1);

    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = _scatterTintColor.CGColor;
    
    CGMutablePathRef thePath = CGPathCreateMutable();
    for (WLScatterChartDataItem* dataItem in self.dataItems) {
        CGRect theRect = CGRectMake(25.0f + self.yAxisMaxTextWidth + (dataItem.xAxisValue * xWidthDelta / self.xAxisDiff) - kScatterDotSize / 2, (self.bounds.size.height - 35.0f - (dataItem.yAxisValue * yHeightDelta / self.yAxisDiff)) - kScatterDotSize / 2, kScatterDotSize, kScatterDotSize);
        UIBezierPath* beizerPath = [UIBezierPath bezierPathWithOvalInRect:theRect];
        CGPathAddPath(thePath, NULL, beizerPath.CGPath);
    }
    shapeLayer.path = thePath;
    [self.layer addSublayer:shapeLayer];
    
    if(bAnimated) {
        CABasicAnimation* circleAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        circleAnim.fromValue = @0;
        circleAnim.toValue = @1;
        circleAnim.removedOnCompletion = YES;
        circleAnim.duration = 3.0f;
        [shapeLayer addAnimation:circleAnim forKey:@"circleAnim"];
    }
    
    return ;
}

@end
