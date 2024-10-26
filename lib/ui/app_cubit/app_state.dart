part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}
final class InsertInDataBaseSuccessState extends AppState {}
final class InsertInDataBaseFailState extends AppState {
  final String error ;
  InsertInDataBaseFailState(this.error);
}
final class GetAllDataBaseSuccessState extends AppState {}
final class GetAllDataBaseFailState extends AppState {
  final String error ;
  GetAllDataBaseFailState(this.error);
}