//
//  ViewController.m
//  test
//
//  Created by addcn591 on 17/2/7.
//  Copyright © 2017年 Addcn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    test.center = self.view.center;
    test.text = @"广告测试成功~";
    [self.view addSubview:test];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
