
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/service/get_from_gallery_service/get_image.dart';

part 'get_image_to_create_answer_event.dart';
part 'get_image_to_create_answer_state.dart';

class GetImageToCreateAnswerBloc extends Bloc<GetImageToCreateAnswerEvent, GetImageToCreateAnswerState> {
  GetImageToCreateAnswerBloc() : super(GetImageToCreateAnswerInitial()) {
    on<GetImageToCreateAnswerEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetImageToCreateAnswerByGalleyEvent>((event, emit) async {
      var image = await GetImageService.getImage(source: event.source);
      emit (GetImageToCreateAnswerSuccess(image: image));
    });
  }
}
