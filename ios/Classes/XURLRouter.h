//
//  XURLRouter.h
//  hybrid_stack_plugin
//
//  Created by 王鹏 on 2018/12/25.
//

#import <Foundation/Foundation.h>
#define kOpenUrlPrefix  @"hrd"

typedef UIViewController* (^NativeOpenUrlHandler)(NSString *,NSDictionary *,NSDictionary *);
void XOpenURLWithQueryAndParams(NSString *url,NSDictionary *query,NSDictionary *params);

@interface XURLRouter : NSObject

@property (nonatomic,weak) NativeOpenUrlHandler nativeOpenUrlHandler;
+ (instancetype)sharedInstance;

+ (UINavigationController *)xHybrid_currentNavigationViewController;

@end
