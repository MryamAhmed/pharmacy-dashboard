import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pharmacy_app/core/constants/test_keys.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate/widgets/text_avatar_widget.dart';

void main() {
  testWidgets('shows the title text', (tester) async {
    // Arrange: draw the widget on the fake screen
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 883),
        builder: (_, __) =>
            const MaterialApp(home: TextAvatarWidget(title: 'tt')),
      ),
    );
    // Assert: is the text widget on the screen?
    expect(find.byKey(const Key(TestKeys.textAvatarLabel)), findsOneWidget);
  });
}
