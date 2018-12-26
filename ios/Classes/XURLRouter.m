//
//  XURLRouter.m
//  hybrid_stack_plugin
//
//  Created by 王鹏 on 2018/12/25.
//

#import "XURLRouter.h"
#import "XFlutterModule.h"

@implementation XURLRouter
+ (instancetype)sharedInstance{
    static XURLRouter *sInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [XURLRouter new];
    });
    return sInstance;
}

+ (UINavigationController *)xHybrid_currentNavigationViewController
{
    UIViewController *topVC = [self xHybrid_topViewController];
    return topVC.navigationController;
}

+ (UIViewController *)xHybrid_topViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //找到 windowLevel=UIWindowLevelNormal 的UIWindow
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *appRootVC = window.rootViewController;
    return [self traverseTopViewController:appRootVC];
}

+ (UIViewController *)traverseTopViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self traverseTopViewController:[navigationController.viewControllers lastObject]];
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)rootViewController;
        return [self traverseTopViewController:tabController.selectedViewController];
    }
    if (rootViewController.presentedViewController) {
        return [self traverseTopViewController:rootViewController.presentedViewController];
    }
    return rootViewController;
}

@end

void XOpenURLWithQueryAndParams(NSString *url,NSDictionary *query,NSDictionary *params){
    NSURL *tmpUrl = [NSURL URLWithString:url];
    UINavigationController *rootNav = [XURLRouter xHybrid_currentNavigationViewController];
    if(![kOpenUrlPrefix isEqualToString:tmpUrl.scheme])
        return;
    if([[query objectForKey:@"flutter"] boolValue]){
        [[XFlutterModule sharedInstance] openURL:url query:query params:params];
        return;
    }
    NativeOpenUrlHandler handler = [XURLRouter sharedInstance].nativeOpenUrlHandler;
    if(handler!=nil)
    {
        UIViewController *vc = handler(url,query,params);
        if(vc!=nil)
            [rootNav pushViewController:vc animated:YES];
    }
}
