import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN use Dropdown Alert', () {
    testWidgets(
        'WHEN open screen, THEN should render basic successfully',
        (WidgetTester tester) async {
      // Given
      final sut = MaterialApp(
        home: Scaffold(
          body: const Text('test'),
        ),
        builder: (context, child) {
          return Stack(
            children: [
              const DropdownAlert(),
              child!,
            ],
          );
        },
      );

      // When
      await tester.pumpWidget(sut);

      // workaround here
      // AlertController.show(
      //   'dummy for init timer',
      //   'message',
      //   TypeAlert.warning,
      //   {},
      // );
      // AlertController.show(
      //   'dummy for init timer',
      //   'message',
      //   TypeAlert.warning,
      //   {},
      // );
      await tester.pumpAndSettle();
      // Then
    });
  });
}
