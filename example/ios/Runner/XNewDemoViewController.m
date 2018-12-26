//
//  XNewDemoViewController.m
//  Runner
//
//  Created by 王鹏 on 2018/12/26.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

#import "XNewDemoViewController.h"
#import <hybrid_stack_plugin/XURLRouter.h>

static NSInteger sNewNativeVCIdx = 0;

@interface XNewDemoViewController ()
@end

@implementation XNewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sNewNativeVCIdx++;
    NSString *title = [NSString stringWithFormat:@"New native demo page(%ld)",(long)sNewNativeVCIdx];
    self.title = title;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [btn setTitle:@"Click to jump Native" forState:UIControlStateNormal];
    [view addSubview:btn];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setCenter:CGPointMake(view.center.x, view.center.y-50)];
    [btn addTarget:self action:@selector(onJumpNativePressed) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [btn setTitle:@"Click to jump new Flutter" forState:UIControlStateNormal];
    [view addSubview:btn];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setCenter:CGPointMake(view.center.x, view.center.y+50)];
    [btn addTarget:self action:@selector(onJumpFlutterPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = view;
}

- (void)onJumpNativePressed{
    XOpenURLWithQueryAndParams(@"hrd://ndemo", nil, nil);
}

- (void)onJumpFlutterPressed{
    XOpenURLWithQueryAndParams(@"hrd://newfdemo", @{@"flutter":@(true)}, nil);
}

@end
