import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();
}

class SelectTheme extends ThemeEvent {
  final String theme;

  const SelectTheme({required this.theme});

  @override
  List<Object?> get props => [theme];
}
