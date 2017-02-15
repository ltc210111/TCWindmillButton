//
//  TCWindmillButton.m
//  TCWindmillButton
//
//  Created by lotic on 17/2/8.
//  Copyright © 2017年 lotic. All rights reserved.
//

#import "TCWindmillButton.h"
@interface TCWindmillButton()
@property(nonatomic,assign) BOOL isOpen;
@property(nonatomic,copy)NSMutableArray *angleArr;
@property(nonatomic,copy)NSMutableArray *openPoint;
@end

@implementation TCWindmillButton

- (instancetype)init {
    if(self = [super init]) {
        if(!_iconRadius) _iconRadius = 100;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        if(!_iconRadius) _iconRadius = 100;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_mainBtn addTarget:self action:@selector(showIcon) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBtn {
    //主按钮
    _mainBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_mainBtn];
    
    _angleArr = [NSMutableArray array];
    //btn中心x边
    double x = fabs(self.center.x - [UIScreen mainScreen].bounds.size.width);
    //btn中心y边
    double y = fabs(self.center.y - [UIScreen mainScreen].bounds.size.height);
    //角度
    double fullAngle = M_PI * 1.5 - acos(x/_iconRadius) - acos(y/_iconRadius);
    double perAngle = fullAngle / (_iconArr.count + 1);
    
    //初始位置
    [_angleArr addObject:@(fullAngle)];
    
    //计算每个按钮最终位置
    for (NSInteger i = 0; i< _iconArr.count; i++) {
        UIButton *btn = _iconArr[i];
        btn.layer.transform=CATransform3DMakeRotation(M_PI, 0, 0, 1); //颠倒图片旋转M_PI就可以
        //最终角度
        CGFloat recutAngle = acos(x/_iconRadius) + perAngle * i - 1.35 * M_PI;
        [_angleArr addObject:@(recutAngle)];
        btn.alpha = 0;
        [self addSubview:btn];
    }
    
}

- (void)showIcon {
    UIBezierPath* path = [UIBezierPath bezierPath];
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //动画起点
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = .5f;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    __block CGAffineTransform trans1 = _mainBtn.transform;
    if(_isOpen) {
        _isOpen = !_isOpen;
        //中心按钮旋转
        trans1 = CGAffineTransformIdentity;
        //收起
        [UIView animateWithDuration:.5f animations:^{
            _mainBtn.transform = trans1;
            for (NSInteger i = 0; i< _iconArr.count; i++) {
                UIButton *btn = _iconArr[i];
                btn.transform = CGAffineTransformRotate(btn.transform, M_PI);
                btn.alpha = 0;
            }
        }];
        
        //小方块旋转路径
        for (NSInteger i = 0; i< _iconArr.count; i++) {
            path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_iconRadius/2, _iconRadius/2)
                                                  radius:_iconRadius
                                              startAngle:[_angleArr[i+1] floatValue]
                                                endAngle:[_angleArr[0] floatValue]
                                               clockwise:NO];
            animation.path = path.CGPath;
            [_iconArr[i] addAnimation:animation forKey:@"add"];
        }
    }else {
        _isOpen = !_isOpen;
        //中心按钮旋转
        trans1 = CGAffineTransformMakeRotation(-1.25 * M_PI);
        //打开
        [UIView animateWithDuration:.5f animations:^{
            _mainBtn.transform = trans1;
            for (NSInteger i = 0; i< _iconArr.count; i++) {
                UIButton *btn = _iconArr[i];
                btn.transform = CGAffineTransformRotate( btn.transform, M_PI);
                btn.alpha = 1;
            }
        }];
        //小方块旋转路径
        _openPoint = [NSMutableArray array];
        for (NSInteger i = 0; i< _iconArr.count; i++) {
            path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_iconRadius/2, _iconRadius/2)
                                                  radius:_iconRadius
                                              startAngle:[_angleArr[0] floatValue]
                                                endAngle:[_angleArr[i+1] floatValue]
                                               clockwise:YES];
            animation.path = path.CGPath;
            [_iconArr[i] addAnimation:animation forKey:@"add"];
            UIButton * bb = _iconArr[i];
            bb.frame = CGRectMake(path.currentPoint.x - 17, path.currentPoint.y - 17, 35, 35);
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (_isOpen == YES) {
        for (UIButton *btn in _iconArr) {
            if ((point.x <= btn.frame.origin.x + 35 && point.x >= btn.frame.origin.x) && (point.y <= btn.frame.origin.y + 35 && point.y >= btn.frame.origin.y)) {
                return btn;
            }
        }
    }
    if(point.x >= 0 && point.y >= 0)
        return _mainBtn;
    else
        return nil;
}

#pragma setter
- (void)setIconArr:(NSArray *)iconArr {
    _iconArr = iconArr;
    [self setBtn];
}

@end
