//
//  MyToast.m
//  install-app-IOS
//
//  Created by pengbingxiang on 2018/1/19.
//  Copyright © 2018年 YWX. All rights reserved.
//

#import "MyToast.h"

static const CGFloat TOAST_LOCATION_TOP = 0.1;

static const CGFloat TOAST_LOCATION_CENTER = 0.4;

static const CGFloat TOAST_LOCATION_BOTTOM = 0.7;

@interface MyToast (){
    CGFloat _scale;
}
/** 判断当前是否已经显示了toast */
@property (nonatomic, assign) BOOL isShowToast;
@end

@implementation MyToast

static MyToast *toast = nil;

+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[MyToast alloc]init];
    });
    return toast;
}
- (void)showToastWithSuperView:(UIView *)view Message:(NSString *)msgStr Time:(CGFloat)time {
    if (self.isShowToast) {
        return;
    }
    self.isShowToast = YES;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.8;
    CGSize size = [msgStr boundingRectWithSize:CGSizeMake(maxWidth, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CGFloat width = size.width + 40;
    CGFloat height = size.height + 30;
    
    _scale = !_scale ? TOAST_LOCATION_TOP : _scale;
    CGFloat orin_x = ([UIScreen mainScreen].bounds.size.width - width) / 2;
    CGFloat orin_y = [UIScreen mainScreen].bounds.size.height * _scale;
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(orin_x, orin_y, width, height)];
    bgview.backgroundColor = self.backgroudColor ? self.backgroudColor : [UIColor blackColor];
    bgview.alpha = 0.8f;
    bgview.layer.cornerRadius = height / 2;
    bgview.layer.masksToBounds = YES;
    [view addSubview:bgview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, size.width, size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = msgStr;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = self.textColor ? self.textColor : [UIColor whiteColor];
    label.numberOfLines = 0;
    [bgview addSubview:label];
    
    __weak typeof(self)myself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time - 1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_after --- ");
        [bgview removeFromSuperview];
        myself.isShowToast = NO;
    });
}

- (void)setLocation:(ToastLocation)location {
    _location = location;
    if (location == Loc_Top) {
        _scale = TOAST_LOCATION_TOP;
    } else if (location == Loc_Center) {
        _scale = TOAST_LOCATION_CENTER;
    } else {
        _scale = TOAST_LOCATION_BOTTOM;
    }
}

@end
