import 'dart:convert';

extension StringToJsonWrapper on String {
  String toErrorJsonString({
    String jsonKey = 'error',
  }) =>
      jsonEncode({jsonKey: this});

  String toDataJsonString({
    String jsonKey = 'data',
  }) =>
      jsonEncode({jsonKey: this});
}
