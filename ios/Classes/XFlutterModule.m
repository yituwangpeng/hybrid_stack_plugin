//
//  XFlutterModule.m
//  hybrid_stack_plugin
//
//  Created by 王鹏 on 2018/12/25.
//

#import "XFlutterModule.h"
#import <hybrid_stack_plugin/HybridStackPlugin.h>
#import <hybrid_stack_plugin/XURLRouter.h>

@interface XFlutterModule()
{
    BOOL _isInFlutterRootPage;
    bool _isFlutterWarmedup;
}
@end

@implementation XFlutterModule
@synthesize isInFlutterRootPage = _isInFlutterRootPage;
#pragma mark - XModuleProtocol
+ (instancetype)sharedInstance{
    static XFlutterModule *sXFlutterModule;
    if(sXFlutterModule)
        return sXFlutterModule;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sXFlutterModule = [[[self class] alloc] initInstance];
        [sXFlutterModule warmupFlutter];
    });
    return sXFlutterModule;
}

- (instancetype)initInstance{
    if(self = [super init]){
        _isInFlutterRootPage = TRUE;
    }
    return self;
}

- (XFlutterViewController *)flutterVC{
    return [FlutterViewWrapperController flutterVC];
}

- (void)warmupFlutter{
    if(_isFlutterWarmedup)
        return;
    XFlutterViewController *flutterVC = [FlutterViewWrapperController flutterVC];
    [flutterVC view];
    [NSClassFromString(@"GeneratedPluginRegistrant") performSelector:NSSelectorFromString(@"registerWithRegistry:") withObject:flutterVC];
    _isFlutterWarmedup = true;
}

+ (NSDictionary *)parseParamsKV:(NSString *)aParamsStr{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *kvAry = [aParamsStr componentsSeparatedByString:@"&"];
    for(NSString *kv in kvAry){
        NSArray *ary = [kv componentsSeparatedByString:@"="];
        if (ary.count == 2) {
            NSString *key = ary.firstObject;
            NSString *value = [ary.lastObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [dict setValue:value forKey:key];
        }
    }
    return dict;
}

- (void)openURL:(NSString *)aUrl query:(NSDictionary *)query params:(NSDictionary *)params{
    static BOOL sIsFirstPush = TRUE;
    //Process aUrl and Query Stuff.
    NSURL *url = [NSURL URLWithString:aUrl];
    
    NSMutableDictionary *mQuery = [NSMutableDictionary dictionaryWithDictionary:query];
    [mQuery addEntriesFromDictionary:[XFlutterModule parseParamsKV:url.query]];
    NSMutableDictionary *mParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [mParams addEntriesFromDictionary:[XFlutterModule parseParamsKV:url.parameterString]];
    NSString *pageUrl = [NSString stringWithFormat:@"%@://%@",url.scheme,url.host];
    
    FlutterMethodChannel *methodChann = [HybridStackPlugin sharedInstance].methodChannel;
    NSMutableDictionary *arguments = [NSMutableDictionary dictionary];
    [arguments setValue:pageUrl forKey:@"url"];
    
    NSMutableDictionary *mutQuery = [NSMutableDictionary dictionary];
    for(NSString *key in query.allKeys){
        id value = [query objectForKey:key];
        //[TODO]: Add customized implementations for non-json-serializable objects into json-serializable ones.
        [mutQuery setValue:value forKey:key];
    }
    [arguments setValue:mutQuery forKey:@"query"];
    
    NSMutableDictionary *mutParams = [NSMutableDictionary dictionary];
    for(NSString *key in mParams.allKeys){
        id value = [mParams objectForKey:key];
        //[TODO]: Add customized implementations for non-json-serializable objects into json-serializable ones.
        [mutParams setValue:value forKey:key];
    }
    [arguments setValue:mutParams forKey:@"params"];
    
    [arguments setValue:@(0) forKey:@"animated"];
    
    //Push
    UINavigationController *currentNavigation = [XURLRouter xHybrid_currentNavigationViewController];
    FlutterViewWrapperController *viewController = [[FlutterViewWrapperController alloc] initWithURL:[NSURL URLWithString:aUrl] query:query nativeParams:params];
    viewController.viewWillAppearBlock = ^(){
        //Process first & later message sending according distinguishly.
        if(sIsFirstPush){
            [HybridStackPlugin sharedInstance].mainEntryParams = arguments;
            sIsFirstPush = FALSE;
        }
        else{
            [methodChann invokeMethod:@"openURLFromFlutter" arguments:arguments result:^(id  _Nullable result) {
            }];
        }
    };
    [currentNavigation pushViewController:viewController animated:YES];
}

#pragma mark - XFlutterModuleProtocol
@end
