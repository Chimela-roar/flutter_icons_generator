import 'package:flutter/widgets.dart';

/// To use this class, make sure you declare the font in your
/// project's `pubspec.yaml` file in the `fonts` section. This ensures that
/// the "SecondIcons" font is included in your application. This font is used to
/// display the icons. For example:
/// 
/// flutter:
///   fonts:
///     - family: SecondIcons
///       fonts:
///         - asset: ./assets/icon_fonts/second_icons.otf
class SecondIcons {
 	SecondIcons._();

 	static const _iconFontFamily = 'SecondIcons';

 	static const IconData example3 = IconData(0xe000, fontFamily: _iconFontFamily);
 	static const IconData example4 = IconData(0xe001, fontFamily: _iconFontFamily);
}
