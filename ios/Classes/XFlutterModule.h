//
//  XFlutterModule.h
//  hybrid_stack_plugin
//
//  Created by 王鹏 on 2018/12/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "FlutterViewWrapperController.h"

@interface XFlutterModule : NSObject

+ (instancetype)new __attribute__((unavailable("Must use sharedInstance instead.")));
- (instancetype)init __attribute__((unavailable("Must use sharedInstance instead.")));
+ (instancetype)sharedInstance;
@property (nonatomic,assign) BOOL isInFlutterRootPage;
@property (nonatomic,strong) XFlutterViewController *flutterVC;
- (void)openURL:(NSString *)aUrl query:(NSDictionary *)query params:(NSDictionary *)params;
- (void)warmupFlutter;

@end
