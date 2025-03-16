import 'package:flutter/foundation.dart';
import 'package:potential/components/themes/android_text_theme.dart';
import 'package:potential/components/themes/ios_text_theme.dart';

final textTheme = defaultTargetPlatform == TargetPlatform.android ? materialTextTheme : cupertinoTextTheme;
