#import <Flutter/Flutter.h>

@interface HybridStackPlugin : NSObject<FlutterPlugin>

+ (instancetype)sharedInstance;
@property (nonatomic,strong) FlutterMethodChannel* methodChannel;
@property (nonatomic,strong) NSDictionary* mainEntryParams;

@end
