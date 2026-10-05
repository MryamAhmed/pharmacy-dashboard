import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pharmacy_app/core/enums/rate_rating_filter.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';
import 'package:pharmacy_app/features/home/domain/usecases/get_rates_usecase.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate/cubit/rate_cubit.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate/cubit/rate_state.dart';
import 'package:pharmacy_app/shared/domain/entities/app_error.dart';

// The cubit's 2 dependencies (see its constructor) => we need a mock for each
class MockGetRatesUseCase extends Mock implements GetRatesUseCase {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  //what the cubit do ? call usecase  => we need mock from usecase
  late MockGetRatesUseCase mockGetRatesUseCase;
  late MockGoRouter mockGoRouter;

  // Fake data shared by all tests (same idea as before: values don't matter)
  final fakeRates = [
    const RateEntity(
      id: '1',
      comment: 'comment',
      profilePicture: 'empty',
      reviewerName: 'Maryam',
      reviewerPosition: 'Ahmed',
      reviewerId: '2',
      rate: 5,
      revieweeId: '3',
      revieweeName: 'Fares',
      createdAt: 'empty',
    ),
  ];
  const fakeError = AppError(message: 'Server error', statusCode: 500);

  setUp(() {
    mockGetRatesUseCase = MockGetRatesUseCase();
    mockGoRouter = MockGoRouter();
    // Don't create the RateCubit here: its constructor calls the use case
    // immediately (_load), so the mock must be stubbed with `when` FIRST.
    // Each test creates the cubit itself, after stubbing.
  });

  group('RateCubit', () {
    test('initial state is loading with no rates', () {
      //arrange
      when(() => mockGetRatesUseCase()).thenAnswer((_) async => Right(fakeRates));

      //act: create the cubit, then read its state right away (before _load finishes)
      final cubit = RateCubit(mockGetRatesUseCase, mockGoRouter);

      //assert: the default RateState => isLoading: true, rates: [], filter: all
      expect(cubit.state, const RateState());

      // always close a cubit you created yourself
      cubit.close();
    });

    // blocTest = a test made for cubits/blocs:
    //   build:  create the cubit (stub the mocks first!)
    //   act:    call a cubit method (optional)
    //   expect: the LIST of states the cubit emitted, in order
    //   verify: extra checks after it finishes (optional)
    blocTest<RateCubit, RateState>(
      'emits loaded rates when use case succeeds',
      build: () {
        when(() => mockGetRatesUseCase()).thenAnswer((_) async => Right(fakeRates));
        return RateCubit(mockGetRatesUseCase, mockGoRouter); //?
      },
      // no act: the constructor already calls _load()
      expect: () => [
        RateState(isLoading: false, rates: fakeRates),
      ],
      verify: (_) => verify(() => mockGetRatesUseCase()).called(1),
    );

    blocTest<RateCubit, RateState>(
      'emits error when use case fails',
      build: () {
        when(() => mockGetRatesUseCase()).thenAnswer((_) async => const Left(fakeError));
        return RateCubit(mockGetRatesUseCase, mockGoRouter);
      },
      expect: () => [
        const RateState(isLoading: false, error: fakeError),
      ],
    );

    blocTest<RateCubit, RateState>(
      'emits new selectedFilter when selectFilter is called',
      build: () {
        when(() => mockGetRatesUseCase()).thenAnswer((_) async => Right(fakeRates));
        return RateCubit(mockGetRatesUseCase, mockGoRouter);
      },
      act: (cubit) async {
        // wait for _load() to finish first, so the states come in a clear order
        await Future<void>.delayed(Duration.zero);
        cubit.selectFilter(RateRatingFilter.five);
      },
      expect: () => [
        // 1. from _load()
        RateState(isLoading: false, rates: fakeRates),
        // 2. from selectFilter() — same state, only the filter changed
        RateState(
          isLoading: false,
          rates: fakeRates,
          selectedFilter: RateRatingFilter.five,
        ),
      ],
    );
  });
}
