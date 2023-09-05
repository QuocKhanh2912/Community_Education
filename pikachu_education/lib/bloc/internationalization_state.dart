part of 'internationalization_bloc.dart';

abstract class InternationalizationState {
  String appLangCode;

  InternationalizationState({required this.appLangCode});
}


class InternationalizationInitial extends InternationalizationState {
  InternationalizationInitial({required super.appLangCode});
}

class InternationalizationEnSuccessState extends InternationalizationState {

  InternationalizationEnSuccessState({required super.appLangCode});
}

class InternationalizationViSuccessState extends InternationalizationState {

  InternationalizationViSuccessState({required super.appLangCode});
}
