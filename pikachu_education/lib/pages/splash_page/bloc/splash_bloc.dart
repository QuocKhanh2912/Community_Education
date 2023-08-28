

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/service/service_local_storage/service_read_data_from_local_storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<OnBoardingAlreadyCheckingEvent>((event, emit) async {
      var obBoardingAlready = await ReadDataFromLocal.onBoardingAlready();
      if(obBoardingAlready){
        emit (OnBoardingAlreadyState());
      }
      else {
        emit (OnBoardingNotYetState());
      }

    });
  }
}
