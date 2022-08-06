import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// PackageInfo の useState
PackageInfoState usePackageInfoState() {
  final packageInfoStateRef = useRef(const PackageInfoState(fetched: false));
  final packageInfoAsyncSnapshot = useFuture<PackageInfo>(
    useMemoized<Future<PackageInfo>>(PackageInfo.fromPlatform),
  );
  return packageInfoStateRef.value = PackageInfoState(
    fetched: packageInfoAsyncSnapshot.hasData,
    packageInfo: packageInfoAsyncSnapshot.data,
  );
}

@immutable
class PackageInfoState {
  const PackageInfoState({
    required this.fetched,
    this.packageInfo,
  });

  final bool fetched;
  final PackageInfo? packageInfo;
}
