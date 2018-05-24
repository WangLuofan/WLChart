//
//  WLLegendView.m
//  WLChart
//
//  Created by 王落凡 on 2018/5/17.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import "WLBasicChart.h"
#import "WLLegendView.h"
#import "WLChartDataItem.h"

@interface WLLegendView()

@property(nonatomic, strong) UIStackView* stackView;
@property(nonatomic, assign) __block CGFloat maxTextSize;

@end

@implementation WLLegendView

-(instancetype)initWithDataItems:(NSArray *)dataItems fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    self = [super init];
    
    if(self) {
        _stackView = [[UIStackView alloc] init];
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = UIStackViewSpacingUseDefault;
        _stackView.alignment = UIStackViewAlignmentLeading;
        _stackView.axis = UILayoutConstraintAxisVertical;
        
        [self addSubview:_stackView];
        [self buildLegendWithDataItems:dataItems fontSize:fontSize textColor:textColor];
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _stackView.frame = CGRectMake(0.0f, 0.0f, _legendWidth, self.bounds.size.height);
    return ;
}

-(void)buildLegendWithDataItems:(NSArray*)dataItems fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor {
    for (WLChartDataItem* dataItem in dataItems) {
        CGFloat textWidth = [dataItem.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size.width;
        _maxTextSize = MAX(_maxTextSize, textWidth);
        
        UIBezierPath* bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0f, 0.0f, 10.0f, 10.0f)];
        CAShapeLayer* maskLayer = [CAShapeLayer layer];
        maskLayer.path = bezierPath.CGPath;
        
        UIStackView* legendView = [[UIStackView alloc] init];
        legendView.distribution = UIStackViewDistributionFill;
        legendView.spacing = 5.0f;
        legendView.axis = UILayoutConstraintAxisHorizontal;
        legendView.alignment = UIStackViewAlignmentCenter;
        
        UILabel* indicatorView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10.0f, 10.0f)];
        indicatorView.text = @"    ";
        indicatorView.backgroundColor = dataItem.tintColor;
        indicatorView.layer.mask = maskLayer;
        [legendView addArrangedSubview:indicatorView];
        
        UILabel* textLabel = [[UILabel alloc] init];
        textLabel.textColor = textColor;
        textLabel.font = [UIFont systemFontOfSize:fontSize];
        textLabel.text = dataItem.title;
        textLabel.frame = CGRectMake(indicatorView.frame.size.width + 10.0f, 0.0f, 0.0f, 0.0f);
        [textLabel sizeToFit];
        textLabel.center = CGPointMake(textLabel.center.x, indicatorView.center.y);
        [legendView addArrangedSubview:textLabel];
        
        [_stackView addArrangedSubview:legendView];
    }
    
    _legendWidth = _maxTextSize + 30.0f;
    [self setNeedsLayout];
    return ;
}

@end
