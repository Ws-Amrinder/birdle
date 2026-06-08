import 'package:birdle/bloc/theme/theme_event.dart';
import 'package:birdle/bloc/theme/theme_state.dart';
import 'package:birdle/storage/theme_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(theme: 'light')) {
    on<LoadTheme>(_onLoadTheme);
    on<SelectTheme>(_onSelectTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final theme = await getTheme();
    emit(state.copyWith(theme: theme));
  }

  Future<void> _onSelectTheme(
    SelectTheme event,
    Emitter<ThemeState> emit,
  ) async {
    await setTheme(event.theme);
    emit(state.copyWith(theme: event.theme));
  }
}
