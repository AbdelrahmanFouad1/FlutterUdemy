import 'package:first_flutter_app/models/shop_app/search_model.dart';
import 'package:first_flutter_app/modules/shop_app/search/cubit/states.dart';
import 'package:first_flutter_app/shared/components/constants.dart';
import 'package:first_flutter_app/shared/network/end_point.dart';
import 'package:first_flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search(String text) {
    emit(SearchLoadingStates());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error) {
      emit(SearchErrorStates());
    });
  }
}
