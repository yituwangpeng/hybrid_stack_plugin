//
//  XDemoController.m
//  Runner
//
//  Created by 王鹏 on 2018/12/25.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

#import "XDemoController.h"
#import <hybrid_stack_plugin/XURLRouter.h>

static NSInteger sNativeVCIdx = 0;

@interface XDemoController ()
@end

@implementation XDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    sNativeVCIdx++;
    NSString *title = [NSString stringWithFormat:@"Native demo page(%ld)",(long)sNativeVCIdx];
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
    [btn setTitle:@"Click to jump Flutter" forState:UIControlStateNormal];
    [view addSubview:btn];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setCenter:CGPointMake(view.center.x, view.center.y+50)];
    [btn addTarget:self action:@selector(onJumpFlutterPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = view;
}

- (void)onJumpNativePressed{
    XOpenURLWithQueryAndParams(@"hrd://newndemo", nil, nil);
}

- (void)onJumpFlutterPressed{
    XOpenURLWithQueryAndParams(@"hrd://fdemo", @{@"flutter":@(true)}, nil);
}
@end
