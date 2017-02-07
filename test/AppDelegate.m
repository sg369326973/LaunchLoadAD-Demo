//
//  AppDelegate.m
//  test
//
//  Created by addcn591 on 17/2/7.
//  Copyright © 2017年 Addcn. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

//启动页view
@property (strong, nonatomic) UIView *LaunchView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //获取启动页
    UIStoryboard *LaunchScreen = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    UIViewController *LaunchVC = [LaunchScreen instantiateInitialViewController];
    self.LaunchView = LaunchVC.view;
    
    //加载远程广告
    [self loadAD];
    
    //设置rootView
    self.window.rootViewController = LaunchVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark 加载远程广告
- (void)loadAD
{
    //远程图片地址
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1486466389044&di=a7ab421bb82bd0d214bbdc5a6b79f2bf&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F80%2F57%2F94s58PICA7j_1024.jpg"];
    
    //异步加载图片
    dispatch_queue_t queue = dispatch_queue_create("loadImage", NULL);
    dispatch_async(queue, ^{
        
        //图片资源
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //创建imageView
            UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
            adView.image = img;
            
            //添加图片点击手势
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAD)];
            adView.userInteractionEnabled = YES;
            [adView addGestureRecognizer:singleTap];
            
            [self.LaunchView addSubview:adView];
            
            //LaunchView前置于window
            [self.window bringSubviewToFront:self.LaunchView];
            
            //延迟5秒后删除广告
            [self performSelector:@selector(removeAd) withObject:nil afterDelay:5];
        });
    });
}

#pragma mark 广告点击
- (void)clickAD {
    NSLog(@"关闭广告");
    [self removeAd];
}

#pragma mark 删除广告
- (void)removeAd
{
    [self.LaunchView removeFromSuperview];
    
    //重新设置rootView
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = [main instantiateInitialViewController];
    [self.window makeKeyAndVisible];  
}


@end
