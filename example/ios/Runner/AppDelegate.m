#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "XRootController.h"
#import <hybrid_stack_plugin/XURLRouter.h>
#import "XDemoController.h"
#import "XNavigationViewController.h"
#import "XNewDemoViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    XNavigationViewController *rootNav1 = [[XNavigationViewController alloc] initWithRootViewController:[XRootController new]];
    rootNav1.title=@"界面1";
    
    XNavigationViewController *rootNav2 = [[XNavigationViewController alloc] initWithRootViewController:[XRootController new]];
    tabbarVC.viewControllers = @[rootNav1, rootNav2];
    rootNav2.title=@"界面2";

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.rootViewController = tabbarVC;
    [window makeKeyAndVisible];
    self.window = window;
    [self setupNativeOpenUrlHandler];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)setupNativeOpenUrlHandler{
    [[XURLRouter sharedInstance] setNativeOpenUrlHandler:^UIViewController *(NSString *url,NSDictionary *query,NSDictionary *params){
        NSURL *tmpUrl = [NSURL URLWithString:url];
        if([@"ndemo" isEqualToString:tmpUrl.host]){
            return [XDemoController new];
        }
        if([@"newndemo" isEqualToString:tmpUrl.host]){
            return [XNewDemoViewController new];
        }
        return nil;
    }];
}

@end
