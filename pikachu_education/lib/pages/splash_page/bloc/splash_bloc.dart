import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/service/initialization/initialization_service.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<OnBoardingAlreadyCheckingEvent>(_onBoardingAlreadyCheckingEvent);
  }
  _onBoardingAlreadyCheckingEvent(OnBoardingAlreadyCheckingEvent event, Emitter<SplashState>  emit) async {
    var obBoardingAlready = await InitializationService.onBoardingAlready();
    if (obBoardingAlready) {
      emit(OnBoardingAlreadyState());
    } else {
      emit(OnBoardingNotYetState());
    }
  }
}
