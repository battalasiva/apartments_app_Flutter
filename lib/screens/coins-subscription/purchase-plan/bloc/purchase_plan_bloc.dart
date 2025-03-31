import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nivaas/domain/repositories/coins-subscription/purchase_plan_repository.dart';

part 'purchase_plan_event.dart';
part 'purchase_plan_state.dart';

class PurchasePlanBloc extends Bloc<PurchasePlanEvent, PurchasePlanState> {
  final PurchasePlanRepository repository;

  PurchasePlanBloc({required this.repository}) : super(PurchasePlanInitial()) {
    on<PurchasePlanRequestedEvent>(_onPurchasePlanRequested);
  }

  Future<void> _onPurchasePlanRequested(
    PurchasePlanRequestedEvent event,
    Emitter<PurchasePlanState> emit,
  ) async {
    emit(PurchasePlanLoading());
    try {
      final result =
          await repository.purchasePlan(event.apartmentId, event.months);
      emit(PurchasePlanSuccess(result));
    } catch (e) {
      emit(PurchasePlanFailure(e.toString()));
    }
  }
}
