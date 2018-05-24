//
//  WLChartDataItem.h
//  WLChart
//
//  Created by 王落凡 on 2018/5/11.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface WLChartDataItem : NSObject

@property(nonatomic, strong) UIColor* tintColor;

//For Single Value Chart
@property(nonatomic, assign) CGFloat value;

//For Double Value Chart
@property(nonatomic, assign) CGFloat xAxisValue;
@property(nonatomic, assign) CGFloat yAxisValue;

@property(nonatomic, copy) NSString* title;
@property(nonatomic, assign) CGFloat fontSize;

+(instancetype)dataItemWithValue:(CGFloat)value;
+(instancetype)dataItemWithxAxisValue:(CGFloat)xAxisValue yAxisValue:(CGFloat)yAxisValue;

@end
