import 'package:flutter/foundation.dart';

import './android_text_theme.dart';
import './ios_text_theme.dart';

var textTheme = defaultTargetPlatform == TargetPlatform.android ? materialTextTheme : cupertinoTextTheme;
