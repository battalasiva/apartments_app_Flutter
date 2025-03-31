part of 'purchase_plan_bloc.dart';

abstract class PurchasePlanState extends Equatable {
  const PurchasePlanState();

  @override
  List<Object> get props => [];
}

class PurchasePlanInitial extends PurchasePlanState {}

class PurchasePlanLoading extends PurchasePlanState {}

class PurchasePlanSuccess extends PurchasePlanState {
  final String result;

  const PurchasePlanSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class PurchasePlanFailure extends PurchasePlanState {
  final String error;

  const PurchasePlanFailure(this.error);

  @override
  List<Object> get props => [error];
}
