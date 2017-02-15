//
//  TCWindmillButton.h
//  TCWindmillButton
//
//  Created by lotic on 17/2/8.
//  Copyright © 2017年 lotic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCWindmillButton : UIButton
@property (nonatomic,weak) UIButton *mainBtn;
@property (nonatomic,copy) NSArray *iconArr;
@property (nonatomic,assign) CGFloat iconRadius; //中心点间的距离

@end
