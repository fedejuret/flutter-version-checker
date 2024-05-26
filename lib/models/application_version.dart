import 'dart:convert';

ApplicationVersion applicationVersionFromJson(String str) => ApplicationVersion.fromJson(json.decode(str));

String applicationVersionToJson(ApplicationVersion data) => json.encode(data.toJson());

class ApplicationVersion {
    int id;
    int applicationId;
    Application application;
    String name;
    String description;
    String token;
    String version;
    String platform;
    bool updateRequired;

    ApplicationVersion({
        required this.id,
        required this.applicationId,
        required this.application,
        required this.name,
        required this.description,
        required this.token,
        required this.version,
        required this.platform,
        required this.updateRequired,
    });

    factory ApplicationVersion.fromJson(Map<String, dynamic> json) => ApplicationVersion(
        id: json["id"],
        applicationId: json["application_id"],
        application: Application.fromJson(json["application"]),
        name: json["name"],
        description: json["description"],
        token: json["token"],
        version: json["version"],
        platform: json["platform"],
        updateRequired: json["update_required"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "application_id": applicationId,
        "application": application.toJson(),
        "name": name,
        "description": description,
        "token": token,
        "version": version,
        "platform": platform,
        "update_required": updateRequired,
    };
}

class Application {
    int id;
    String token;
    String name;

    Application({
        required this.id,
        required this.token,
        required this.name,
    });

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        token: json["token"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "name": name,
    };
}
