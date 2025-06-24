import 'package:hydrated_bloc/hydrated_bloc.dart';


class AppCubit extends HydratedCubit<bool> {
  AppCubit() : super(true); // true = light, false = dark

  void toggleTheme() => emit(!state);

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json['isLight'] as bool?;
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return {'isLight': state};
  }
}
