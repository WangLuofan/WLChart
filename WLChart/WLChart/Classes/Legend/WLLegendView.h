//
//  WLLegendView.h
//  WLChart
//
//  Created by 王落凡 on 2018/5/17.
//  Copyright © 2018年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface WLLegendView : UIView

-(instancetype)initWithDataItems:(NSArray*)dataItems fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor;
@property(nonatomic, assign, readonly) CGFloat legendWidth;

@end
