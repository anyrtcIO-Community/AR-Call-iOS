// UIView+Frame.m
//
// Copyright (c) 2009 Alex Nazaroff, AJR (http://ajiiro.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WZXLineDirection) {
    WZXLineDirectionLeft   = 1 << 0,
    WZXLineDirectionRight  = 1 << 1,
    WZXLineDirectionTop    = 1 << 2,
    WZXLineDirectionBottom = 1 << 3
};

typedef NS_ENUM(NSInteger,WZXLineType) {
    // default
    WZXLineTypeFill    = 1 << 0,
    // 短一点的线 (70%)
    WZXLineTypeShort   = 1 << 1,
    // 虚线
    WZXLineTypeDotted  = 1 << 2
};

@interface UIView (WZXLines)

/**
 *  完整方法:
 *  direction 线的方向，可多选,
 *  type      线的样式，虚线可与其它多选,
 *  lineWidth 线的宽度,
 *  lineColor 线的颜色
 */
- (void)wzx_addLineWithDirection:(WZXLineDirection)direction
                            type:(WZXLineType)type
                       lineWidth:(CGFloat)lineWidth
                       lineColor:(UIColor *)lineColor;

/**
 *  默认线颜色(黑色)
 */
- (void)wzx_addLineWithDirection:(WZXLineDirection)direction
                            type:(WZXLineType)type
                       lineWidth:(CGFloat)lineWidth;

/** 
 *  默认线颜色(黑色),
 *  默认线样式(WZXLineTypeFill)
 */
- (void)wzx_addLineWithDirection:(WZXLineDirection)direction
                       lineWidth:(CGFloat)lineWidth; 

/** 
 *  默认线颜色(黑色),
 *  默认线样式(WZXLineTypeFill),
 *  默认线宽度(2)
 */
- (void)wzx_addLineWithDirection:(WZXLineDirection)direction;




@end
