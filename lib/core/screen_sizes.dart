import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

FlutterView view = PlatformDispatcher.instance.views.first;

double physicalWidth = view.physicalSize.height > view.physicalSize.width ? view.physicalSize.width : view.physicalSize.height;
double physicalHeight = view.physicalSize.height > view.physicalSize.width ? view.physicalSize.height : view.physicalSize.width;

double devicePixelRatio = view.devicePixelRatio;

int screenWidth = (physicalWidth / devicePixelRatio).round();
int screenHeight = (physicalHeight / devicePixelRatio).round();
