import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pharmacy_app/core/constants/test_keys.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate/cubit/rate_cubit.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate/cubit/rate_state.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate/widgets/rate_card_widget.dart';
import 'package:pharmacy_app/l10n/app_localizations.dart';
import 'package:pharmacy_app/shared/presentation/widgets/app_text.dart';

// The card calls context.read<RateCubit>() on tap => it needs a cubit above it.
// A mock cubit is enough: we only want to know IF openRateDetails was called.
class MockRateCubit extends MockCubit<RateState> implements RateCubit {}

void main() {
  late MockRateCubit mockCubit;

  // Fake data: values don't matter, I choose them
  const fakeRate = RateEntity(
    id: '1',
    comment: 'very good',
    profilePicture: null,
    reviewerName: 'Maryam',
    reviewerPosition: null,
    reviewerId: null,
    rate: 4,
    revieweeId: null,
    revieweeName: 'Fares',
    createdAt: '2026-07-18T02:15:58',
  );

  setUp(() {
    mockCubit = MockRateCubit();
  });

  // The "room" the widget lives in — same things main_common.dart gives it:
  // ScreenUtil (for .r / .spMin), translations (context.l10n),
  // MaterialApp, and the cubit (context.read<RateCubit>()).
  Widget buildTestable(RateEntity rate) {
    return ScreenUtilInit(
      designSize: const Size(402, 883),
      builder: (_, __) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<RateCubit>.value(
            value: mockCubit,
            child: RateCardWidget(rate: rate),
          ),
        ),
      ),
    );
  }

  group('RateCardWidget', () {
    // Example: just checks the "room" works and the card draws
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(buildTestable(fakeRate));

      expect(find.byType(RateCardWidget), findsOneWidget);
    });

    testWidgets('shows the reviewer name', (tester) async {
      // Arrange: draw the card with my fake data (no Act needed:
      // the data comes in through the constructor, drawing is enough)
      await tester.pumpWidget(buildTestable(fakeRate));

      // the key the widget gives this label: '<TestKeys>_<rate id>'
      final finder = find.byKey(
        Key('${TestKeys.pharmacyRateLabel}_${fakeRate.id}'),
      );

      // Assert step 1: is it on screen? (exactly once)
      expect(finder, findsOneWidget);

      // Assert step 2: does it show the name I gave it in Arrange?
      final textWidget = tester.widget<AppText>(finder);
      expect(textWidget.text, fakeRate.reviewerName);
    });

    //comment
    testWidgets('shows the comment ', (tester) async {
      // Arrange:
      await tester.pumpWidget(buildTestable(fakeRate));

      // the key the widget gives this label: '<TestKeys>_<rate id>'
      final finder = find.byKey(
        Key('${TestKeys.rateDescriptionLabel}_${fakeRate.id}'),
      );

      // Assert step 1: is it on screen? (exactly once)
      expect(finder, findsOneWidget);

      // Assert step 2: does it show the comment I gave it in Arrange?
      final textWidget = tester.widget<AppText>(finder);
      expect(textWidget.text, fakeRate.comment);
    });

    testWidgets('shows 4 stars when rate is 4', (tester) async {
      // Arrange: fakeRate has rate: 4
      await tester.pumpWidget(buildTestable(fakeRate));

      final finder = find.byKey(
        Key('${TestKeys.rateStarsLabel}_${fakeRate.id}'),
      );

      // Assert step 1: is it on screen?
      expect(finder, findsOneWidget);

      // Assert step 2: the twist — the widget does NOT show the number 4.
      // It converts it: List.filled(4, '★').join(' ') => '★ ★ ★ ★'
      // So the expected value is the CONVERTED text, not fakeRate.rate.
      final textWidget = tester.widget<AppText>(finder);
      expect(textWidget.text, '★ ★ ★ ★');
    });

    testWidgets('shows no stars when rate is null', (tester) async {
      // Arrange: a review WITHOUT a rate. rate: null is the reason for this
      // test, so it's created here where the reader can see it.
      const noRate = RateEntity(
        id: '1',
        comment: null,
        profilePicture: null,
        reviewerName: null,
        reviewerPosition: null,
        reviewerId: null,
        rate: null,
        revieweeId: null,
        revieweeName: null,
        // must be a valid date: timeAgo() crashes on null/''
        createdAt: '2026-07-18T02:15:58',
      );
      await tester.pumpWidget(buildTestable(noRate));

      final finder = find.byKey(Key('${TestKeys.rateStarsLabel}_${noRate.id}'));

      // Assert step 1: the label is still there (just empty)
      expect(finder, findsOneWidget);

      // Assert step 2: follow the code =>
      // null ?? 0 => List.filled(0, '★') => [] => [].join(' ') => ''
      final textWidget = tester.widget<AppText>(finder);
      expect(textWidget.text, '');
    });

    //The robot finger taps the card, just like a user would with their finger.
    testWidgets('tapping the card calls openRateDetails', (tester) async {
      // Arrange
      await tester.pumpWidget(buildTestable(fakeRate));

      // Act: this test HAS an Act — the user taps the card
      await tester.tap(
        find.byKey(ValueKey('${TestKeys.rateCardItem}_${fakeRate.id}')),
      );
      await tester.pump(); // redraw after the tap

      // Assert: the card asked the cubit to open THIS review, once.
      // We check the cubit was CALLED — not the navigation itself
      // (navigation is the router's job, tested nowhere here).
      verify(() => mockCubit.openRateDetails(fakeRate)).called(1);
    });
  });
}
