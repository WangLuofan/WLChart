//
//  WLChart.h
//  WLChart
//
//  Created by 王落凡 on 2018/5/11.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLChartDataItem;
@interface WLBasicChart : UIView

@property(nonatomic, copy) NSArray* dataItems;

-(void)initDefaultValues;
-(void)stroke:(BOOL)bAnimated;

@end
