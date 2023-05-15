import 'package:design_tokens_builder/utils/token_set_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Get token sets', () {
    test('succeeds', () {
      final result = getTokenSets({
        '\$metadata': {
          'tokenSetOrder': ['global', 'light', 'dark'],
        },
      });

      expect(result, ['light', 'dark']);
    });

    test('succeeds without default theme', () {
      final result = getTokenSets({
        '\$metadata': {
          'tokenSetOrder': ['light', 'dark'],
        },
      });

      expect(result, ['light', 'dark']);
    });
  });

  group('Override and merge token set', () {
    test('works properly', () {
      final result = overrideAndMergeTokenSet({
        'key1': 'value1',
        'key2': 'value2',
      }, withSet: {
        'key2': 'newValue2',
        'key3': 'value3',
      });

      expect(result, {
        'key1': 'value1',
        'key2': 'newValue2',
        'key3': 'value3',
      });
    });
  });

  group('Has nested type', () {
    test('succeeds', () {
      final result = hasNestedType(
        const MapEntry(
          'display',
          {
            'small': {
              '1': {
                'type': 'someType',
              },
            },
          },
        ),
        type: 'someType',
      );

      expect(result, true);
    });

    test('fails', () {
      final result = hasNestedType(
        const MapEntry(
          'display',
          {
            'type': 'otherType',
          },
        ),
        type: 'someType',
      );

      expect(result, false);
    });
  });

  group('Get tokens of type', () {
    test('succeeds', () {
      final result = getTokensOfType('someType', tokenSetData: {
        'small': {'value': 'Some value', 'type': 'someType'},
        'medium': {'value': 'Some value', 'type': 'someType 3'},
        'display': {
          'large': {'value': 'Some value', 'type': 'someType'}
        },
      });

      expect(result, {
        'small': {'value': 'Some value', 'type': 'someType'},
        'display': {
          'large': {'value': 'Some value', 'type': 'someType'}
        },
      });
    });

    test('succeeds with fallback', () {
      final result = getTokensOfType('someType', tokenSetData: {
        'small': {'value': 'Some value', 'type': 'someType'},
        'medium': {'value': 'Some value', 'type': 'someType 3'},
        'display': {
          'large': {'value': 'Some value', 'type': 'someType'}
        },
      }, fallbackSetData: {
        'small': {'value': 'Some new value', 'type': 'someType'},
        'large': {'value': 'Some value', 'type': 'someType'},
      });

      expect(result, {
        'small': {'value': 'Some new value', 'type': 'someType'},
        'large': {'value': 'Some value', 'type': 'someType'},
        'display': {
          'large': {'value': 'Some value', 'type': 'someType'}
        },
      });
    });
  });
}
