import 'package:equatable/equatable.dart';

/// {@template app_device_info}
/// Modelo de datos para la información del dispositivo.
/// {@endtemplate}
class AppDeviceInfo extends Equatable {
  /// {@macro app_device_info}
  const AppDeviceInfo({
    required this.id,
    this.versionRelease,
    this.sdkInt,
    this.securityPatch,
    this.model,
    this.brand,
    this.isLowRamDevice,
    this.isPhysicalDevice,
    this.processor,
    this.physicalRamSize,
    this.availableRamSize,
  });

  /// Crea una instancia de [AppDeviceInfo] a partir de un [Map].
  factory AppDeviceInfo.fromJson(Map<String, dynamic> json) {
    return AppDeviceInfo(
      id: json['id'] as String? ?? '',
      versionRelease: json['versionRelease'] as String?,
      sdkInt: (json['sdkInt'] as num?)?.toInt(),
      securityPatch: json['securityPatch'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      isLowRamDevice: json['isLowRamDevice'] as bool?,
      isPhysicalDevice: json['isPhysicalDevice'] as bool?,
      processor: json['processor'] as String?,
      physicalRamSize: (json['physicalRamSize'] as num?)?.toInt(),
      availableRamSize: (json['availableRamSize'] as num?)?.toInt(),
    );
  }

  /// Crea un [Map] a partir de una instancia de [AppDeviceInfo].
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'versionRelease': versionRelease,
      'sdkInt': sdkInt,
      'securityPatch': securityPatch,
      'model': model,
      'brand': brand,
      'isLowRamDevice': isLowRamDevice,
      'isPhysicalDevice': isPhysicalDevice,
      'processor': processor,
      'physicalRamSize': physicalRamSize,
      'availableRamSize': availableRamSize,
    };
  }

  /// Crea una copia de este [AppDeviceInfo] con los campos actualizados.
  AppDeviceInfo copyWith({
    String? id,
    String? versionRelease,
    int? sdkInt,
    String? securityPatch,
    String? model,
    String? brand,
    bool? isLowRamDevice,
    bool? isPhysicalDevice,
    String? processor,
    int? physicalRamSize,
    int? availableRamSize,
  }) {
    return AppDeviceInfo(
      id: id ?? this.id,
      versionRelease: versionRelease ?? this.versionRelease,
      sdkInt: sdkInt ?? this.sdkInt,
      securityPatch: securityPatch ?? this.securityPatch,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      isLowRamDevice: isLowRamDevice ?? this.isLowRamDevice,
      isPhysicalDevice: isPhysicalDevice ?? this.isPhysicalDevice,
      processor: processor ?? this.processor,
      physicalRamSize: physicalRamSize ?? this.physicalRamSize,
      availableRamSize: availableRamSize ?? this.availableRamSize,
    );
  }

  /// ID único del dispositivo.
  final String id;

  /// Versión de Android u OS.
  final String? versionRelease;

  /// Nivel de API de Android.
  final int? sdkInt;

  /// Parche de seguridad de Android.
  final String? securityPatch;

  /// Modelo del dispositivo.
  final String? model;

  /// Marca del dispositivo.
  final String? brand;

  /// Indica si el dispositivo es de gama baja.
  final bool? isLowRamDevice;

  /// Indica si el dispositivo es físico.
  final bool? isPhysicalDevice;

  /// Procesador del dispositivo.
  final String? processor;

  /// Tamaño de la memoria RAM física del dispositivo.
  final int? physicalRamSize;

  /// Tamaño de la memoria RAM disponible del dispositivo.
  final int? availableRamSize;

  @override
  List<Object?> get props => [
    id,
    versionRelease,
    sdkInt,
    securityPatch,
    model,
    brand,
    isLowRamDevice,
    isPhysicalDevice,
    processor,
    physicalRamSize,
    availableRamSize,
  ];
}
