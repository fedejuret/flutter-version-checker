import 'dart:convert';
import 'dart:io';

import 'package:flutter_version_checker_package/models/application_version.dart';
import 'package:flutter_version_checker_package/version_status_enum.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

final class Api {
  final String apiUrl = "http://app.version.checker.federicojuretich.com";

  Future<
          (
            VersionStatus status,
            ApplicationVersion lastVersion,
            ApplicationVersion? updateVersion
          )>
      checkVersion({required String appToken, required String apiKey}) async {
    try {
      final info = await PackageInfo.fromPlatform();
      final response = await http.post(
        Uri.parse("$apiUrl/applications/$appToken/check"),
        body: jsonEncode({
          "current_version": info.version,
          "platform": Platform.operatingSystem.toLowerCase(),
        }),
        headers: {"Api-Key": apiKey, "Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      final body = jsonDecode(response.body);

      return (
        VersionStatus.values
            .where(
                (element) => camelToSnakeCase(element.name) == body["status"])
            .first,
        ApplicationVersion.fromJson(body["last_version"]),
        body["update_version"] != null
            ? ApplicationVersion.fromJson(body["update_version"])
            : null
      );
    } catch (e) {
      rethrow;
    }
  }

  String camelToSnakeCase(String input) {
    RegExp exp = RegExp(r'([a-z])([A-Z])');
    String snakeCase = input.replaceAllMapped(exp, (Match m) {
      return '${m[1]}_${m[2]!.toLowerCase()}';
    });
    return snakeCase.toLowerCase();
  }
}
