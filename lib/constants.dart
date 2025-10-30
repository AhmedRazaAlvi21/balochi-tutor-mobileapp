import 'package:hive/hive.dart';

final logininfo = Hive.box('logininfo');

final videoStateBox = Hive.box('videoState');
final apiKey = logininfo.get('sKey');
// const String stripeSecretKey =
//     "sk_test_51QecG2QAxyJqOWkUPDnHBJ96klCszL7hSMxYxB9xG7xmI2DUZILilWCh6BM0lVS5PPVjNUr5d9yMP9f9e9w9LepX00xLlGy49H";
// const String stripePublishableKey =
//     "pk_test_51QecG2QAxyJqOWkUgTXRkgL2PdzeG4BJ8s9EVMTzMExe0oB20H2PsMKIq7iT5pfT1HOUrkr9OBWng34WYeIrvGGn00IOF1DJ8j";
