#import "HybridStackPlugin.h"
#import "FlutterViewWrapperController.h"
#import "XURLRouter.h"
#import <sys/utsname.h>

@interface HybridStackPlugin()
@property (nonatomic,strong) NSObject<FlutterPluginRegistrar>* registrar;
@end

@implementation HybridStackPlugin
+ (instancetype)sharedInstance{
    static HybridStackPlugin * sharedInst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [[HybridStackPlugin alloc] init];
    });
    return sharedInst;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar{
    HybridStackPlugin* instance = [HybridStackPlugin sharedInstance];
    instance.methodChannel = [FlutterMethodChannel
                              methodChannelWithName:@"hybrid_stack_manager"
                              binaryMessenger:[registrar messenger]];
    [registrar addMethodCallDelegate:instance channel:instance.methodChannel];
    instance.registrar = registrar;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"openUrlFromNative" isEqualToString:call.method]) {
        NSDictionary *openUrlInfo = call.arguments;
        XOpenURLWithQueryAndParams(openUrlInfo[@"url"], openUrlInfo[@"query"],openUrlInfo[@"params"]);
    }
    else if([@"getMainEntryParams" isEqualToString:call.method]){
        NSDictionary *params = self.mainEntryParams?:@{};
        if([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] == NSOrderedAscending){
            NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *mutParams = [NSMutableDictionary dictionaryWithDictionary:params];
            params=mutParams;
        }
        result(params);
        //      self.mainEntryParams = nil;
    }
    else if([@"updateCurFlutterRoute" isEqualToString:call.method]){
        NSString *curRouteName = call.arguments;
        UINavigationController *rootNav = [XURLRouter xHybrid_currentNavigationViewController];
        UIViewController *topVC = rootNav.topViewController;
        if([topVC isKindOfClass:[FlutterViewWrapperController class]]){
            FlutterViewWrapperController *flutterVC = topVC;
            [flutterVC setCurFlutterRouteName:curRouteName];
        }
    }
    else if([@"popCurPage" isEqualToString:call.method]){
        BOOL animated = YES;
        if (call.arguments && [call.arguments isKindOfClass:[NSNumber class]]) {
            animated = [(NSNumber *)call.arguments boolValue];
        }
        UINavigationController *nav = [XURLRouter xHybrid_currentNavigationViewController];
        if([nav.topViewController isKindOfClass:[FlutterViewWrapperController class]]){
            [nav popViewControllerAnimated:animated];
        }
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}
@end
