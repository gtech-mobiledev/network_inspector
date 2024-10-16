import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_inspector/common/utils/http_interceptor.dart';
import 'package:network_inspector/network_inspector.dart';

import '../../common/notification_helper.dart';

class MainProvider extends ChangeNotifier {
  final BuildContext context;

  MainProvider({
    required this.context,
  }) {
    injectDependencies();
  }

  NotificationHelper? notificationHelper;
  NetworkInspector? networkInspector;

  Future<void> injectDependencies() async {
    notificationHelper = NotificationHelper();
    networkInspector = NetworkInspector();
  }

  HttpInterceptor get httpClient {
    final client = Client();

    final interceptor = HttpInterceptor(
      logIsAllowed: true,
      client: client,
      baseUrl: Uri.parse('http://10.10.43.100:8080/'),
      networkInspector: networkInspector,
      onHttpFinish: (hashCode, title, message) {
        notifyActivity(
          title: title,
          message: message,
        );
      },
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer WEKLSSS'
      },
    );
    return interceptor;
  }

  Future<void> notifyActivity({
    required String title,
    required String message,
  }) async {
    await notificationHelper?.showNotification(
      classHashId: notificationHelper.hashCode,
      title: title,
      message: message,
      payload: 'networkInspector',
    );
  }
}
