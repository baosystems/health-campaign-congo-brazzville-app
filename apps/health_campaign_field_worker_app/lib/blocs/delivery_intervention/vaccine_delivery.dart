import 'dart:async';

import 'package:digit_data_model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/task.dart';

part 'vaccine_delivery.freezed.dart';

typedef VaccineDeliveryEmitter = Emitter<VaccineDeliveryState>;

class VaccineDeliveryBloc
    extends Bloc<VaccineDeliveryEvent, VaccineDeliveryState> {
  final DataRepository<TaskModel, TaskSearchModel> taskRepository;

  VaccineDeliveryBloc(
    super.initialState, {
    required this.taskRepository,
  }) {
    on(_handleSubmit);
  }

  // Event handler for submitting a task
  FutureOr<void> _handleSubmit(
    VaccineDeliverySubmitEvent event,
    VaccineDeliveryEmitter emit,
  ) async {
    // Update loading state to indicate an operation is in progress
    emit(state.copyWith(loading: true));
    try {
      TaskModel updatedTask = event.task.copyWith(
        clientAuditDetails: (event.task.clientAuditDetails?.createdBy != null &&
                event.task.clientAuditDetails?.createdTime != null)
            ? ClientAuditDetails(
                createdBy: event.task.clientAuditDetails!.createdBy,
                createdTime: event.task.clientAuditDetails!.createdTime,
                lastModifiedBy: event.task.auditDetails?.lastModifiedBy ??
                    event.task.clientAuditDetails!.createdBy,
                lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
              )
            : null,
      );
      await taskRepository.update(updatedTask);
      emit(state.copyWith(loading: false, task: updatedTask));
    } catch (error) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  // Search for tasks and process the results
}

@freezed
class VaccineDeliveryEvent with _$VaccineDeliveryEvent {
  const factory VaccineDeliveryEvent.handleSubmit({
    required TaskModel task,
  }) = VaccineDeliverySubmitEvent;
}

@freezed
class VaccineDeliveryState with _$VaccineDeliveryState {
  const factory VaccineDeliveryState({
    @Default(false) bool loading,
    TaskModel? task,
  }) = _VaccineDeliveryState;
}
