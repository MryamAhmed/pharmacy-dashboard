import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';
import 'package:pharmacy_app/features/home/domain/repositories/rate_repository.dart';
import 'package:pharmacy_app/features/home/domain/usecases/get_rates_usecase.dart';
import 'package:pharmacy_app/shared/domain/entities/app_error.dart';

//That one line gives you an object that looks like a RateRepository, but does nothing until you tell it what to return.
class MockRateRepository extends Mock implements RateRepository {}

void main() {
  //Question: what does this class do? It only asks the repository and returns its answer. So the test checks:
  //✅ when the repo returns success → the use case returns the same success
  //❌ when the repo returns an error → the use case returns the same error

  late MockRateRepository mockRepo;
  late GetRatesUseCase useCase;

  setUp(() {
    mockRepo = MockRateRepository(); // new fake repo
    useCase = GetRatesUseCase(mockRepo);
  });

  test('returns rates when repository succeeds', () async {
    //arrange
    final fakeRates = [
      const RateEntity(
        id: '1',
        comment: 'comment',
        profilePicture: 'empty',
        reviewerName: 'Maryam',
        reviewerPosition: 'Ahmed',
        reviewerId: '2',
        rate: null,
        revieweeId: '3',
        revieweeName: 'Fares',
        createdAt: 'empty',
      ),
    ];
    //Read it as: "When someone calls getRates() on the fake repo, answer with success containing fakeRates."
    when(() => mockRepo.getRates()).thenAnswer((_) async => Right(fakeRates));

    //act  "what actually happen"
    final result = await useCase.call();

    //assert
    expect(result, Right(fakeRates));
    verify(() => mockRepo.getRates()).called(1);
  });

  test('returns error when repository fails', () async {
    //arrange
    const fakeError = AppError(message: 'Server error', statusCode: 500);

    when(
      () => mockRepo.getRates(),
    ).thenAnswer((_) async => const Left(fakeError));

    //act  "what actually happen"
    final resultOfLeft = await useCase.call();

    //assert
    expect(resultOfLeft, const Left(fakeError));
    verify(() => mockRepo.getRates()).called(1);
  });
}
