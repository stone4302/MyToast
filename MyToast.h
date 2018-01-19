//
//  MyToast.h
//  install-app-IOS
//
//  Created by pengbingxiang on 2018/1/19.
//  Copyright © 2018年 YWX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ToastLocation) {
    Loc_Top,     // 默认
    Loc_Center,
    Loc_Bottom
};

@protocol MyToastProtocol <NSObject>

@optional

- (void)showToastWithSuperView:(UIView*)view Message:(NSString*)msgStr Time:(CGFloat)time;

@end

@interface MyToast : NSObject<MyToastProtocol>
/** 背景颜色 */
@property (nonatomic, strong) UIColor *backgroudColor;
/** 字体颜色 */
@property (nonatomic, strong) UIColor *textColor;
/** 位置 */
@property (nonatomic, assign) ToastLocation location;

+ (instancetype)share;

@end
