import 'package:mocktail/mocktail.dart';
import 'package:pharmacy_app/shared/presentation/cubit/general_cubit.dart';

/// Mock of the app-wide session cubit, for cubits/widgets that depend on it.
class MockGeneralCubit extends Mock implements GeneralCubit {}
