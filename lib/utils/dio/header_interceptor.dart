import 'package:dio/dio.dart';

import '../constants/string.dart';
import '../settings.dart';

/// ヘッダーに認証情報などを付加する
class HeaderInterceptor extends Interceptor {
  HeaderInterceptor([this.overwriteUrl]);

  String? overwriteUrl;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[referrer] = overwriteUrl ?? options.baseUrl;
    options.headers['Origin'] = options.baseUrl;
    options.headers['Accept'] = 'application/vnd.github.v3+json';
    if (gitHubToken.isNotEmpty) {
      options.headers['Authorization'] = 'token $gitHubToken';
    }
    return handler.next(options);
  }
}
