import 'package:clock_store_app/app.dart';
import 'package:clock_store_app/core/di/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await setupDependencies();
  });

  testWidgets('Login page is displayed correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign in to continue to your account.'), findsOneWidget);

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
  });
}
