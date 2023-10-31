import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sdk_plugin_method_channel.dart';

abstract class SdkPluginPlatform extends PlatformInterface {
  /// Constructs a SdkPluginPlatform.
  SdkPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SdkPluginPlatform _instance = MethodChannelSdkPlugin();

  /// The default instance of [SdkPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSdkPlugin].
  static SdkPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SdkPluginPlatform] when
  /// they register themselves.
  static set instance(SdkPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
