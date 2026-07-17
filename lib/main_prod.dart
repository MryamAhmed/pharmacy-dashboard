// Project imports:
import 'flavors.dart';
import 'main_common.dart';

Future<void> main() async {
  Flavor.appFlavor = AppFlavor.prod;
  await mainCommon();
}
