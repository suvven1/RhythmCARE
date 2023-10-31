import 'package:flutter_test/flutter_test.dart';
import 'package:sdk_plugin/sdk_plugin.dart';
import 'package:sdk_plugin/sdk_plugin_platform_interface.dart';
import 'package:sdk_plugin/sdk_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSdkPluginPlatform
    with MockPlatformInterfaceMixin
    implements SdkPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SdkPluginPlatform initialPlatform = SdkPluginPlatform.instance;

  test('$MethodChannelSdkPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSdkPlugin>());
  });

  test('getPlatformVersion', () async {
    SdkPlugin sdkPlugin = SdkPlugin();
    MockSdkPluginPlatform fakePlatform = MockSdkPluginPlatform();
    SdkPluginPlatform.instance = fakePlatform;

    expect(await sdkPlugin.getPlatformVersion(), '42');
  });
}
