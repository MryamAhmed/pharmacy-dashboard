// Project imports:
import 'flavors.dart';
import 'main_common.dart';

/// Default entrypoint (used by `flutter run` with no `--target`).
///
/// Mirrors `main_dev.dart` so running without an explicit flavor target
/// still boots the real app (DI, router, theming, localization) instead of
/// the Flutter-generated placeholder.
Future<void> main() async {
  Flavor.appFlavor = AppFlavor.dev;
  await mainCommon();
}
