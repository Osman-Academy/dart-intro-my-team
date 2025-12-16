import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

Future<http.Response> checkConnectivity() async {
  final uri = Uri.parse('https://dummyjson.com/test');
  return await http.get(uri);
}

void main() {
  group('Connectivity Test', () {
    testWidgets('Can successfully connect to dummyjson.com endpoint', (WidgetTester tester) async {
      final response = await checkConnectivity();
      expect(response.statusCode, 200,
          reason: 'Expected a 200 OK response, but got ${response.statusCode}');
      expect(response.body, isNotEmpty);
      expect(response.body, contains('"status":"ok"'));
      await tester.pumpWidget(const MaterialApp(home: Text('Connectivity OK')));
      expect(find.text('Connectivity OK'), findsOneWidget);
    });
  });
}