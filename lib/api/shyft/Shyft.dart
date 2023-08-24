import 'package:ville/api/shyft/ShyftMarket.dart';
import 'package:ville/api/shyft/ShyftToken.dart';
import 'package:ville/api/shyft/ShyftWallet.dart';

class Shyft {
  static final wallet = ShyftWallet();
  static final token = ShyftToken();
  static final market = ShyftMarket();
}