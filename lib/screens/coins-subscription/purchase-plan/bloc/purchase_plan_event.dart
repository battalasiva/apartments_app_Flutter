part of 'purchase_plan_bloc.dart';

abstract class PurchasePlanEvent extends Equatable {
  const PurchasePlanEvent();

  @override
  List<Object> get props => [];
}

class PurchasePlanRequestedEvent extends PurchasePlanEvent {
  final String apartmentId;
  final int months;

  const PurchasePlanRequestedEvent({
    required this.apartmentId,
    required this.months,
  });

  @override
  List<Object> get props => [apartmentId, months];
}
