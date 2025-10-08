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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskModel task, TaskModel? currentDoseTask)
        submit,
    required TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)
        vaccineSelection,
    required TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)
        additionalVaccineDose,
    required TResult Function() clearAdditionalVaccineDose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult? Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult? Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult? Function()? clearAdditionalVaccineDose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult Function()? clearAdditionalVaccineDose,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineDeliverySubmitEvent value) submit,
    required TResult Function(VaccineDeliveryVaccineSelectionEvent value)
        vaccineSelection,
    required TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)
        additionalVaccineDose,
    required TResult Function(
            VaccineDeliveryClearAdditionalVaccineDoseEvent value)
        clearAdditionalVaccineDose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineDeliverySubmitEvent value)? submit,
    TResult? Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult? Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult? Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineDeliverySubmitEvent value)? submit,
    TResult Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineDeliveryEventCopyWith<$Res> {
  factory $VaccineDeliveryEventCopyWith(VaccineDeliveryEvent value,
          $Res Function(VaccineDeliveryEvent) then) =
      _$VaccineDeliveryEventCopyWithImpl<$Res, VaccineDeliveryEvent>;
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
}

/// @nodoc
abstract class _$$VaccineDeliverySubmitEventImplCopyWith<$Res> {
  factory _$$VaccineDeliverySubmitEventImplCopyWith(
          _$VaccineDeliverySubmitEventImpl value,
          $Res Function(_$VaccineDeliverySubmitEventImpl) then) =
      __$$VaccineDeliverySubmitEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskModel task, TaskModel? currentDoseTask});
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
    Object? currentDoseTask = freezed,
  }) {
    return _then(_$VaccineDeliverySubmitEventImpl(
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
      currentDoseTask: freezed == currentDoseTask
          ? _value.currentDoseTask
          : currentDoseTask // ignore: cast_nullable_to_non_nullable
              as TaskModel?,
    ));
  }
}

/// @nodoc

class _$VaccineDeliverySubmitEventImpl implements VaccineDeliverySubmitEvent {
  const _$VaccineDeliverySubmitEventImpl(
      {required this.task, this.currentDoseTask});

  @override
  final TaskModel task;
  @override
  final TaskModel? currentDoseTask;

  @override
  String toString() {
    return 'VaccineDeliveryEvent.submit(task: $task, currentDoseTask: $currentDoseTask)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineDeliverySubmitEventImpl &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.currentDoseTask, currentDoseTask) ||
                other.currentDoseTask == currentDoseTask));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task, currentDoseTask);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineDeliverySubmitEventImplCopyWith<_$VaccineDeliverySubmitEventImpl>
      get copyWith => __$$VaccineDeliverySubmitEventImplCopyWithImpl<
          _$VaccineDeliverySubmitEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskModel task, TaskModel? currentDoseTask)
        submit,
    required TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)
        vaccineSelection,
    required TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)
        additionalVaccineDose,
    required TResult Function() clearAdditionalVaccineDose,
  }) {
    return submit(task, currentDoseTask);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult? Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult? Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult? Function()? clearAdditionalVaccineDose,
  }) {
    return submit?.call(task, currentDoseTask);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult Function()? clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(task, currentDoseTask);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineDeliverySubmitEvent value) submit,
    required TResult Function(VaccineDeliveryVaccineSelectionEvent value)
        vaccineSelection,
    required TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)
        additionalVaccineDose,
    required TResult Function(
            VaccineDeliveryClearAdditionalVaccineDoseEvent value)
        clearAdditionalVaccineDose,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineDeliverySubmitEvent value)? submit,
    TResult? Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult? Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult? Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineDeliverySubmitEvent value)? submit,
    TResult Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class VaccineDeliverySubmitEvent implements VaccineDeliveryEvent {
  const factory VaccineDeliverySubmitEvent(
      {required final TaskModel task,
      final TaskModel? currentDoseTask}) = _$VaccineDeliverySubmitEventImpl;

  TaskModel get task;
  TaskModel? get currentDoseTask;
  @JsonKey(ignore: true)
  _$$VaccineDeliverySubmitEventImplCopyWith<_$VaccineDeliverySubmitEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VaccineDeliveryVaccineSelectionEventImplCopyWith<$Res> {
  factory _$$VaccineDeliveryVaccineSelectionEventImplCopyWith(
          _$VaccineDeliveryVaccineSelectionEventImpl value,
          $Res Function(_$VaccineDeliveryVaccineSelectionEventImpl) then) =
      __$$VaccineDeliveryVaccineSelectionEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ProductVariantModel> productVariants,
      Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
      List<String> availedVaccineDoseCodes,
      List<String> allVaccineDoseCodes});
}

/// @nodoc
class __$$VaccineDeliveryVaccineSelectionEventImplCopyWithImpl<$Res>
    extends _$VaccineDeliveryEventCopyWithImpl<$Res,
        _$VaccineDeliveryVaccineSelectionEventImpl>
    implements _$$VaccineDeliveryVaccineSelectionEventImplCopyWith<$Res> {
  __$$VaccineDeliveryVaccineSelectionEventImplCopyWithImpl(
      _$VaccineDeliveryVaccineSelectionEventImpl _value,
      $Res Function(_$VaccineDeliveryVaccineSelectionEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productVariants = null,
    Object? eligibleVaccinesCodeByAgeIndex = null,
    Object? availedVaccineDoseCodes = null,
    Object? allVaccineDoseCodes = null,
  }) {
    return _then(_$VaccineDeliveryVaccineSelectionEventImpl(
      productVariants: null == productVariants
          ? _value._productVariants
          : productVariants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>,
      eligibleVaccinesCodeByAgeIndex: null == eligibleVaccinesCodeByAgeIndex
          ? _value._eligibleVaccinesCodeByAgeIndex
          : eligibleVaccinesCodeByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>,
      availedVaccineDoseCodes: null == availedVaccineDoseCodes
          ? _value._availedVaccineDoseCodes
          : availedVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allVaccineDoseCodes: null == allVaccineDoseCodes
          ? _value._allVaccineDoseCodes
          : allVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$VaccineDeliveryVaccineSelectionEventImpl
    implements VaccineDeliveryVaccineSelectionEvent {
  const _$VaccineDeliveryVaccineSelectionEventImpl(
      {required final List<ProductVariantModel> productVariants,
      required final Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
      required final List<String> availedVaccineDoseCodes,
      required final List<String> allVaccineDoseCodes})
      : _productVariants = productVariants,
        _eligibleVaccinesCodeByAgeIndex = eligibleVaccinesCodeByAgeIndex,
        _availedVaccineDoseCodes = availedVaccineDoseCodes,
        _allVaccineDoseCodes = allVaccineDoseCodes;

  final List<ProductVariantModel> _productVariants;
  @override
  List<ProductVariantModel> get productVariants {
    if (_productVariants is EqualUnmodifiableListView) return _productVariants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productVariants);
  }

  final Map<int, Set<String>> _eligibleVaccinesCodeByAgeIndex;
  @override
  Map<int, Set<String>> get eligibleVaccinesCodeByAgeIndex {
    if (_eligibleVaccinesCodeByAgeIndex is EqualUnmodifiableMapView)
      return _eligibleVaccinesCodeByAgeIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_eligibleVaccinesCodeByAgeIndex);
  }

  final List<String> _availedVaccineDoseCodes;
  @override
  List<String> get availedVaccineDoseCodes {
    if (_availedVaccineDoseCodes is EqualUnmodifiableListView)
      return _availedVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availedVaccineDoseCodes);
  }

  final List<String> _allVaccineDoseCodes;
  @override
  List<String> get allVaccineDoseCodes {
    if (_allVaccineDoseCodes is EqualUnmodifiableListView)
      return _allVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allVaccineDoseCodes);
  }

  @override
  String toString() {
    return 'VaccineDeliveryEvent.vaccineSelection(productVariants: $productVariants, eligibleVaccinesCodeByAgeIndex: $eligibleVaccinesCodeByAgeIndex, availedVaccineDoseCodes: $availedVaccineDoseCodes, allVaccineDoseCodes: $allVaccineDoseCodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineDeliveryVaccineSelectionEventImpl &&
            const DeepCollectionEquality()
                .equals(other._productVariants, _productVariants) &&
            const DeepCollectionEquality().equals(
                other._eligibleVaccinesCodeByAgeIndex,
                _eligibleVaccinesCodeByAgeIndex) &&
            const DeepCollectionEquality().equals(
                other._availedVaccineDoseCodes, _availedVaccineDoseCodes) &&
            const DeepCollectionEquality()
                .equals(other._allVaccineDoseCodes, _allVaccineDoseCodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_productVariants),
      const DeepCollectionEquality().hash(_eligibleVaccinesCodeByAgeIndex),
      const DeepCollectionEquality().hash(_availedVaccineDoseCodes),
      const DeepCollectionEquality().hash(_allVaccineDoseCodes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineDeliveryVaccineSelectionEventImplCopyWith<
          _$VaccineDeliveryVaccineSelectionEventImpl>
      get copyWith => __$$VaccineDeliveryVaccineSelectionEventImplCopyWithImpl<
          _$VaccineDeliveryVaccineSelectionEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskModel task, TaskModel? currentDoseTask)
        submit,
    required TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)
        vaccineSelection,
    required TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)
        additionalVaccineDose,
    required TResult Function() clearAdditionalVaccineDose,
  }) {
    return vaccineSelection(productVariants, eligibleVaccinesCodeByAgeIndex,
        availedVaccineDoseCodes, allVaccineDoseCodes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult? Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult? Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult? Function()? clearAdditionalVaccineDose,
  }) {
    return vaccineSelection?.call(
        productVariants,
        eligibleVaccinesCodeByAgeIndex,
        availedVaccineDoseCodes,
        allVaccineDoseCodes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult Function()? clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (vaccineSelection != null) {
      return vaccineSelection(productVariants, eligibleVaccinesCodeByAgeIndex,
          availedVaccineDoseCodes, allVaccineDoseCodes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineDeliverySubmitEvent value) submit,
    required TResult Function(VaccineDeliveryVaccineSelectionEvent value)
        vaccineSelection,
    required TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)
        additionalVaccineDose,
    required TResult Function(
            VaccineDeliveryClearAdditionalVaccineDoseEvent value)
        clearAdditionalVaccineDose,
  }) {
    return vaccineSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineDeliverySubmitEvent value)? submit,
    TResult? Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult? Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult? Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
  }) {
    return vaccineSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineDeliverySubmitEvent value)? submit,
    TResult Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (vaccineSelection != null) {
      return vaccineSelection(this);
    }
    return orElse();
  }
}

abstract class VaccineDeliveryVaccineSelectionEvent
    implements VaccineDeliveryEvent {
  const factory VaccineDeliveryVaccineSelectionEvent(
          {required final List<ProductVariantModel> productVariants,
          required final Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
          required final List<String> availedVaccineDoseCodes,
          required final List<String> allVaccineDoseCodes}) =
      _$VaccineDeliveryVaccineSelectionEventImpl;

  List<ProductVariantModel> get productVariants;
  Map<int, Set<String>> get eligibleVaccinesCodeByAgeIndex;
  List<String> get availedVaccineDoseCodes;
  List<String> get allVaccineDoseCodes;
  @JsonKey(ignore: true)
  _$$VaccineDeliveryVaccineSelectionEventImplCopyWith<
          _$VaccineDeliveryVaccineSelectionEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWith<$Res> {
  factory _$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWith(
          _$VaccineDeliveryAdditionalVaccineDoseEventImpl value,
          $Res Function(_$VaccineDeliveryAdditionalVaccineDoseEventImpl) then) =
      __$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Set<String>? filterVaccineDoseCodes,
      Set<String>? additionalVaccineDoseCodes});
}

/// @nodoc
class __$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWithImpl<$Res>
    extends _$VaccineDeliveryEventCopyWithImpl<$Res,
        _$VaccineDeliveryAdditionalVaccineDoseEventImpl>
    implements _$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWith<$Res> {
  __$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWithImpl(
      _$VaccineDeliveryAdditionalVaccineDoseEventImpl _value,
      $Res Function(_$VaccineDeliveryAdditionalVaccineDoseEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterVaccineDoseCodes = freezed,
    Object? additionalVaccineDoseCodes = freezed,
  }) {
    return _then(_$VaccineDeliveryAdditionalVaccineDoseEventImpl(
      filterVaccineDoseCodes: freezed == filterVaccineDoseCodes
          ? _value._filterVaccineDoseCodes
          : filterVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      additionalVaccineDoseCodes: freezed == additionalVaccineDoseCodes
          ? _value._additionalVaccineDoseCodes
          : additionalVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
    ));
  }
}

/// @nodoc

class _$VaccineDeliveryAdditionalVaccineDoseEventImpl
    implements VaccineDeliveryAdditionalVaccineDoseEvent {
  const _$VaccineDeliveryAdditionalVaccineDoseEventImpl(
      {final Set<String>? filterVaccineDoseCodes,
      final Set<String>? additionalVaccineDoseCodes})
      : _filterVaccineDoseCodes = filterVaccineDoseCodes,
        _additionalVaccineDoseCodes = additionalVaccineDoseCodes;

  final Set<String>? _filterVaccineDoseCodes;
  @override
  Set<String>? get filterVaccineDoseCodes {
    final value = _filterVaccineDoseCodes;
    if (value == null) return null;
    if (_filterVaccineDoseCodes is EqualUnmodifiableSetView)
      return _filterVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  final Set<String>? _additionalVaccineDoseCodes;
  @override
  Set<String>? get additionalVaccineDoseCodes {
    final value = _additionalVaccineDoseCodes;
    if (value == null) return null;
    if (_additionalVaccineDoseCodes is EqualUnmodifiableSetView)
      return _additionalVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  String toString() {
    return 'VaccineDeliveryEvent.additionalVaccineDose(filterVaccineDoseCodes: $filterVaccineDoseCodes, additionalVaccineDoseCodes: $additionalVaccineDoseCodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineDeliveryAdditionalVaccineDoseEventImpl &&
            const DeepCollectionEquality().equals(
                other._filterVaccineDoseCodes, _filterVaccineDoseCodes) &&
            const DeepCollectionEquality().equals(
                other._additionalVaccineDoseCodes,
                _additionalVaccineDoseCodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_filterVaccineDoseCodes),
      const DeepCollectionEquality().hash(_additionalVaccineDoseCodes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWith<
          _$VaccineDeliveryAdditionalVaccineDoseEventImpl>
      get copyWith =>
          __$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWithImpl<
                  _$VaccineDeliveryAdditionalVaccineDoseEventImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskModel task, TaskModel? currentDoseTask)
        submit,
    required TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)
        vaccineSelection,
    required TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)
        additionalVaccineDose,
    required TResult Function() clearAdditionalVaccineDose,
  }) {
    return additionalVaccineDose(
        filterVaccineDoseCodes, additionalVaccineDoseCodes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult? Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult? Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult? Function()? clearAdditionalVaccineDose,
  }) {
    return additionalVaccineDose?.call(
        filterVaccineDoseCodes, additionalVaccineDoseCodes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult Function()? clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (additionalVaccineDose != null) {
      return additionalVaccineDose(
          filterVaccineDoseCodes, additionalVaccineDoseCodes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineDeliverySubmitEvent value) submit,
    required TResult Function(VaccineDeliveryVaccineSelectionEvent value)
        vaccineSelection,
    required TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)
        additionalVaccineDose,
    required TResult Function(
            VaccineDeliveryClearAdditionalVaccineDoseEvent value)
        clearAdditionalVaccineDose,
  }) {
    return additionalVaccineDose(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineDeliverySubmitEvent value)? submit,
    TResult? Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult? Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult? Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
  }) {
    return additionalVaccineDose?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineDeliverySubmitEvent value)? submit,
    TResult Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (additionalVaccineDose != null) {
      return additionalVaccineDose(this);
    }
    return orElse();
  }
}

abstract class VaccineDeliveryAdditionalVaccineDoseEvent
    implements VaccineDeliveryEvent {
  const factory VaccineDeliveryAdditionalVaccineDoseEvent(
          {final Set<String>? filterVaccineDoseCodes,
          final Set<String>? additionalVaccineDoseCodes}) =
      _$VaccineDeliveryAdditionalVaccineDoseEventImpl;

  Set<String>? get filterVaccineDoseCodes;
  Set<String>? get additionalVaccineDoseCodes;
  @JsonKey(ignore: true)
  _$$VaccineDeliveryAdditionalVaccineDoseEventImplCopyWith<
          _$VaccineDeliveryAdditionalVaccineDoseEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VaccineDeliveryClearAdditionalVaccineDoseEventImplCopyWith<
    $Res> {
  factory _$$VaccineDeliveryClearAdditionalVaccineDoseEventImplCopyWith(
          _$VaccineDeliveryClearAdditionalVaccineDoseEventImpl value,
          $Res Function(_$VaccineDeliveryClearAdditionalVaccineDoseEventImpl)
              then) =
      __$$VaccineDeliveryClearAdditionalVaccineDoseEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VaccineDeliveryClearAdditionalVaccineDoseEventImplCopyWithImpl<$Res>
    extends _$VaccineDeliveryEventCopyWithImpl<$Res,
        _$VaccineDeliveryClearAdditionalVaccineDoseEventImpl>
    implements
        _$$VaccineDeliveryClearAdditionalVaccineDoseEventImplCopyWith<$Res> {
  __$$VaccineDeliveryClearAdditionalVaccineDoseEventImplCopyWithImpl(
      _$VaccineDeliveryClearAdditionalVaccineDoseEventImpl _value,
      $Res Function(_$VaccineDeliveryClearAdditionalVaccineDoseEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$VaccineDeliveryClearAdditionalVaccineDoseEventImpl
    implements VaccineDeliveryClearAdditionalVaccineDoseEvent {
  const _$VaccineDeliveryClearAdditionalVaccineDoseEventImpl();

  @override
  String toString() {
    return 'VaccineDeliveryEvent.clearAdditionalVaccineDose()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineDeliveryClearAdditionalVaccineDoseEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskModel task, TaskModel? currentDoseTask)
        submit,
    required TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)
        vaccineSelection,
    required TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)
        additionalVaccineDose,
    required TResult Function() clearAdditionalVaccineDose,
  }) {
    return clearAdditionalVaccineDose();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult? Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult? Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult? Function()? clearAdditionalVaccineDose,
  }) {
    return clearAdditionalVaccineDose?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskModel task, TaskModel? currentDoseTask)? submit,
    TResult Function(
            List<ProductVariantModel> productVariants,
            Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
            List<String> availedVaccineDoseCodes,
            List<String> allVaccineDoseCodes)?
        vaccineSelection,
    TResult Function(Set<String>? filterVaccineDoseCodes,
            Set<String>? additionalVaccineDoseCodes)?
        additionalVaccineDose,
    TResult Function()? clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (clearAdditionalVaccineDose != null) {
      return clearAdditionalVaccineDose();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineDeliverySubmitEvent value) submit,
    required TResult Function(VaccineDeliveryVaccineSelectionEvent value)
        vaccineSelection,
    required TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)
        additionalVaccineDose,
    required TResult Function(
            VaccineDeliveryClearAdditionalVaccineDoseEvent value)
        clearAdditionalVaccineDose,
  }) {
    return clearAdditionalVaccineDose(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineDeliverySubmitEvent value)? submit,
    TResult? Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult? Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult? Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
  }) {
    return clearAdditionalVaccineDose?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineDeliverySubmitEvent value)? submit,
    TResult Function(VaccineDeliveryVaccineSelectionEvent value)?
        vaccineSelection,
    TResult Function(VaccineDeliveryAdditionalVaccineDoseEvent value)?
        additionalVaccineDose,
    TResult Function(VaccineDeliveryClearAdditionalVaccineDoseEvent value)?
        clearAdditionalVaccineDose,
    required TResult orElse(),
  }) {
    if (clearAdditionalVaccineDose != null) {
      return clearAdditionalVaccineDose(this);
    }
    return orElse();
  }
}

abstract class VaccineDeliveryClearAdditionalVaccineDoseEvent
    implements VaccineDeliveryEvent {
  const factory VaccineDeliveryClearAdditionalVaccineDoseEvent() =
      _$VaccineDeliveryClearAdditionalVaccineDoseEventImpl;
}

/// @nodoc
mixin _$VaccineDeliveryState {
  bool get loading => throw _privateConstructorUsedError;
  List<String>? get availedVaccineDoseCodes =>
      throw _privateConstructorUsedError;
  List<VaccineDeliveryDetails>? get currentVaccineDoseData =>
      throw _privateConstructorUsedError;
  Set<String>? get nextVaccineDoseData => throw _privateConstructorUsedError;
  Set<String>? get filterVaccineDoseCodes => throw _privateConstructorUsedError;
  Set<String>? get additionalVaccineDoseCodes =>
      throw _privateConstructorUsedError;

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
  $Res call(
      {bool loading,
      List<String>? availedVaccineDoseCodes,
      List<VaccineDeliveryDetails>? currentVaccineDoseData,
      Set<String>? nextVaccineDoseData,
      Set<String>? filterVaccineDoseCodes,
      Set<String>? additionalVaccineDoseCodes});
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
    Object? availedVaccineDoseCodes = freezed,
    Object? currentVaccineDoseData = freezed,
    Object? nextVaccineDoseData = freezed,
    Object? filterVaccineDoseCodes = freezed,
    Object? additionalVaccineDoseCodes = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      availedVaccineDoseCodes: freezed == availedVaccineDoseCodes
          ? _value.availedVaccineDoseCodes
          : availedVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentVaccineDoseData: freezed == currentVaccineDoseData
          ? _value.currentVaccineDoseData
          : currentVaccineDoseData // ignore: cast_nullable_to_non_nullable
              as List<VaccineDeliveryDetails>?,
      nextVaccineDoseData: freezed == nextVaccineDoseData
          ? _value.nextVaccineDoseData
          : nextVaccineDoseData // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      filterVaccineDoseCodes: freezed == filterVaccineDoseCodes
          ? _value.filterVaccineDoseCodes
          : filterVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      additionalVaccineDoseCodes: freezed == additionalVaccineDoseCodes
          ? _value.additionalVaccineDoseCodes
          : additionalVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
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
  $Res call(
      {bool loading,
      List<String>? availedVaccineDoseCodes,
      List<VaccineDeliveryDetails>? currentVaccineDoseData,
      Set<String>? nextVaccineDoseData,
      Set<String>? filterVaccineDoseCodes,
      Set<String>? additionalVaccineDoseCodes});
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
    Object? availedVaccineDoseCodes = freezed,
    Object? currentVaccineDoseData = freezed,
    Object? nextVaccineDoseData = freezed,
    Object? filterVaccineDoseCodes = freezed,
    Object? additionalVaccineDoseCodes = freezed,
  }) {
    return _then(_$VaccineDeliveryStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      availedVaccineDoseCodes: freezed == availedVaccineDoseCodes
          ? _value._availedVaccineDoseCodes
          : availedVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentVaccineDoseData: freezed == currentVaccineDoseData
          ? _value._currentVaccineDoseData
          : currentVaccineDoseData // ignore: cast_nullable_to_non_nullable
              as List<VaccineDeliveryDetails>?,
      nextVaccineDoseData: freezed == nextVaccineDoseData
          ? _value._nextVaccineDoseData
          : nextVaccineDoseData // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      filterVaccineDoseCodes: freezed == filterVaccineDoseCodes
          ? _value._filterVaccineDoseCodes
          : filterVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      additionalVaccineDoseCodes: freezed == additionalVaccineDoseCodes
          ? _value._additionalVaccineDoseCodes
          : additionalVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
    ));
  }
}

/// @nodoc

class _$VaccineDeliveryStateImpl implements _VaccineDeliveryState {
  const _$VaccineDeliveryStateImpl(
      {this.loading = false,
      final List<String>? availedVaccineDoseCodes,
      final List<VaccineDeliveryDetails>? currentVaccineDoseData,
      final Set<String>? nextVaccineDoseData,
      final Set<String>? filterVaccineDoseCodes,
      final Set<String>? additionalVaccineDoseCodes})
      : _availedVaccineDoseCodes = availedVaccineDoseCodes,
        _currentVaccineDoseData = currentVaccineDoseData,
        _nextVaccineDoseData = nextVaccineDoseData,
        _filterVaccineDoseCodes = filterVaccineDoseCodes,
        _additionalVaccineDoseCodes = additionalVaccineDoseCodes;

  @override
  @JsonKey()
  final bool loading;
  final List<String>? _availedVaccineDoseCodes;
  @override
  List<String>? get availedVaccineDoseCodes {
    final value = _availedVaccineDoseCodes;
    if (value == null) return null;
    if (_availedVaccineDoseCodes is EqualUnmodifiableListView)
      return _availedVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<VaccineDeliveryDetails>? _currentVaccineDoseData;
  @override
  List<VaccineDeliveryDetails>? get currentVaccineDoseData {
    final value = _currentVaccineDoseData;
    if (value == null) return null;
    if (_currentVaccineDoseData is EqualUnmodifiableListView)
      return _currentVaccineDoseData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Set<String>? _nextVaccineDoseData;
  @override
  Set<String>? get nextVaccineDoseData {
    final value = _nextVaccineDoseData;
    if (value == null) return null;
    if (_nextVaccineDoseData is EqualUnmodifiableSetView)
      return _nextVaccineDoseData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  final Set<String>? _filterVaccineDoseCodes;
  @override
  Set<String>? get filterVaccineDoseCodes {
    final value = _filterVaccineDoseCodes;
    if (value == null) return null;
    if (_filterVaccineDoseCodes is EqualUnmodifiableSetView)
      return _filterVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  final Set<String>? _additionalVaccineDoseCodes;
  @override
  Set<String>? get additionalVaccineDoseCodes {
    final value = _additionalVaccineDoseCodes;
    if (value == null) return null;
    if (_additionalVaccineDoseCodes is EqualUnmodifiableSetView)
      return _additionalVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  String toString() {
    return 'VaccineDeliveryState(loading: $loading, availedVaccineDoseCodes: $availedVaccineDoseCodes, currentVaccineDoseData: $currentVaccineDoseData, nextVaccineDoseData: $nextVaccineDoseData, filterVaccineDoseCodes: $filterVaccineDoseCodes, additionalVaccineDoseCodes: $additionalVaccineDoseCodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineDeliveryStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(
                other._availedVaccineDoseCodes, _availedVaccineDoseCodes) &&
            const DeepCollectionEquality().equals(
                other._currentVaccineDoseData, _currentVaccineDoseData) &&
            const DeepCollectionEquality()
                .equals(other._nextVaccineDoseData, _nextVaccineDoseData) &&
            const DeepCollectionEquality().equals(
                other._filterVaccineDoseCodes, _filterVaccineDoseCodes) &&
            const DeepCollectionEquality().equals(
                other._additionalVaccineDoseCodes,
                _additionalVaccineDoseCodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      const DeepCollectionEquality().hash(_availedVaccineDoseCodes),
      const DeepCollectionEquality().hash(_currentVaccineDoseData),
      const DeepCollectionEquality().hash(_nextVaccineDoseData),
      const DeepCollectionEquality().hash(_filterVaccineDoseCodes),
      const DeepCollectionEquality().hash(_additionalVaccineDoseCodes));

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
          {final bool loading,
          final List<String>? availedVaccineDoseCodes,
          final List<VaccineDeliveryDetails>? currentVaccineDoseData,
          final Set<String>? nextVaccineDoseData,
          final Set<String>? filterVaccineDoseCodes,
          final Set<String>? additionalVaccineDoseCodes}) =
      _$VaccineDeliveryStateImpl;

  @override
  bool get loading;
  @override
  List<String>? get availedVaccineDoseCodes;
  @override
  List<VaccineDeliveryDetails>? get currentVaccineDoseData;
  @override
  Set<String>? get nextVaccineDoseData;
  @override
  Set<String>? get filterVaccineDoseCodes;
  @override
  Set<String>? get additionalVaccineDoseCodes;
  @override
  @JsonKey(ignore: true)
  _$$VaccineDeliveryStateImplCopyWith<_$VaccineDeliveryStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
