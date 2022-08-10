// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class AppButtonStyle {
  /// プライマリカラー背景に白文字のボタンスタイル。OK ボタンなど。
  static ButtonStyle primary = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(ThemeData().primaryColor),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
  );

  /// プライマリカラー背景に白文字の文字・余白小さめのボタンスタイル。
  static ButtonStyle primarySmall = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white, fontSize: 12),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(ThemeData().primaryColor),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  /// グレー背景に白文字のボタンスタイル。キャンセルボタンなど。
  static ButtonStyle secondary = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(ThemeData().disabledColor),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
  );

  /// グレー背景に白文字の余白小さめのボタンスタイル。
  static ButtonStyle secondarySmall = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white, fontSize: 12),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(ThemeData().primaryColor),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  /// 白背景にグレー文字・枠線ありのボタンスタイル。
  static ButtonStyle white = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.black54),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(color: Colors.black26),
    ),
  );

  /// 白背景にグレー文字・枠線ありの余白小さめのボタンスタイル
  static ButtonStyle whiteSmall = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.black54),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(color: Colors.black26),
    ),
    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  /// 背景なしのフォントサイズ小さめ、余白小さめ。
  static ButtonStyle primaryTextSmall = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 12)),
    padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  /// 背景なしのフォントサイズ小さめ、余白なし
  static ButtonStyle primaryTextSmallWithoutPadding = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 12)),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  /// 背景なしのフォントサイズ小さめ、余白小さめ。
  static ButtonStyle secondaryTextSmall = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 12)),
    foregroundColor: MaterialStateProperty.all(ThemeData().disabledColor),
    padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  /// 背景なしのフォントサイズ小さめ、余白なし
  static ButtonStyle secondaryTextSmallWithoutPadding = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 12)),
    foregroundColor: MaterialStateProperty.all(ThemeData().disabledColor),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    minimumSize: MaterialStateProperty.all(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
