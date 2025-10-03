// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VaccineSearchEvent {
  int get ageInDays => throw _privateConstructorUsedError;
  List<VaccineDoseData>? get vaccineDataList =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int ageInDays,
            List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)
        eligibleVaccinesSearch,
    required TResult Function(String projectBeneficiaryClientReferenceId,
            int ageInDays, List<VaccineDoseData>? vaccineDataList)
        handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int ageInDays, List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    TResult? Function(String projectBeneficiaryClientReferenceId, int ageInDays,
            List<VaccineDoseData>? vaccineDataList)?
        handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int ageInDays, List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    TResult Function(String projectBeneficiaryClientReferenceId, int ageInDays,
            List<VaccineDoseData>? vaccineDataList)?
        handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccinesSearch,
    required TResult Function(VaccineSearchTaskEvent value) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    TResult? Function(VaccineSearchTaskEvent value)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    TResult Function(VaccineSearchTaskEvent value)? handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VaccineSearchEventCopyWith<VaccineSearchEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineSearchEventCopyWith<$Res> {
  factory $VaccineSearchEventCopyWith(
          VaccineSearchEvent value, $Res Function(VaccineSearchEvent) then) =
      _$VaccineSearchEventCopyWithImpl<$Res, VaccineSearchEvent>;
  @useResult
  $Res call({int ageInDays, List<VaccineDoseData>? vaccineDataList});
}

/// @nodoc
class _$VaccineSearchEventCopyWithImpl<$Res, $Val extends VaccineSearchEvent>
    implements $VaccineSearchEventCopyWith<$Res> {
  _$VaccineSearchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ageInDays = null,
    Object? vaccineDataList = freezed,
  }) {
    return _then(_value.copyWith(
      ageInDays: null == ageInDays
          ? _value.ageInDays
          : ageInDays // ignore: cast_nullable_to_non_nullable
              as int,
      vaccineDataList: freezed == vaccineDataList
          ? _value.vaccineDataList
          : vaccineDataList // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VaccineSearchEligibleVaccinesEventImplCopyWith<$Res>
    implements $VaccineSearchEventCopyWith<$Res> {
  factory _$$VaccineSearchEligibleVaccinesEventImplCopyWith(
          _$VaccineSearchEligibleVaccinesEventImpl value,
          $Res Function(_$VaccineSearchEligibleVaccinesEventImpl) then) =
      __$$VaccineSearchEligibleVaccinesEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int ageInDays,
      List<VaccineDoseData>? vaccineDataList,
      Map<String, dynamic>? vaccineDoseDataVariation});
}

/// @nodoc
class __$$VaccineSearchEligibleVaccinesEventImplCopyWithImpl<$Res>
    extends _$VaccineSearchEventCopyWithImpl<$Res,
        _$VaccineSearchEligibleVaccinesEventImpl>
    implements _$$VaccineSearchEligibleVaccinesEventImplCopyWith<$Res> {
  __$$VaccineSearchEligibleVaccinesEventImplCopyWithImpl(
      _$VaccineSearchEligibleVaccinesEventImpl _value,
      $Res Function(_$VaccineSearchEligibleVaccinesEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ageInDays = null,
    Object? vaccineDataList = freezed,
    Object? vaccineDoseDataVariation = freezed,
  }) {
    return _then(_$VaccineSearchEligibleVaccinesEventImpl(
      ageInDays: null == ageInDays
          ? _value.ageInDays
          : ageInDays // ignore: cast_nullable_to_non_nullable
              as int,
      vaccineDataList: freezed == vaccineDataList
          ? _value._vaccineDataList
          : vaccineDataList // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>?,
      vaccineDoseDataVariation: freezed == vaccineDoseDataVariation
          ? _value._vaccineDoseDataVariation
          : vaccineDoseDataVariation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$VaccineSearchEligibleVaccinesEventImpl
    implements VaccineSearchEligibleVaccinesEvent {
  const _$VaccineSearchEligibleVaccinesEventImpl(
      {required this.ageInDays,
      required final List<VaccineDoseData>? vaccineDataList,
      required final Map<String, dynamic>? vaccineDoseDataVariation})
      : _vaccineDataList = vaccineDataList,
        _vaccineDoseDataVariation = vaccineDoseDataVariation;

  @override
  final int ageInDays;
  final List<VaccineDoseData>? _vaccineDataList;
  @override
  List<VaccineDoseData>? get vaccineDataList {
    final value = _vaccineDataList;
    if (value == null) return null;
    if (_vaccineDataList is EqualUnmodifiableListView) return _vaccineDataList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _vaccineDoseDataVariation;
  @override
  Map<String, dynamic>? get vaccineDoseDataVariation {
    final value = _vaccineDoseDataVariation;
    if (value == null) return null;
    if (_vaccineDoseDataVariation is EqualUnmodifiableMapView)
      return _vaccineDoseDataVariation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'VaccineSearchEvent.eligibleVaccinesSearch(ageInDays: $ageInDays, vaccineDataList: $vaccineDataList, vaccineDoseDataVariation: $vaccineDoseDataVariation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchEligibleVaccinesEventImpl &&
            (identical(other.ageInDays, ageInDays) ||
                other.ageInDays == ageInDays) &&
            const DeepCollectionEquality()
                .equals(other._vaccineDataList, _vaccineDataList) &&
            const DeepCollectionEquality().equals(
                other._vaccineDoseDataVariation, _vaccineDoseDataVariation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      ageInDays,
      const DeepCollectionEquality().hash(_vaccineDataList),
      const DeepCollectionEquality().hash(_vaccineDoseDataVariation));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineSearchEligibleVaccinesEventImplCopyWith<
          _$VaccineSearchEligibleVaccinesEventImpl>
      get copyWith => __$$VaccineSearchEligibleVaccinesEventImplCopyWithImpl<
          _$VaccineSearchEligibleVaccinesEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int ageInDays,
            List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)
        eligibleVaccinesSearch,
    required TResult Function(String projectBeneficiaryClientReferenceId,
            int ageInDays, List<VaccineDoseData>? vaccineDataList)
        handleSearch,
  }) {
    return eligibleVaccinesSearch(
        ageInDays, vaccineDataList, vaccineDoseDataVariation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int ageInDays, List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    TResult? Function(String projectBeneficiaryClientReferenceId, int ageInDays,
            List<VaccineDoseData>? vaccineDataList)?
        handleSearch,
  }) {
    return eligibleVaccinesSearch?.call(
        ageInDays, vaccineDataList, vaccineDoseDataVariation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int ageInDays, List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    TResult Function(String projectBeneficiaryClientReferenceId, int ageInDays,
            List<VaccineDoseData>? vaccineDataList)?
        handleSearch,
    required TResult orElse(),
  }) {
    if (eligibleVaccinesSearch != null) {
      return eligibleVaccinesSearch(
          ageInDays, vaccineDataList, vaccineDoseDataVariation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccinesSearch,
    required TResult Function(VaccineSearchTaskEvent value) handleSearch,
  }) {
    return eligibleVaccinesSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    TResult? Function(VaccineSearchTaskEvent value)? handleSearch,
  }) {
    return eligibleVaccinesSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    TResult Function(VaccineSearchTaskEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (eligibleVaccinesSearch != null) {
      return eligibleVaccinesSearch(this);
    }
    return orElse();
  }
}

abstract class VaccineSearchEligibleVaccinesEvent
    implements VaccineSearchEvent {
  const factory VaccineSearchEligibleVaccinesEvent(
          {required final int ageInDays,
          required final List<VaccineDoseData>? vaccineDataList,
          required final Map<String, dynamic>? vaccineDoseDataVariation}) =
      _$VaccineSearchEligibleVaccinesEventImpl;

  @override
  int get ageInDays;
  @override
  List<VaccineDoseData>? get vaccineDataList;
  Map<String, dynamic>? get vaccineDoseDataVariation;
  @override
  @JsonKey(ignore: true)
  _$$VaccineSearchEligibleVaccinesEventImplCopyWith<
          _$VaccineSearchEligibleVaccinesEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VaccineSearchTaskEventImplCopyWith<$Res>
    implements $VaccineSearchEventCopyWith<$Res> {
  factory _$$VaccineSearchTaskEventImplCopyWith(
          _$VaccineSearchTaskEventImpl value,
          $Res Function(_$VaccineSearchTaskEventImpl) then) =
      __$$VaccineSearchTaskEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String projectBeneficiaryClientReferenceId,
      int ageInDays,
      List<VaccineDoseData>? vaccineDataList});
}

/// @nodoc
class __$$VaccineSearchTaskEventImplCopyWithImpl<$Res>
    extends _$VaccineSearchEventCopyWithImpl<$Res, _$VaccineSearchTaskEventImpl>
    implements _$$VaccineSearchTaskEventImplCopyWith<$Res> {
  __$$VaccineSearchTaskEventImplCopyWithImpl(
      _$VaccineSearchTaskEventImpl _value,
      $Res Function(_$VaccineSearchTaskEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectBeneficiaryClientReferenceId = null,
    Object? ageInDays = null,
    Object? vaccineDataList = freezed,
  }) {
    return _then(_$VaccineSearchTaskEventImpl(
      projectBeneficiaryClientReferenceId: null ==
              projectBeneficiaryClientReferenceId
          ? _value.projectBeneficiaryClientReferenceId
          : projectBeneficiaryClientReferenceId // ignore: cast_nullable_to_non_nullable
              as String,
      ageInDays: null == ageInDays
          ? _value.ageInDays
          : ageInDays // ignore: cast_nullable_to_non_nullable
              as int,
      vaccineDataList: freezed == vaccineDataList
          ? _value._vaccineDataList
          : vaccineDataList // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>?,
    ));
  }
}

/// @nodoc

class _$VaccineSearchTaskEventImpl implements VaccineSearchTaskEvent {
  const _$VaccineSearchTaskEventImpl(
      {required this.projectBeneficiaryClientReferenceId,
      required this.ageInDays,
      required final List<VaccineDoseData>? vaccineDataList})
      : _vaccineDataList = vaccineDataList;

  @override
  final String projectBeneficiaryClientReferenceId;
  @override
  final int ageInDays;
  final List<VaccineDoseData>? _vaccineDataList;
  @override
  List<VaccineDoseData>? get vaccineDataList {
    final value = _vaccineDataList;
    if (value == null) return null;
    if (_vaccineDataList is EqualUnmodifiableListView) return _vaccineDataList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VaccineSearchEvent.handleSearch(projectBeneficiaryClientReferenceId: $projectBeneficiaryClientReferenceId, ageInDays: $ageInDays, vaccineDataList: $vaccineDataList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchTaskEventImpl &&
            (identical(other.projectBeneficiaryClientReferenceId,
                    projectBeneficiaryClientReferenceId) ||
                other.projectBeneficiaryClientReferenceId ==
                    projectBeneficiaryClientReferenceId) &&
            (identical(other.ageInDays, ageInDays) ||
                other.ageInDays == ageInDays) &&
            const DeepCollectionEquality()
                .equals(other._vaccineDataList, _vaccineDataList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectBeneficiaryClientReferenceId,
      ageInDays,
      const DeepCollectionEquality().hash(_vaccineDataList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineSearchTaskEventImplCopyWith<_$VaccineSearchTaskEventImpl>
      get copyWith => __$$VaccineSearchTaskEventImplCopyWithImpl<
          _$VaccineSearchTaskEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int ageInDays,
            List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)
        eligibleVaccinesSearch,
    required TResult Function(String projectBeneficiaryClientReferenceId,
            int ageInDays, List<VaccineDoseData>? vaccineDataList)
        handleSearch,
  }) {
    return handleSearch(
        projectBeneficiaryClientReferenceId, ageInDays, vaccineDataList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int ageInDays, List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    TResult? Function(String projectBeneficiaryClientReferenceId, int ageInDays,
            List<VaccineDoseData>? vaccineDataList)?
        handleSearch,
  }) {
    return handleSearch?.call(
        projectBeneficiaryClientReferenceId, ageInDays, vaccineDataList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int ageInDays, List<VaccineDoseData>? vaccineDataList,
            Map<String, dynamic>? vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    TResult Function(String projectBeneficiaryClientReferenceId, int ageInDays,
            List<VaccineDoseData>? vaccineDataList)?
        handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(
          projectBeneficiaryClientReferenceId, ageInDays, vaccineDataList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccinesSearch,
    required TResult Function(VaccineSearchTaskEvent value) handleSearch,
  }) {
    return handleSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    TResult? Function(VaccineSearchTaskEvent value)? handleSearch,
  }) {
    return handleSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    TResult Function(VaccineSearchTaskEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(this);
    }
    return orElse();
  }
}

abstract class VaccineSearchTaskEvent implements VaccineSearchEvent {
  const factory VaccineSearchTaskEvent(
          {required final String projectBeneficiaryClientReferenceId,
          required final int ageInDays,
          required final List<VaccineDoseData>? vaccineDataList}) =
      _$VaccineSearchTaskEventImpl;

  String get projectBeneficiaryClientReferenceId;
  @override
  int get ageInDays;
  @override
  List<VaccineDoseData>? get vaccineDataList;
  @override
  @JsonKey(ignore: true)
  _$$VaccineSearchTaskEventImplCopyWith<_$VaccineSearchTaskEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VaccineSearchState {
  bool get loading => throw _privateConstructorUsedError;
  List<String>? get availedVaccines => throw _privateConstructorUsedError;
  List<TaskModel>? get vaccineDeliveryDoseTasks =>
      throw _privateConstructorUsedError;
  List<int>? get ageIndex => throw _privateConstructorUsedError;
  Map<int, Set<String>>? get vaccineDoseList =>
      throw _privateConstructorUsedError;
  Map<int, Set<String>>? get vaccinesByAgeIndex =>
      throw _privateConstructorUsedError;
  Map<int, Set<String>>? get eligibleVaccinesByAgeIndex =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VaccineSearchStateCopyWith<VaccineSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineSearchStateCopyWith<$Res> {
  factory $VaccineSearchStateCopyWith(
          VaccineSearchState value, $Res Function(VaccineSearchState) then) =
      _$VaccineSearchStateCopyWithImpl<$Res, VaccineSearchState>;
  @useResult
  $Res call(
      {bool loading,
      List<String>? availedVaccines,
      List<TaskModel>? vaccineDeliveryDoseTasks,
      List<int>? ageIndex,
      Map<int, Set<String>>? vaccineDoseList,
      Map<int, Set<String>>? vaccinesByAgeIndex,
      Map<int, Set<String>>? eligibleVaccinesByAgeIndex});
}

/// @nodoc
class _$VaccineSearchStateCopyWithImpl<$Res, $Val extends VaccineSearchState>
    implements $VaccineSearchStateCopyWith<$Res> {
  _$VaccineSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? availedVaccines = freezed,
    Object? vaccineDeliveryDoseTasks = freezed,
    Object? ageIndex = freezed,
    Object? vaccineDoseList = freezed,
    Object? vaccinesByAgeIndex = freezed,
    Object? eligibleVaccinesByAgeIndex = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      availedVaccines: freezed == availedVaccines
          ? _value.availedVaccines
          : availedVaccines // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      vaccineDeliveryDoseTasks: freezed == vaccineDeliveryDoseTasks
          ? _value.vaccineDeliveryDoseTasks
          : vaccineDeliveryDoseTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>?,
      ageIndex: freezed == ageIndex
          ? _value.ageIndex
          : ageIndex // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      vaccineDoseList: freezed == vaccineDoseList
          ? _value.vaccineDoseList
          : vaccineDoseList // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      vaccinesByAgeIndex: freezed == vaccinesByAgeIndex
          ? _value.vaccinesByAgeIndex
          : vaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      eligibleVaccinesByAgeIndex: freezed == eligibleVaccinesByAgeIndex
          ? _value.eligibleVaccinesByAgeIndex
          : eligibleVaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VaccineSearchStateImplCopyWith<$Res>
    implements $VaccineSearchStateCopyWith<$Res> {
  factory _$$VaccineSearchStateImplCopyWith(_$VaccineSearchStateImpl value,
          $Res Function(_$VaccineSearchStateImpl) then) =
      __$$VaccineSearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      List<String>? availedVaccines,
      List<TaskModel>? vaccineDeliveryDoseTasks,
      List<int>? ageIndex,
      Map<int, Set<String>>? vaccineDoseList,
      Map<int, Set<String>>? vaccinesByAgeIndex,
      Map<int, Set<String>>? eligibleVaccinesByAgeIndex});
}

/// @nodoc
class __$$VaccineSearchStateImplCopyWithImpl<$Res>
    extends _$VaccineSearchStateCopyWithImpl<$Res, _$VaccineSearchStateImpl>
    implements _$$VaccineSearchStateImplCopyWith<$Res> {
  __$$VaccineSearchStateImplCopyWithImpl(_$VaccineSearchStateImpl _value,
      $Res Function(_$VaccineSearchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? availedVaccines = freezed,
    Object? vaccineDeliveryDoseTasks = freezed,
    Object? ageIndex = freezed,
    Object? vaccineDoseList = freezed,
    Object? vaccinesByAgeIndex = freezed,
    Object? eligibleVaccinesByAgeIndex = freezed,
  }) {
    return _then(_$VaccineSearchStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      availedVaccines: freezed == availedVaccines
          ? _value._availedVaccines
          : availedVaccines // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      vaccineDeliveryDoseTasks: freezed == vaccineDeliveryDoseTasks
          ? _value._vaccineDeliveryDoseTasks
          : vaccineDeliveryDoseTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>?,
      ageIndex: freezed == ageIndex
          ? _value._ageIndex
          : ageIndex // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      vaccineDoseList: freezed == vaccineDoseList
          ? _value._vaccineDoseList
          : vaccineDoseList // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      vaccinesByAgeIndex: freezed == vaccinesByAgeIndex
          ? _value._vaccinesByAgeIndex
          : vaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      eligibleVaccinesByAgeIndex: freezed == eligibleVaccinesByAgeIndex
          ? _value._eligibleVaccinesByAgeIndex
          : eligibleVaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
    ));
  }
}

/// @nodoc

class _$VaccineSearchStateImpl implements _VaccineSearchState {
  const _$VaccineSearchStateImpl(
      {this.loading = false,
      final List<String>? availedVaccines,
      final List<TaskModel>? vaccineDeliveryDoseTasks,
      final List<int>? ageIndex,
      final Map<int, Set<String>>? vaccineDoseList,
      final Map<int, Set<String>>? vaccinesByAgeIndex,
      final Map<int, Set<String>>? eligibleVaccinesByAgeIndex})
      : _availedVaccines = availedVaccines,
        _vaccineDeliveryDoseTasks = vaccineDeliveryDoseTasks,
        _ageIndex = ageIndex,
        _vaccineDoseList = vaccineDoseList,
        _vaccinesByAgeIndex = vaccinesByAgeIndex,
        _eligibleVaccinesByAgeIndex = eligibleVaccinesByAgeIndex;

  @override
  @JsonKey()
  final bool loading;
  final List<String>? _availedVaccines;
  @override
  List<String>? get availedVaccines {
    final value = _availedVaccines;
    if (value == null) return null;
    if (_availedVaccines is EqualUnmodifiableListView) return _availedVaccines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TaskModel>? _vaccineDeliveryDoseTasks;
  @override
  List<TaskModel>? get vaccineDeliveryDoseTasks {
    final value = _vaccineDeliveryDoseTasks;
    if (value == null) return null;
    if (_vaccineDeliveryDoseTasks is EqualUnmodifiableListView)
      return _vaccineDeliveryDoseTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _ageIndex;
  @override
  List<int>? get ageIndex {
    final value = _ageIndex;
    if (value == null) return null;
    if (_ageIndex is EqualUnmodifiableListView) return _ageIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<int, Set<String>>? _vaccineDoseList;
  @override
  Map<int, Set<String>>? get vaccineDoseList {
    final value = _vaccineDoseList;
    if (value == null) return null;
    if (_vaccineDoseList is EqualUnmodifiableMapView) return _vaccineDoseList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<int, Set<String>>? _vaccinesByAgeIndex;
  @override
  Map<int, Set<String>>? get vaccinesByAgeIndex {
    final value = _vaccinesByAgeIndex;
    if (value == null) return null;
    if (_vaccinesByAgeIndex is EqualUnmodifiableMapView)
      return _vaccinesByAgeIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<int, Set<String>>? _eligibleVaccinesByAgeIndex;
  @override
  Map<int, Set<String>>? get eligibleVaccinesByAgeIndex {
    final value = _eligibleVaccinesByAgeIndex;
    if (value == null) return null;
    if (_eligibleVaccinesByAgeIndex is EqualUnmodifiableMapView)
      return _eligibleVaccinesByAgeIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'VaccineSearchState(loading: $loading, availedVaccines: $availedVaccines, vaccineDeliveryDoseTasks: $vaccineDeliveryDoseTasks, ageIndex: $ageIndex, vaccineDoseList: $vaccineDoseList, vaccinesByAgeIndex: $vaccinesByAgeIndex, eligibleVaccinesByAgeIndex: $eligibleVaccinesByAgeIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality()
                .equals(other._availedVaccines, _availedVaccines) &&
            const DeepCollectionEquality().equals(
                other._vaccineDeliveryDoseTasks, _vaccineDeliveryDoseTasks) &&
            const DeepCollectionEquality().equals(other._ageIndex, _ageIndex) &&
            const DeepCollectionEquality()
                .equals(other._vaccineDoseList, _vaccineDoseList) &&
            const DeepCollectionEquality()
                .equals(other._vaccinesByAgeIndex, _vaccinesByAgeIndex) &&
            const DeepCollectionEquality().equals(
                other._eligibleVaccinesByAgeIndex,
                _eligibleVaccinesByAgeIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      const DeepCollectionEquality().hash(_availedVaccines),
      const DeepCollectionEquality().hash(_vaccineDeliveryDoseTasks),
      const DeepCollectionEquality().hash(_ageIndex),
      const DeepCollectionEquality().hash(_vaccineDoseList),
      const DeepCollectionEquality().hash(_vaccinesByAgeIndex),
      const DeepCollectionEquality().hash(_eligibleVaccinesByAgeIndex));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineSearchStateImplCopyWith<_$VaccineSearchStateImpl> get copyWith =>
      __$$VaccineSearchStateImplCopyWithImpl<_$VaccineSearchStateImpl>(
          this, _$identity);
}

abstract class _VaccineSearchState implements VaccineSearchState {
  const factory _VaccineSearchState(
          {final bool loading,
          final List<String>? availedVaccines,
          final List<TaskModel>? vaccineDeliveryDoseTasks,
          final List<int>? ageIndex,
          final Map<int, Set<String>>? vaccineDoseList,
          final Map<int, Set<String>>? vaccinesByAgeIndex,
          final Map<int, Set<String>>? eligibleVaccinesByAgeIndex}) =
      _$VaccineSearchStateImpl;

  @override
  bool get loading;
  @override
  List<String>? get availedVaccines;
  @override
  List<TaskModel>? get vaccineDeliveryDoseTasks;
  @override
  List<int>? get ageIndex;
  @override
  Map<int, Set<String>>? get vaccineDoseList;
  @override
  Map<int, Set<String>>? get vaccinesByAgeIndex;
  @override
  Map<int, Set<String>>? get eligibleVaccinesByAgeIndex;
  @override
  @JsonKey(ignore: true)
  _$$VaccineSearchStateImplCopyWith<_$VaccineSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
