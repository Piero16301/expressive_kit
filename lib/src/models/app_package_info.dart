import 'package:equatable/equatable.dart';

/// {@template app_package_info}
/// Modelo de datos para la información del paquete.
/// {@endtemplate}
class AppPackageInfo extends Equatable {
  /// {@macro app_package_info}
  const AppPackageInfo({
    required this.appName,
    required this.version,
    required this.buildNumber,
    required this.updateTime,
  });

  /// Crea una instancia de [AppPackageInfo] a partir de un [Map].
  factory AppPackageInfo.fromJson(Map<String, dynamic> json) {
    final rawUpdateTime = json['updateTime'];
    final DateTime parsedUpdateTime;
    if (rawUpdateTime is DateTime) {
      parsedUpdateTime = rawUpdateTime;
    } else if (rawUpdateTime is String) {
      parsedUpdateTime = DateTime.tryParse(rawUpdateTime) ?? DateTime.now();
    } else if (rawUpdateTime is int) {
      parsedUpdateTime = DateTime.fromMillisecondsSinceEpoch(rawUpdateTime);
    } else {
      parsedUpdateTime = DateTime.now();
    }

    return AppPackageInfo(
      appName: json['appName'] as String? ?? '',
      version: json['version'] as String? ?? '',
      buildNumber: json['buildNumber'] as String? ?? '',
      updateTime: parsedUpdateTime,
    );
  }

  /// Crea un [Map] a partir de una instancia de [AppPackageInfo].
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'appName': appName,
      'version': version,
      'buildNumber': buildNumber,
      'updateTime': updateTime.toUtc().toIso8601String(),
    };
  }

  /// Crea una copia de este [AppPackageInfo] con los campos actualizados.
  AppPackageInfo copyWith({
    String? appName,
    String? version,
    String? buildNumber,
    DateTime? updateTime,
  }) {
    return AppPackageInfo(
      appName: appName ?? this.appName,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  /// Nombre de la aplicación.
  final String appName;

  /// Versión de la aplicación.
  final String version;

  /// Número de build de la aplicación.
  final String buildNumber;

  /// Fecha de actualización de la aplicación.
  final DateTime updateTime;

  @override
  List<Object> get props => [appName, version, buildNumber, updateTime];
}
