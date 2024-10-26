import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to/data_base/database_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

// <List<Map<String, dynamic>>>
  List data = [];

  createDateBase() {
    DBHelper.instance.database.then((value) {
      print('Data Base create');
    }).catchError(() {
      print('dfffffffffffffffffffffffffffffffffffffff');
    });
  }

  insertInDateBase({
    required String note,
    required String dateTime,
  }) {
    DBHelper.instance.insertNote(note, dateTime).then((value) {
      emit(InsertInDataBaseSuccessState());
      getData();
      print('insert success ');
    }).catchError((error) {
      emit(InsertInDataBaseFailState(error));
      print('insert errror ');
    });
  }

  getData() {
    DBHelper.instance.getAllNotes().then((value) {
      // <List<Map<String, dynamic>>>
      data = value;

      print(data);
      emit(GetAllDataBaseSuccessState());
    }).catchError((error) {
      emit(GetAllDataBaseFailState(error));
    });
  }
}
