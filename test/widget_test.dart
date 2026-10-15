import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neobrutalist_resume/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Renders Neobrutalist Resume screen and loads sections',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const NeobrutalistResumeApp());

    // Advance async data loader
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // Verify presence of core sections
    expect(find.text('EXPERIENCE'), findsOneWidget);
    expect(find.text('EDUCATION'), findsOneWidget);
    expect(find.text('CERTIFICATIONS'), findsOneWidget);

    // Verify presence of toolbar
    expect(find.text('🖨️ Print / PDF'), findsOneWidget);
  });
}
