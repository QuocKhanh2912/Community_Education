import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/service/data_service.dart';

import '../data/data_questions_modal.dart';

part 'data_home_page_event.dart';
part 'data_home_page_state.dart';

class DataHomePageBloc extends Bloc<DataHomePageEvent, DataHomePageState> {
  DataHomePageBloc() : super(DataInitial(const <DataQuestionModal>[])) {
    on<GetDataHomePage>(_onGetDataHomePage);
    on<FetchDataHomePage>(_onFetchDataHomePage);
    on<PostDataHomePage>(_onPostDataHomePage);
  }

  _onGetDataHomePage(GetDataHomePage event, Emitter<DataHomePageState> emit) async {
    emit(DataLoading(state.dataList));
    var dataFromServer = await DataSerVice.getDataFromServer();
    emit (DataChangedSuccess(dataFromServer));
    print('Check Bloc: GET data of home page SUCCESSFUL');
  }

  _onFetchDataHomePage(FetchDataHomePage event, Emitter<DataHomePageState> emit) async{
  var dataFromServer = await DataSerVice.getDataFromServer();
  emit (DataChangedSuccess(dataFromServer));
  print('Check Bloc: FETCH data of home page SUCCESSFUL');
}

  _onPostDataHomePage(PostDataHomePage event, Emitter<DataHomePageState> emit) async{
    await DataSerVice.postDataFromServer(event.dataToPost);
    var dataFromServer = await DataSerVice.getDataFromServer();
    emit (DataChangedSuccess(dataFromServer));
    print('Check Bloc: POST data of home page SUCCESSFUL');
  }
}
