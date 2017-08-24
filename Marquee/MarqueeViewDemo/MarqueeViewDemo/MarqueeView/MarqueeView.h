//
//  MarqueeView.h
//  Marquee
//
//  Created by 杨帅 on 2017/8/24.
//  Copyright © 2017年 杨帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarqueeView : UIView
/*
 * 显示内容
 * 设置content值时，会重置跑马灯
*/
@property (copy, nonatomic) NSString *content;
/*
 * 刷新频率
 * 默认值为0.01
 */
@property (assign, nonatomic) NSTimeInterval frequency;
/*
 * 移动步数
 * 默认值为0.3
 */
@property (assign, nonatomic) CGFloat steps;

- (void)start;

- (void)startWithContent:(NSString *)content;

- (void)pause;

- (void)reset;

@end
