//
//  FlutterViewWrapperController.h
//  hybrid_stack_plugin
//
//  Created by 王鹏 on 2018/12/25.
//

#import <UIKit/UIKit.h>
#import "XFlutterViewController.h"
#import "UIViewController+URLRouter.h"

typedef void (^FlutterViewWillAppearBlock) (void);

NS_ASSUME_NONNULL_BEGIN

@interface FlutterViewWrapperController : UIViewController

+ (XFlutterViewController *)flutterVC;
@property(nonatomic,copy) NSString *curFlutterRouteName;
@property(nonatomic,copy) FlutterViewWillAppearBlock viewWillAppearBlock;

@end

NS_ASSUME_NONNULL_END
