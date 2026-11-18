// Regression test for theme-aware text contrast in the login flow.
//
// Covers the two reported bugs for every theme the app offers:
//  - snackbar text must contrast with the snackbar background;
//  - edit text (CommonTextField) must contrast with the screen surface.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stockholding/core/theam/app_fonts.dart';
import 'package:stockholding/core/theam/app_theme.dart';
import 'package:stockholding/core/theam/app_theme_type.dart';
import 'package:stockholding/core/widgets/CommanWidgets.dart';

void main() {
  for (final type in AppThemeType.values) {
    testWidgets('${type.name} theme: snackbar and edit text contrast', (
      WidgetTester tester,
    ) async {
      final theme = AppTheme.fromType(type);

      // (c) the snackbar background comes from the theme's ColorScheme.
      expect(
        theme.snackBarTheme.backgroundColor,
        theme.colorScheme.inverseSurface,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Builder(
              builder: (context) => Column(
                children: [
                  // As OtpScreen now builds it: no explicit color.
                  const CommonTextField(
                    focus: false,
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    fontFamily: AppFonts.fontName,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: CommonText(
                              'something went wrong',
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              fontFamily: AppFonts.fontName,
                            ),
                          ),
                        ),
                    child: const Text('show'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // (b) edit text follows the theme's text color.
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.style!.color, theme.colorScheme.onSurface);

      await tester.tap(find.text('show'));
      await tester.pumpAndSettle();

      // (a) snackbar text contrasts with the snackbar background.
      final snackText = tester.widget<Text>(find.text('something went wrong'));
      expect(snackText.style!.color, theme.colorScheme.onInverseSurface);
      expect(
        snackText.style!.color,
        isNot(theme.snackBarTheme.backgroundColor),
      );
    });
  }
}
