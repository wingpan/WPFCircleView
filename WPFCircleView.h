//
//  WPFCircleView.h
//  FetalMovement
//
//  Created by PanFengfeng on 14-6-5.
//  Copyright (c) 2014年 Doit.im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPFCircleView : UIView

@property (nonatomic, assign)CGFloat progress;
@property (nonatomic, assign)CGFloat radiusDiff; //difference between out radius and inner radius

@property (nonatomic, strong)UIColor *filledColorOfRing; //环的填充色
@property (nonatomic, strong)UIColor *filledColorOfRingGap;//环的缺口色
//@property (nonatomic, strong)UIColor *strokeColorOfRing; //环的描边色
@property (nonatomic, strong)UIColor *filledColorOfInnerCircle; //内圆的填充色


@end
