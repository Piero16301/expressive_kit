import 'package:expressive_kit/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppPackageInfo', () {
    final updateTime = DateTime.utc(2026, 10, 24, 12, 30, 0);

    final packageInfo = AppPackageInfo(
      appName: 'Expressive Showcase',
      version: '1.2.0',
      buildNumber: '42',
      updateTime: updateTime,
    );

    test('supports value equality via Equatable', () {
      final same = AppPackageInfo(
        appName: 'Expressive Showcase',
        version: '1.2.0',
        buildNumber: '42',
        updateTime: updateTime,
      );

      final different = AppPackageInfo(
        appName: 'Expressive Showcase',
        version: '1.2.1',
        buildNumber: '43',
        updateTime: updateTime,
      );

      expect(packageInfo, equals(same));
      expect(packageInfo == different, isFalse);
      expect(packageInfo.props, [
        'Expressive Showcase',
        '1.2.0',
        '42',
        updateTime,
      ]);
    });

    test('toJson returns correct map representation with ISO 8601 string', () {
      final json = packageInfo.toJson();

      expect(json, {
        'appName': 'Expressive Showcase',
        'version': '1.2.0',
        'buildNumber': '42',
        'updateTime': '2026-10-24T12:30:00.000Z',
      });
    });

    test('fromJson reconstructs instance correctly from ISO string', () {
      final json = {
        'appName': 'Expressive Showcase',
        'version': '1.2.0',
        'buildNumber': '42',
        'updateTime': '2026-10-24T12:30:00.000Z',
      };

      final parsed = AppPackageInfo.fromJson(json);

      expect(parsed, equals(packageInfo));
    });

    test('fromJson parses DateTime object directly', () {
      final json = {
        'appName': 'Expressive Showcase',
        'version': '1.2.0',
        'buildNumber': '42',
        'updateTime': updateTime,
      };

      final parsed = AppPackageInfo.fromJson(json);

      expect(parsed, equals(packageInfo));
    });

    test('fromJson parses milliseconds integer timestamp', () {
      final json = {
        'appName': 'Expressive Showcase',
        'version': '1.2.0',
        'buildNumber': '42',
        'updateTime': updateTime.millisecondsSinceEpoch,
      };

      final parsed = AppPackageInfo.fromJson(json);

      expect(
        parsed.updateTime.millisecondsSinceEpoch,
        updateTime.millisecondsSinceEpoch,
      );
    });

    test(
      'fromJson handles fallback when fields or updateTime are invalid or missing',
      () {
        final parsed = AppPackageInfo.fromJson(const {
          'updateTime': 'invalid-date-string',
        });

        expect(parsed.appName, '');
        expect(parsed.version, '');
        expect(parsed.buildNumber, '');
        expect(parsed.updateTime, isA<DateTime>());

        final parsedNullDate = AppPackageInfo.fromJson(const {});
        expect(parsedNullDate.updateTime, isA<DateTime>());
      },
    );

    test('copyWith updates specified fields and preserves others', () {
      final newTime = DateTime.utc(2026, 11, 1);
      final updated = packageInfo.copyWith(
        version: '1.3.0',
        updateTime: newTime,
      );

      expect(updated.appName, 'Expressive Showcase');
      expect(updated.version, '1.3.0');
      expect(updated.buildNumber, '42');
      expect(updated.updateTime, newTime);

      final unmodified = packageInfo.copyWith();
      expect(unmodified, equals(packageInfo));
    });
  });
}
