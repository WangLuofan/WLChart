//
//  WLBasicAxisChart.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/24.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLBasicAxisChart.h"
#import "WLChartDataItem.h"

#import <CoreGraphics/CoreGraphics.h>

#define ROUND(x) ((int)x + (10 - ((int)x) % 10))

@interface WLBasicAxisChart()

@end

@implementation WLBasicAxisChart

-(void)initDefaultValues {
    [super initDefaultValues];
    
    _axisPointCount = 5;
    return ;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef theCtx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(theCtx);
    
    CGContextBeginPath(theCtx);
    
    CGContextMoveToPoint(theCtx, 25.0f + _yAxisMaxTextWidth, rect.size.height - 35.0f);
    CGContextAddLineToPoint(theCtx, rect.size.width - 25.0f + _yAxisMaxTextWidth, rect.size.height - 35.0f);
    CGContextMoveToPoint(theCtx, 25.0f + _yAxisMaxTextWidth, rect.size.height - 35.0f);
    CGContextAddLineToPoint(theCtx, 40.0f, 0.0f);
    
    CGContextStrokePath(theCtx);
    
    CGFloat yHeightDelta = (rect.size.height - _xAxisTitleTextSize.height * 2) / (_axisPointCount + 1);
    CGFloat lengths[] = {1.0f, 1.0f};
    
    CGContextSetLineDash(theCtx, 0, lengths, 2);
    for(int i = 1; i != _axisPointCount; ++i) {
        CGContextMoveToPoint(theCtx, 25.0f + _yAxisMaxTextWidth, rect.size.height - 35.0f - i * yHeightDelta);
        CGContextAddLineToPoint(theCtx, rect.size.width - 25.0f + _yAxisMaxTextWidth, rect.size.height - 35.0f - i * yHeightDelta);
    }
    CGContextStrokePath(theCtx);
    
    CGContextRestoreGState(theCtx);
    return ;
}

-(void)setXAxisTitle:(NSString*)xAxisTitle {
    _xAxisTitle = xAxisTitle;
    
    _xAxisTitleTextSize = [_xAxisTitle sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
    return ;
}

-(void)setYAxisTitle:(NSString*)yAxisTitle {
    _yAxisTitle = yAxisTitle;
    
    _yAxisTitleTextSize = [_yAxisTitle sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
    return ;
}

-(void)setDataItems:(NSArray *)dataItems {
    [super setDataItems:dataItems];
    
    for (WLChartDataItem* dataItem in dataItems) {
        _maxXAxisValue = MAX(_maxXAxisValue, dataItem.xAxisValue);
        _maxYAxisValue = MAX(_maxYAxisValue, dataItem.yAxisValue);
    }
    
    _xAxisDiff = ROUND(_maxXAxisValue) / _axisPointCount;
    _yAxisDiff = ROUND(_maxYAxisValue) / _axisPointCount;
    
    _xAxisDiff = ROUND(_xAxisDiff);
    _yAxisDiff = ROUND(_yAxisDiff);
    
    return ;
}

-(void)stroke:(BOOL)bAnimated {
    [super stroke:bAnimated];
    
    CATextLayer* yTitleLayer = [CATextLayer layer];
    yTitleLayer.affineTransform = CGAffineTransformMakeRotation(-M_PI_2);
    yTitleLayer.string = _yAxisTitle;
    yTitleLayer.frame = CGRectMake(0.0f, 0.0f, 15.0f, _yAxisTitleTextSize.width);
    yTitleLayer.anchorPoint = CGPointMake(0.5f, 0.0f);
    yTitleLayer.position = CGPointMake(0.0f, CGRectGetMidY(self.bounds));
    yTitleLayer.fontSize = 12.0f;
    yTitleLayer.contentsScale = [UIScreen mainScreen].scale;
    yTitleLayer.foregroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:yTitleLayer];
    
    CATextLayer* xTitleLayer = [CATextLayer layer];
    xTitleLayer.string = _xAxisTitle;
    xTitleLayer.frame = CGRectMake(0.0f, 0.0f, _xAxisTitleTextSize.width, 15.0f);
    xTitleLayer.anchorPoint = CGPointMake(0.5f, 1.0f);
    xTitleLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
    xTitleLayer.fontSize = 12.0f;
    xTitleLayer.contentsScale = [UIScreen mainScreen].scale;
    xTitleLayer.foregroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:xTitleLayer];
    
    CGFloat yHeightDelta = (self.bounds.size.height - _xAxisTitleTextSize.height * 2) / (_axisPointCount + 1);
    for(int i = 1 ; i != _axisPointCount; ++i) {
        NSString* yAxisValueString = [NSString stringWithFormat:@"%ld", i * _yAxisDiff];
        CGSize yAxisValueSize = [yAxisValueString sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
        _yAxisMaxTextWidth = MAX(_yAxisMaxTextWidth, yAxisValueSize.width);
        CATextLayer* yAxisLayer = [CATextLayer layer];
        yAxisLayer.string = yAxisValueString;
        yAxisLayer.frame = CGRectMake(0.0f, 0.0f, yAxisValueSize.width, 15.0f);
        yAxisLayer.anchorPoint = CGPointMake(0.0f, 0.5f);
        yAxisLayer.position = CGPointMake(_yAxisTitleTextSize.height + 5.0f, self.bounds.size.height - 35.0f - i * yHeightDelta);
        yAxisLayer.fontSize = 12.0f;
        yAxisLayer.contentsScale = [UIScreen mainScreen].scale;
        yAxisLayer.foregroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:yAxisLayer];
    }
    
    CGFloat xWidthDelta = (self.bounds.size.width - _yAxisTitleTextSize.height * 2) / _axisPointCount;
    for(int i = 0; i != _axisPointCount; ++i) {
        NSString* xAxisValueString = [NSString stringWithFormat:@"%ld", i * _xAxisDiff];
        CGSize xAxisValueSize = [xAxisValueString sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
        CATextLayer* xAxisLayer = [CATextLayer layer];
        xAxisLayer.string = xAxisValueString;
        xAxisLayer.frame = CGRectMake(0.0f, 0.0f, xAxisValueSize.width, 15.0f);
        xAxisLayer.anchorPoint = CGPointMake(0.5f, 1.0f);
        xAxisLayer.position = CGPointMake(_yAxisTitleTextSize.height + 5.0f + _yAxisMaxTextWidth + i * xWidthDelta, self.bounds.size.height - 20.0f);
        xAxisLayer.fontSize = 12.0f;
        xAxisLayer.contentsScale = [UIScreen mainScreen].scale;
        xAxisLayer.foregroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:xAxisLayer];
    }
    
    return ;
}

@end
