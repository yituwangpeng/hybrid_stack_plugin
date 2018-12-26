//
//  UIViewController+URLRouter.h
//  hybrid_stack_plugin
//
//  Created by 王鹏 on 2018/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (URLRouter)

- (instancetype)initWithURL:(NSURL *)url query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams;

@end

NS_ASSUME_NONNULL_END
