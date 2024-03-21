import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

FlutterView view = PlatformDispatcher.instance.views.first;

double physicalWidth = view.physicalSize.width;
double physicalHeight = view.physicalSize.height;

double devicePixelRatio = view.devicePixelRatio;

int screenWidth = (physicalWidth / devicePixelRatio).round();
int screenHeight = (physicalHeight / devicePixelRatio).round();
