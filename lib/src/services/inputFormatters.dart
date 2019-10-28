import 'package:flutter/services.dart';

final doubleFormatter =
    WhitelistingTextInputFormatter(RegExp(r'^\d*\.?\d*$'));
