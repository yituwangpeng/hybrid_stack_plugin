//
//  XFlutterViewController.m
//  hybrid_stack_plugin
//
//  Created by 王鹏 on 2018/12/25.
//

#import "XFlutterViewController.h"

@interface XFlutterViewController ()

@property (nonatomic,assign) BOOL enableViewWillAppear;

@end

@implementation XFlutterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.enableViewWillAppear = TRUE;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    if(self.enableViewWillAppear == FALSE)
        return;
    [super viewWillAppear:animated];
    self.enableViewWillAppear = FALSE;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.enableViewWillAppear = TRUE;
}

@end
