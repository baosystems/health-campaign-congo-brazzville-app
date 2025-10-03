// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VaccineDeliveryEvent {
  TaskModel get task => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskModel task) handleSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskModel task)? handleSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskModel task)? handleSubmit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineDeliverySubmitEvent value) handleSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineDeliverySubmitEvent value)? handleSubmit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineDeliverySubmitEvent value)? handleSubmit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VaccineDeliveryEventCopyWith<VaccineDeliveryEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineDeliveryEventCopyWith<$Res> {
  factory $VaccineDeliveryEventCopyWith(VaccineDeliveryEvent value,
          $Res Function(VaccineDeliveryEvent) then) =
      _$VaccineDeliveryEventCopyWithImpl<$Res, VaccineDeliveryEvent>;
  @useResult
  $Res call({TaskModel task});
}

/// @nodoc
class _$VaccineDeliveryEventCopyWithImpl<$Res,
        $Val extends VaccineDeliveryEvent>
    implements $VaccineDeliveryEventCopyWith<$Res> {
  _$VaccineDeliveryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_value.copyWith(
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VaccineDeliverySubmitEventImplCopyWith<$Res>
    implements $VaccineDeliveryEventCopyWith<$Res> {
  factory _$$VaccineDeliverySubmitEventImplCopyWith(
          _$VaccineDeliverySubmitEventImpl value,
          $Res Function(_$VaccineDeliverySubmitEventImpl) then) =
      __$$VaccineDeliverySubmitEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TaskModel task});
}

/// @nodoc
class __$$VaccineDeliverySubmitEventImplCopyWithImpl<$Res>
    extends _$VaccineDeliveryEventCopyWithImpl<$Res,
        _$VaccineDeliverySubmitEventImpl>
    implements _$$VaccineDeliverySubmitEventImplCopyWith<$Res> {
  __$$VaccineDeliverySubmitEventImplCopyWithImpl(
      _$VaccineDeliverySubmitEventImpl _value,
      $Res Function(_$VaccineDeliverySubmitEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$VaccineDeliverySubmitEventImpl(
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
    ));
  }
}

/// @nodoc

class _$VaccineDeliverySubmitEventImpl implements VaccineDeliverySubmitEvent {
  const _$VaccineDeliverySubmitEventImpl({required this.task});

  @override
  final TaskModel task;

  @override
  String toString() {
    return 'VaccineDeliveryEvent.handleSubmit(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineDeliverySubmitEventImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineDeliverySubmitEventImplCopyWith<_$VaccineDeliverySubmitEventImpl>
      get copyWith => __$$VaccineDeliverySubmitEventImplCopyWithImpl<
          _$VaccineDeliverySubmitEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskModel task) handleSubmit,
  }) {
    return handleSubmit(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskModel task)? handleSubmit,
  }) {
    return handleSubmit?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskModel task)? handleSubmit,
    required TResult orElse(),
  }) {
    if (handleSubmit != null) {
      return handleSubmit(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineDeliverySubmitEvent value) handleSubmit,
  }) {
    return handleSubmit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineDeliverySubmitEvent value)? handleSubmit,
  }) {
    return handleSubmit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineDeliverySubmitEvent value)? handleSubmit,
    required TResult orElse(),
  }) {
    if (handleSubmit != null) {
      return handleSubmit(this);
    }
    return orElse();
  }
}

abstract class VaccineDeliverySubmitEvent implements VaccineDeliveryEvent {
  const factory VaccineDeliverySubmitEvent({required final TaskModel task}) =
      _$VaccineDeliverySubmitEventImpl;

  @override
  TaskModel get task;
  @override
  @JsonKey(ignore: true)
  _$$VaccineDeliverySubmitEventImplCopyWith<_$VaccineDeliverySubmitEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VaccineDeliveryState {
  bool get loading => throw _privateConstructorUsedError;
  TaskModel? get task => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VaccineDeliveryStateCopyWith<VaccineDeliveryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineDeliveryStateCopyWith<$Res> {
  factory $VaccineDeliveryStateCopyWith(VaccineDeliveryState value,
          $Res Function(VaccineDeliveryState) then) =
      _$VaccineDeliveryStateCopyWithImpl<$Res, VaccineDeliveryState>;
  @useResult
  $Res call({bool loading, TaskModel? task});
}

/// @nodoc
class _$VaccineDeliveryStateCopyWithImpl<$Res,
        $Val extends VaccineDeliveryState>
    implements $VaccineDeliveryStateCopyWith<$Res> {
  _$VaccineDeliveryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? task = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VaccineDeliveryStateImplCopyWith<$Res>
    implements $VaccineDeliveryStateCopyWith<$Res> {
  factory _$$VaccineDeliveryStateImplCopyWith(_$VaccineDeliveryStateImpl value,
          $Res Function(_$VaccineDeliveryStateImpl) then) =
      __$$VaccineDeliveryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, TaskModel? task});
}

/// @nodoc
class __$$VaccineDeliveryStateImplCopyWithImpl<$Res>
    extends _$VaccineDeliveryStateCopyWithImpl<$Res, _$VaccineDeliveryStateImpl>
    implements _$$VaccineDeliveryStateImplCopyWith<$Res> {
  __$$VaccineDeliveryStateImplCopyWithImpl(_$VaccineDeliveryStateImpl _value,
      $Res Function(_$VaccineDeliveryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? task = freezed,
  }) {
    return _then(_$VaccineDeliveryStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel?,
    ));
  }
}

/// @nodoc

class _$VaccineDeliveryStateImpl implements _VaccineDeliveryState {
  const _$VaccineDeliveryStateImpl({this.loading = false, this.task});

  @override
  @JsonKey()
  final bool loading;
  @override
  final TaskModel? task;

  @override
  String toString() {
    return 'VaccineDeliveryState(loading: $loading, task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineDeliveryStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineDeliveryStateImplCopyWith<_$VaccineDeliveryStateImpl>
      get copyWith =>
          __$$VaccineDeliveryStateImplCopyWithImpl<_$VaccineDeliveryStateImpl>(
              this, _$identity);
}

abstract class _VaccineDeliveryState implements VaccineDeliveryState {
  const factory _VaccineDeliveryState(
      {final bool loading, final TaskModel? task}) = _$VaccineDeliveryStateImpl;

  @override
  bool get loading;
  @override
  TaskModel? get task;
  @override
  @JsonKey(ignore: true)
  _$$VaccineDeliveryStateImplCopyWith<_$VaccineDeliveryStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
