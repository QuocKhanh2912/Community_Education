import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/service/authentication/authentication_service.dart';

part 'internationalization_event.dart';
part 'internationalization_state.dart';

class InternationalizationBloc
    extends Bloc<InternationalizationEvent, InternationalizationState> {
  InternationalizationBloc()
      : super(InternationalizationInitial(appLangCode: 'en')) {
    _authService = AuthenticationLocalService();
    on<InternationalizationViEvent>(_internationalizationViEvent);
    on<InternationalizationEnEvent>(_internationalizationEnEvent);
  }

  late final AuthenticationLocalService _authService;

  _internationalizationViEvent(InternationalizationViEvent event,
      Emitter<InternationalizationState> emit) {
    _authService.saveAppLang(appLang: 'vi');
    emit(InternationalizationViSuccessState(appLangCode: 'vi'));
  }

  _internationalizationEnEvent(event, emit) {
    _authService.saveAppLang(appLang: 'en');
    emit(InternationalizationEnSuccessState(appLangCode: 'en'));
  }
}
