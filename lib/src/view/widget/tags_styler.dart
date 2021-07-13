// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//Models
import 'package:flutter/material.dart';

///[TagsStyler] allows you to design the exact style you want for your tag by using its properties. It must not be [null]

class TagsStyler {
  ///[tagPadding] allows you to apply padding inside tag
  final EdgeInsets tagPadding;

  ///[tagMargin] allows you to apply margin inside tag
  final EdgeInsets tagMargin;

  ///[tagMargin] apply decoration to the container containing the tag. Should specify the color to set tag color, otherwise its white by default
  final BoxDecoration tagDecoration;

  ///[tagTextStyle] style the text inside tag
  final TextStyle? tagTextStyle;

  /// Styles the padding of the tag text
  final EdgeInsets tagTextPadding;

  /// Styles the padding of the tag cancel icon
  final EdgeInsets tagCancelIconPadding;

  ///[tagCancelIcon] apply your own icon, if you want, to delete the icon
  final Widget tagCancelIcon;

  ///Enable or disable the # prefix icon
  final bool showHashtag;

  TagsStyler({
    this.tagTextPadding = const EdgeInsets.all(0.0),
    this.tagCancelIconPadding = const EdgeInsets.only(left: 1.0),
    this.tagPadding = const EdgeInsets.all(4.0),
    this.tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
    this.tagDecoration =
        const BoxDecoration(color: Color.fromARGB(255, 74, 137, 92)),
    this.tagTextStyle,
    this.showHashtag = false,
    this.tagCancelIcon = const Icon(
      Icons.cancel,
      size: 18.0,
      color: Colors.green,
    ),
  });
}
