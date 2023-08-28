part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class OnBoardingAlreadyState extends SplashState{}
class OnBoardingNotYetState extends SplashState{}
