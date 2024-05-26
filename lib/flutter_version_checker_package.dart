library flutter_version_checker_package;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_version_checker_package/models/application_version.dart';
import 'package:flutter_version_checker_package/services/api.dart';
import 'package:flutter_version_checker_package/version_status_enum.dart';

class FlutterVersionChecker extends StatelessWidget {
  final String appToken;
  final String apiKey;
  final Function(
    VersionStatus status,
    ApplicationVersion lastVersion,
    ApplicationVersion? updateVersion,
  ) resolve;

  FlutterVersionChecker({
    super.key,
    required this.resolve,
    required this.appToken,
    required this.apiKey,
  }) {
    if (kIsWeb) {
      throw FlutterError("Cannot use this package on websites");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().checkVersion(appToken: appToken, apiKey: apiKey),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw Exception(snapshot.error);
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          resolve(data.$1, data.$2, data.$3);
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
