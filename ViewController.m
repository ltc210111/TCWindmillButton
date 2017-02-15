//
//  ViewController.m
//  TCWindmillButton
//
//  Created by lotic on 17/2/8.
//  Copyright © 2017年 lotic. All rights reserved.
//

#import "ViewController.h"
#import "TCWindmillButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *btnArr = [NSMutableArray array];
    for (int i = 0 ; i<4; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"pinc_btn_shan%d",i+1]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 35, 35);
        [btnArr addObject:btn];
    }
    UIButton *mainBtn = [UIButton new];
    [mainBtn setImage:[UIImage imageNamed:@"pinc_btn_shan_n"] forState:UIControlStateNormal];
    TCWindmillButton *btn = [[TCWindmillButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 65, self.view.bounds.size.height - 65, 60, 60)];
    btn.iconRadius = 100;
    btn.mainBtn = mainBtn;  //设置mainBtn 必须在iconArr前面
    btn.iconArr = [NSArray arrayWithArray:btnArr];
    
    [self.view addSubview:btn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
