part of 'internationalization_bloc.dart';

abstract class InternationalizationState {
  String? appLangCode;
  InternationalizationState({this.appLangCode});
}

class InternationalizationInitial extends InternationalizationState {
  InternationalizationInitial({ super.appLangCode});
}

class InternationalizationEnSuccessState extends InternationalizationState {
  InternationalizationEnSuccessState({ super.appLangCode});
}

class InternationalizationViSuccessState extends InternationalizationState {
  InternationalizationViSuccessState({ super.appLangCode});
}
