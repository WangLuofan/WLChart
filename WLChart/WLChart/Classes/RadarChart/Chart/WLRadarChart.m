//
//  WLRadarChart.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/18.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLRadarChart.h"
#import "WLRadarChartDataItem.h"
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface WLRadarChart()

@property(nonatomic, assign, readonly) CGFloat maxValue;
@property(nonatomic, assign, readonly) NSInteger circleCount;
@property(nonatomic, strong) NSMutableArray* textLayerArrs;

@end

@implementation WLRadarChart

-(void)setDataItems:(NSArray*)dataItems; {
    [super setDataItems:dataItems];
    
    _maxValue = INT_MIN;
    for (WLChartDataItem* dataItem in dataItems)
        _maxValue = MAX(_maxValue, dataItem.value);
    _circleCount = (NSInteger)(ceil(_maxValue / _projDegree));
    return ;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat radian = M_PI * 2 / _projTitles.count;
    CGFloat radius = MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds) - 80) / 2;
    CGPoint middle = CGPointMake(MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)), MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)));
    
    for(int j = 0; j < _projTitles.count; ++j) {
        CGPoint position = CGPointMake(middle.x + radius * sin(radian * j), middle.y - radius * cos(radian * j));
        
        CATextLayer* textLayer = [_textLayerArrs objectAtIndex:j];
        if(position.x < middle.x) {
            if(position.y < middle.y) {
                textLayer.anchorPoint = CGPointMake(1.0f, 1.0f);
            }else if(position.y == middle.y) {
                textLayer.anchorPoint = CGPointMake(1.0f, 0.5f);
            }else {
                textLayer.anchorPoint = CGPointMake(1.0f, 0.0f);
            }
        }else if(position.x == middle.x) {
            if(position.y < middle.y) {
                textLayer.anchorPoint = CGPointMake(0.5f, 1.0f);
            }else {
                textLayer.anchorPoint = CGPointMake(0.5f, 1.0f);
            }
        }else {
            if(position.y < middle.y) {
                textLayer.anchorPoint = CGPointMake(0.0f, 1.0f);
            }else if(position.y == middle.y) {
                textLayer.anchorPoint = CGPointMake(0.0f, 0.5f);
            }else {
                textLayer.anchorPoint = CGPointMake(0.0f, 0.0f);
            }
        }
        
        textLayer.position = position;
    }
    
    return ;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat radian = M_PI * 2 / _projTitles.count;
    
    CGContextRef theCtx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(theCtx);
    
    [[UIColor blackColor] setStroke];
    
    CGPoint middle = CGPointMake(MIN(CGRectGetMidX(rect), CGRectGetMidY(rect)), MIN(CGRectGetMidX(rect), CGRectGetMidY(rect)));
    for(int i = 1; i <= _circleCount; ++i) {
        CGFloat radius = ((i * (MIN(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 80)) / 2) / _circleCount);
        
        for(int j = 0; j <= _projTitles.count; ++j) {
            CGPoint position = CGPointMake(middle.x + radius * sin(radian * j), middle.y - radius * cos(radian * j));
            if(j != 0)
                CGContextAddLineToPoint(theCtx, position.x, position.y);
            CGContextMoveToPoint(theCtx, middle.x, middle.y);
            CGContextAddLineToPoint(theCtx, position.x, position.y);
        }
    }
    
    CGContextClosePath(theCtx);
    CGContextStrokePath(theCtx);
    CGContextRestoreGState(theCtx);
    return ;
}

-(void)setProjTitles:(NSArray*)projTitles {
    _projTitles = projTitles;
    
    if(_textLayerArrs == nil)
        _textLayerArrs = [NSMutableArray array];
    [_textLayerArrs makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_textLayerArrs removeAllObjects];
    
    for (NSString* title in _projTitles) {
        CATextLayer* textLayer = [[CATextLayer alloc] init];
        textLayer.string = title;
        textLayer.fontSize = 12.0f;
        textLayer.foregroundColor = [[UIColor blackColor] CGColor];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:textLayer];
        
        CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:textLayer.fontSize]}];
        textLayer.frame = CGRectMake(0.0f, 0.0f, ceil(textSize.width), ceil(textSize.height));
        [_textLayerArrs addObject:textLayer];
    }
    
    return ;
}

-(void)stroke:(BOOL)bAnimated {
    [super stroke:bAnimated];
    
    NSAssert(_projTitles.count == self.dataItems.count, @"Item Counts Must be Equal Titles");
    NSInteger circleCount = (NSInteger)(ceil(_maxValue / _projDegree));
    CGFloat radius = (MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds) - 80) / 2);
    CGFloat maxCoorValue = circleCount * _projDegree;
    
    for (CALayer* subLayer in self.layer.sublayers) {
        if([subLayer isKindOfClass:[CAShapeLayer class]])
            [subLayer removeFromSuperlayer];
    }
    
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [[UIColor orangeColor] CGColor];
    shapeLayer.fillColor = [[[UIColor redColor] colorWithAlphaComponent:0.5f] CGColor];
    
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGFloat radian = M_PI * 2 / _projTitles.count;
    CGPoint middle = CGPointMake(MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)), MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)));
    
    for(int i = 0; i != self.dataItems.count; ++i) {
        WLRadarChartDataItem* dataItem = [self.dataItems objectAtIndex:i];
        
        CGFloat deltaRadius = radius * dataItem.value / maxCoorValue;
        CGPoint position = CGPointMake(middle.x + deltaRadius * sin(radian * i), middle.y - deltaRadius * cos(radian * i));
        if(i == 0)
            CGPathMoveToPoint(thePath, NULL, position.x, position.y);
        else {
            CGPathAddLineToPoint(thePath, NULL, position.x, position.y);
        }
    }
    
    if(bAnimated) {
        CABasicAnimation* circleAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        circleAnim.fromValue = @0;
        circleAnim.toValue = @1;
        circleAnim.removedOnCompletion = YES;
        circleAnim.duration = 3.0f;
        [shapeLayer addAnimation:circleAnim forKey:@"circleAnim"];
    }
    
    shapeLayer.path = thePath;
    [self.layer addSublayer:shapeLayer];
    
    [self setNeedsDisplay];
    return ;
}

@end
