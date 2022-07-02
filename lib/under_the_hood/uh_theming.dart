// ignore_for_file: curly_braces_in_flow_control_structures

import '../dependencies.dart';
import 'package:flutter/scheduler.dart';

// @static
mixin ColorTheming {
  static void switchThemeModeTo(ThemeMode tm) {
    switch (tm) {
      case ThemeMode.dark:
        _animationController.forward();
        _systemTheme = false;
        break;
      case ThemeMode.light:
        _animationController.reverse();
        _systemTheme = false;
        break;
      case ThemeMode.system:
        _changePalletToSystem();
        break;
    }
  }

  static void _changePalletToSystem() {
    if (_window.platformBrightness == Brightness.light)
      _animationController.reverse();
    else
      _animationController.forward();
    _systemTheme = true;
  }

  static tween({required Color light, required Color dark}) {
    _listOfTweens.add(ColorTween(begin: light, end: dark));
    return _listOfTweens.last.animate(_animationController).value!;
  }

  static final List<ColorTween> _listOfTweens = [];
  static final _animationController = AnimationController(
    vsync: _TickerController(),
  );
  static bool _systemTheme = false;

  static final _window = WidgetsBinding.instance.window;
}

class _TickerController extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class ThemeBuilder extends StatelessWidget {
  /// Set a duration of an animation
  final Duration duration;
  final TransitionBuilder builder;

  /// The child widget to pass to the [builder].
  ///
  /// If a [builder] callback's return value contains a subtree that does not depend on the animation, it's more efficient to build that subtree once instead of rebuilding it on every animation tick.
  ///
  /// If the pre-built subtree is passed as the [child] parameter, the [ThemeBuilder] will pass it back to the [builder] function so that it can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve performance significantly in some cases and is therefore a good practice.
  final Widget? child;
  ThemeBuilder(
      {required this.builder,
      this.child,
      Key? key,
      this.duration = const Duration(milliseconds: 200)})
      : super(key: key) {
    ColorTheming._window.onPlatformBrightnessChanged = () {
      if (ColorTheming._systemTheme) {
        ColorTheming._changePalletToSystem();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ColorTheming._animationController..duration = duration,
      builder: builder,
      child: child,
    );
  }
}
