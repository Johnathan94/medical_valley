import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/profile/data/edit_user_request.dart';
import 'package:medical_valley/features/profile/data/get_user_response.dart';
import 'package:medical_valley/features/profile/domain/get_user_use_case.dart';
import 'package:medical_valley/features/profile/domain/update_user_use_case.dart';

class UserProfileBloc extends Cubit<UserInfoState> {
  final GetUserUseCase getUserUseCase;
  UpdateUserUseCase updateUserUseCase;
  UserProfileBloc(this.getUserUseCase, this.updateUserUseCase)
      : super(GetUserStateIdle());
  getUserData() async {
    emit(GetUserInfoStateLoading());
    var either = await getUserUseCase.getUserData();
    either.fold((l) {
      emit(GetUserInfoStateError());
    }, (r) {
      emit(GetUserInfoStateSuccess(r));
    });
  }

  updateUserData(UpdateUserRequest model, [MultipartFile? image]) async {
    emit(UpdateUserInfoStateLoading());
    var either = await updateUserUseCase.updateUser(model, image);
    either.fold((l) {
      emit(UpdateUserInfoStateError(l.error ?? ""));
    }, (r) {
      emit(UpdateUserInfoStateSuccess());
    });
  }
}

abstract class UserInfoState {}

class GetUserInfoStateLoading extends UserInfoState {}

class GetUserStateIdle extends UserInfoState {}

class GetUserInfoStateSuccess extends UserInfoState {
  UserModel model;

  GetUserInfoStateSuccess(this.model);
}

class GetUserInfoStateError extends UserInfoState {}

class UpdateUserInfoStateLoading extends UserInfoState {}

class UpdateUserInfoStateIdle extends UserInfoState {}

class UpdateUserInfoStateSuccess extends UserInfoState {
  UpdateUserInfoStateSuccess();
}

class UpdateUserInfoStateError extends UserInfoState {
  String error;

  UpdateUserInfoStateError(this.error);
}
