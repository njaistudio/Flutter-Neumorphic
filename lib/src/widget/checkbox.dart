import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/widget/container.dart';

import '../NeumorphicBoxShape.dart';

import '../theme/neumorphic_theme.dart';
import 'button.dart';

typedef void NeumorphicCheckboxListener<T>(T value);

/// A Style used to customize a NeumorphicCheckbox
///
/// selectedDepth : the depth when checked
/// unselectedDepth : the depth when unchecked (default : theme.depth)
/// selectedColor : the color when checked (default: theme.accent)
///
class NeumorphicCheckboxStyle {
  final double selectedDepth;
  final double unselectedDepth;
  final double selectedIntensity;
  final double unselectedIntensity;
  final Color selectedColor;
  final Color disabledColor;

  const NeumorphicCheckboxStyle({
    this.selectedDepth,
    this.selectedColor,
    this.unselectedDepth,
    this.disabledColor,
    this.selectedIntensity = 1,
    this.unselectedIntensity = 0.7,
  });
}

/// A Neumorphic Checkbox
///
/// takes a NeumorphicCheckboxStyle as `style`
/// takes the current checked state as `value`
///
/// notifies the parent when user interact with this widget with `onChanged`
///
/// ```
///  bool check1 = false;
///  bool check2 = false;
///  bool check3 = false;
///
///  Widget _buildChecks() {
///    return Row(
///      children: <Widget>[
///
///        NeumorphicCheckbox(
///          value: check1,
///          onChanged: (value) {
///            setState(() {
///              check1 = value;
///            });
///          },
///        ),
///
///        NeumorphicCheckbox(
///          value: check2,
///          onChanged: (value) {
///            setState(() {
///              check2 = value;
///            });
///          },
///        ),
///
///        NeumorphicCheckbox(
///          value: check3,
///          onChanged: (value) {
///            setState(() {
///              check3 = value;
///            });
///          },
///        ),
///
///      ],
///    );
///  }
/// ```
///
@immutable
class NeumorphicCheckbox extends StatelessWidget {
  final bool value;
  final NeumorphicCheckboxStyle style;
  final NeumorphicCheckboxListener onChanged;
  final isEnabled;
  final EdgeInsets padding;
  final EdgeInsets margin;

  NeumorphicCheckbox({
    this.style = const NeumorphicCheckboxStyle(),
    @required this.value,
    @required this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.margin = const EdgeInsets.all(0),
    this.isEnabled = true,
  });

  bool get isSelected => this.value;

  void _onClick() {
    this.onChanged(!this.value);
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    final selectedColor = this.style.selectedColor ?? theme.accentColor;

    final double selectedDepth =
        -1 * (this.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        (this.style.unselectedDepth ?? theme.depth).abs();
    final double selectedIntensity =
        (this.style.selectedIntensity ?? theme.intensity)
            .abs()
            .clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);
    final double unselectedIntensity = this.style.unselectedIntensity
        .clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!this.isEnabled) {
      depth = 0;
    }

    Color color = isSelected ? selectedColor : null;
    if (!this.isEnabled) {
      color = null;
    }

    Color iconColor = isSelected ? theme.baseColor : selectedColor;
    if (!this.isEnabled) {
      iconColor = theme.disabledColor;
    }

    return NeumorphicButton(
      padding: this.padding,
      pressed: isSelected,
      margin: this.margin,
      onClick: () {
        if (this.isEnabled) {
          _onClick();
        }
      },
      drawSurfaceAboveChild: true,
      minDistance: selectedDepth.abs(),
      boxShape: NeumorphicBoxShape.roundRect(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        material.Icons.check,
        color: iconColor,
        size: 20.0,
      ),
      style: NeumorphicStyle(
        color: color,
        depth: depth,
        intensity: isSelected ? selectedIntensity : unselectedIntensity,
        shape: NeumorphicShape.flat,
      ),
    );
  }
}
