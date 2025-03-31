part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileFailure extends EditProfileState {
  final String error;

  EditProfileFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ProfileUploadLoading extends EditProfileState {}

class ProfileUploadSuccess extends EditProfileState {}

class ProfileUploadFailure extends EditProfileState {
  final String error;

  ProfileUploadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
