import 'package:flutter/widgets.dart';

/// To use this class, make sure you declare the font in your
/// project's `pubspec.yaml` file in the `fonts` section. This ensures that
/// the "FirstIcons" font is included in your application. This font is used to
/// display the icons. For example:
/// 
/// flutter:
///   fonts:
///     - family: FirstIcons
///       fonts:
///         - asset: ./assets/icon_fonts/first_icons.otf
class FirstIcons {
 	FirstIcons._();

 	static const _iconFontFamily = 'FirstIcons';

 	static const IconData example1 = IconData(0xe000, fontFamily: _iconFontFamily);
 	static const IconData example2 = IconData(0xe001, fontFamily: _iconFontFamily);
}
