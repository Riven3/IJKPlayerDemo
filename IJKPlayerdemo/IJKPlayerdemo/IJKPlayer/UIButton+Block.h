//
//  UIButton+Block.h
//  JTPro
//
//  Created by 金劲通 on 2020/4/28.
//  Copyright © 2020 qh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Block)

//addTarget替换为block ·
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;


/*
 *
 增大点击区域
 @param size 范围增大量
 */
- (void)jt_setEnlargeEdge:(CGFloat)size;

/*
 *
 增大点击区域
 @param size 上左下右的增大量
 */
- (void)jt_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END
