import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pikachu_education/service/tools/get_image.dart';

part 'get_image_event.dart';
part 'get_image_state.dart';

class GetImageBloc extends Bloc<GetImageEvent, GetImageState> {
  GetImageBloc() : super(GetImageInitial()) {
    on<GetImageEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetImageByGalley>((event, emit) async{
     var image = await GetImageService.getImage(source: event.source);
     emit (GetImageSuccess(image: image));
    });
  }
}
