import 'package:integration_test/integration_test.dart';
import 'connectivity_test.dart' as tests;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  tests.main();
}