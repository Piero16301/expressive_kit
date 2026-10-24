import 'package:expressive_kit/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDeviceInfo', () {
    const fullDeviceInfo = AppDeviceInfo(
      id: 'device_123',
      versionRelease: '14',
      sdkInt: 34,
      securityPatch: '2026-10-01',
      model: 'Pixel 9 Pro',
      brand: 'Google',
      isLowRamDevice: false,
      isPhysicalDevice: true,
      processor: 'Tensor G4',
      physicalRamSize: 17179869184,
      availableRamSize: 8589934592,
    );

    test('supports value equality via Equatable', () {
      const anotherSame = AppDeviceInfo(
        id: 'device_123',
        versionRelease: '14',
        sdkInt: 34,
        securityPatch: '2026-10-01',
        model: 'Pixel 9 Pro',
        brand: 'Google',
        isLowRamDevice: false,
        isPhysicalDevice: true,
        processor: 'Tensor G4',
        physicalRamSize: 17179869184,
        availableRamSize: 8589934592,
      );

      const differentDevice = AppDeviceInfo(
        id: 'device_456',
        versionRelease: '13',
      );

      expect(fullDeviceInfo, equals(anotherSame));
      expect(fullDeviceInfo == differentDevice, isFalse);
      expect(
        fullDeviceInfo.props,
        containsAll([
          'device_123',
          '14',
          34,
          '2026-10-01',
          'Pixel 9 Pro',
          'Google',
          false,
          true,
          'Tensor G4',
          17179869184,
          8589934592,
        ]),
      );
    });

    test('toJson returns correct map representation', () {
      final json = fullDeviceInfo.toJson();

      expect(json, {
        'id': 'device_123',
        'versionRelease': '14',
        'sdkInt': 34,
        'securityPatch': '2026-10-01',
        'model': 'Pixel 9 Pro',
        'brand': 'Google',
        'isLowRamDevice': false,
        'isPhysicalDevice': true,
        'processor': 'Tensor G4',
        'physicalRamSize': 17179869184,
        'availableRamSize': 8589934592,
      });
    });

    test('fromJson reconstructs instance correctly from complete map', () {
      final json = {
        'id': 'device_123',
        'versionRelease': '14',
        'sdkInt': 34,
        'securityPatch': '2026-10-01',
        'model': 'Pixel 9 Pro',
        'brand': 'Google',
        'isLowRamDevice': false,
        'isPhysicalDevice': true,
        'processor': 'Tensor G4',
        'physicalRamSize': 17179869184,
        'availableRamSize': 8589934592,
      };

      final parsed = AppDeviceInfo.fromJson(json);

      expect(parsed, equals(fullDeviceInfo));
    });

    test('fromJson handles minimal and null values gracefully', () {
      final parsed = AppDeviceInfo.fromJson(const {'id': 'device_min'});

      expect(parsed.id, 'device_min');
      expect(parsed.versionRelease, isNull);
      expect(parsed.sdkInt, isNull);
      expect(parsed.securityPatch, isNull);
      expect(parsed.model, isNull);
      expect(parsed.brand, isNull);
      expect(parsed.isLowRamDevice, isNull);
      expect(parsed.isPhysicalDevice, isNull);
      expect(parsed.processor, isNull);
      expect(parsed.physicalRamSize, isNull);
      expect(parsed.availableRamSize, isNull);
    });

    test('fromJson handles empty map fallback for id', () {
      final parsed = AppDeviceInfo.fromJson(const {});
      expect(parsed.id, '');
    });

    test('copyWith updates specified fields and preserves others', () {
      final updated = fullDeviceInfo.copyWith(
        model: 'Pixel 10 Pro',
        sdkInt: 35,
        isLowRamDevice: true,
      );

      expect(updated.id, 'device_123');
      expect(updated.model, 'Pixel 10 Pro');
      expect(updated.sdkInt, 35);
      expect(updated.isLowRamDevice, true);
      expect(updated.brand, 'Google');
      expect(updated.processor, 'Tensor G4');

      final unmodified = fullDeviceInfo.copyWith();
      expect(unmodified, equals(fullDeviceInfo));
    });
  });
}
