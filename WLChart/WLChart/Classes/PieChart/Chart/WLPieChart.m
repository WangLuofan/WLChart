//
//  WLPieChart.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/11.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLPieChart.h"
#import "WLPieChartDataItem.h"

#import <UIKit/UIKit.h>

@interface WLPieChart()

@end

@implementation WLPieChart

-(void)setDataItems:(NSArray *)dataItems {
    [super setDataItems:dataItems];
    
    CGFloat totalValue = 0.0f;
    for (WLPieChartDataItem* item in dataItems)
        totalValue += item.value;
    for (WLPieChartDataItem* item in dataItems)
        item.percent = item.value / totalValue;
    
    return ;
}

-(CATextLayer*)textLayerForIndex:(NSInteger)index andDataItem:(WLPieChartDataItem*)dataItem
{
    CATextLayer* textLayer = [CATextLayer layer];
    textLayer.fontSize = dataItem.fontSize;
    
    NSString* descText = [NSString stringWithFormat:@"%.1lf%%", dataItem.percent * 100];
    CGSize textSize = [descText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:textLayer.fontSize]} context:nil].size;
    
    textLayer.string = descText;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer.frame = CGRectMake(0.0f, 0.0f, textSize.width, textSize.height);
    
    return textLayer;
}

-(CAShapeLayer*)shapeLayerWithCenter:(CGPoint)Center Radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth strokeColor:(UIColor*)strokeColor strokeStart:(CGFloat)strokeStart strokeEnd:(CGFloat)strokeEnd
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.strokeColor = strokeColor.CGColor;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithArcCenter:Center radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeStart = strokeStart;
    shapeLayer.strokeEnd = strokeEnd;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    return shapeLayer;
}

-(void)stroke:(BOOL)bAnimated {
    [super stroke:bAnimated];

    CGFloat mininum = MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    CGFloat lineWidth = mininum / 2 - _innerCircleRadius;
    CGFloat radius = _innerCircleRadius + (mininum / 2 - _innerCircleRadius) / 2;
    CGPoint center = CGPointMake(mininum / 2, mininum / 2);
    
    CGFloat strokeStart = 0.0f, strokeEnd = 0.0f;
    for (int i = 0; i != self.dataItems.count; ++i) {
        WLPieChartDataItem* dataItem = [self.dataItems objectAtIndex:i];
        
        strokeEnd = dataItem.percent + strokeStart;
        
        CAShapeLayer* shapeLayer = [self shapeLayerWithCenter:center Radius:radius lineWidth:lineWidth strokeColor:dataItem.tintColor strokeStart:strokeStart strokeEnd:strokeEnd];
        [self.layer addSublayer:shapeLayer];
        
        CATextLayer* textLayer = [self textLayerForIndex:i andDataItem:dataItem];
        
        CGFloat xPos = mininum / 2 + radius * sin(M_PI * (strokeStart + strokeEnd));
        CGFloat yPos = mininum / 2 - radius * cos(M_PI * (strokeStart + strokeEnd));
        
        textLayer.frame = CGRectMake(xPos - textLayer.bounds.size.width / 2, yPos - textLayer.bounds.size.height / 2, textLayer.bounds.size.width, textLayer.bounds.size.height);
        [shapeLayer addSublayer:textLayer];
        
        strokeStart = strokeEnd;
    }
    
    [self makePieChartMaskUsingAnimation:bAnimated];
    return ;
}

-(void)makePieChartMaskUsingAnimation:(BOOL)animated {
    CGFloat mininum = MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    CGFloat lineWidth = mininum / 2 - _innerCircleRadius;
    CGFloat radius = _innerCircleRadius + (mininum / 2 - _innerCircleRadius) / 2;
    CGPoint center = CGPointMake(mininum / 2, mininum / 2);
    
    CAShapeLayer* maskLayer = [self shapeLayerWithCenter:center Radius:radius lineWidth:lineWidth strokeColor:[UIColor whiteColor] strokeStart:0.0f strokeEnd:1.0f];
    
    if(animated) {
        CABasicAnimation* circleAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        circleAnim.fromValue = @0;
        circleAnim.toValue = @1;
        circleAnim.removedOnCompletion = YES;
        circleAnim.duration = 3.0f;
        [maskLayer addAnimation:circleAnim forKey:@"circleAnim"];
    }
    
    self.layer.mask = maskLayer;
    return ;
}

#pragma mark - Touches
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint position = [[touches anyObject] locationInView:self];
    CGFloat mininum = MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    CGFloat lineWidth = mininum / 2;
    
    if(position.x < 0 || position.x > mininum)
        return ;
    if(position.y < 0 || position.y > mininum)
        return ;
    
    if(position.x < -_innerCircleRadius && position.x > _innerCircleRadius && position.y < -_innerCircleRadius && position.y > _innerCircleRadius)
        return ;
    
    CGPoint delta = CGPointMake(position.x - lineWidth, lineWidth - position.y);
    CGFloat radian = atan2(delta.x, delta.y);
    radian = (radian < 0 ? 2 * M_PI + radian : radian);
    
    __block CGFloat percent = 0.0f;
    [self.dataItems enumerateObjectsUsingBlock:^(WLPieChartDataItem* obj, NSUInteger idx, BOOL *stop){
        percent += obj.percent;
        
        CGFloat partical = percent * M_PI * 2;
        if(radian <= partical) {
            *stop = YES;
        }
    }];
    
    return ;
}

@end
