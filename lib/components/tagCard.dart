import 'package:birdle/bloc/theme/theme_bloc.dart';
import 'package:birdle/bloc/theme/theme_state.dart';
import 'package:birdle/utils/theme/customThemes/buttonTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagCard extends ConsumerWidget {
  final String tag;
  final Color? color;
  final Function()? onPressed;
  final String id;
  final String selectedTagId;
  final Function(String id)? onTagPressed;

  TagCard({
    required this.tag,
    this.color,
    this.onPressed,
    required this.id,
    required this.selectedTagId,
    this.onTagPressed,
  });

  late Color clr = color ?? Color(0xFFD3D3D3);
  late HSLColor hsl = HSLColor.fromColor(clr);
  late double newLightness = (hsl.lightness + 0.3).clamp(0.0, 1.0);
  late Color newColor = hsl.withLightness(newLightness).toColor();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final appTheme = themeState.theme;
        return TextButton(
          key: Key(id),
          onPressed: () {
            onTagPressed?.call(id);
          },
          style: TButtonTheme.transparentTextButton(appTheme).copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 6),
            ),
          ),
          child: Container(
            key: UniqueKey(),
            decoration: BoxDecoration(
              color: color != null
                  ? newColor
                  : selectedTagId == id
                  ? color ?? Color(0xFF2C2C2A)
                  : Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedTagId == id
                    ? color ?? Color(0xFF2C2C2A)
                    : color != null
                    ? Colors.transparent
                    : Color(0xFF888780),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Text(
              tag,
              style: TextStyle(
                color: color != null
                    ? color
                    : selectedTagId == id
                    ? Colors.white
                    : Color(0xFF2C2C2A),
              ),
            ),
          ),
        );
      },
    );
  }
}
