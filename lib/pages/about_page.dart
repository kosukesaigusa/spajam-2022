import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../hooks/package_info_state.dart';

class AboutPage extends HookWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfoState = usePackageInfoState();
    final packageInfo = packageInfoState.packageInfo;
    return Scaffold(
      appBar: AppBar(title: const Text('このアプリについて')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('App Name: ${_getAppNameText(packageInfo)}'),
            Text('Version: ${_getVersionInfoText(packageInfo)}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ds = await FirebaseFirestore.instance.collection('test').doc('test').get();
          final data = ds.data();
          debugPrint(data.toString());
        },
      ),
    );
  }

  /// バージョン番号のテキストを取得する
  String _getAppNameText(PackageInfo? packageInfo) {
    if (packageInfo == null) {
      return '';
    }
    return packageInfo.appName;
  }

  /// バージョン番号のテキストを取得する
  String _getVersionInfoText(PackageInfo? packageInfo) {
    if (packageInfo == null) {
      return '';
    }
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
