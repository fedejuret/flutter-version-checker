# Flutter Application Version Checker

<hr>

With this package, you will be able to verify the version that your users are running and thus analyze if they need to update to a newer version.

Ceate your account an register your apps here: http://dash.app.version.checker.federicojuretich.com/sign-up

## How does it work?

Simple. You register your application on a platform and configure the package so that every time you want it is verified which version is on the platform.

## Example of use

```dart
FlutterVersionChecker(
                resolve: (
                  VersionStatus versionStatus,
                  ApplicationVersion lastVersion,
                  ApplicationVersion? updateVersion,
                ) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (versionStatus == VersionStatus.mustUpdate) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Update"),
                            content: Text(
                                "Musto update to: ${updateVersion!.version}"),
                          );
                        },
                      );
                    } else if (versionStatus == VersionStatus.availableUpdate) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("New version available"),
                            content: Text(
                                "You can update to: ${updateVersion!.version}"),
                          );
                        },
                      );
                    }
                  });
                },
                appToken: "{{APP_TOKEN}}",
                apiKey:
                    "{{ACCOUNT_APIKEY}}"),
```

## Contact

Email: fedejuret@gmail.com<br>
Website: https://federicojuretich.com<br>
LinkedIn: https://www.linkedin.com/in/federicojuretich/