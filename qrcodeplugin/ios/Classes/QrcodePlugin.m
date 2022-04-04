#import "QrcodePlugin.h"
#if __has_include(<qrcodeplugin/qrcodeplugin-Swift.h>)
#import <qrcodeplugin/qrcodeplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "qrcodeplugin-Swift.h"
#endif

@implementation QrcodePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQrcodePlugin registerWithRegistrar:registrar];
}
@end
