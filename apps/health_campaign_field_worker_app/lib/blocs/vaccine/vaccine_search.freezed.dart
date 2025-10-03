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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectBeneficiaryClientReferenceId)
        handleTaskSearch,
    required TResult Function(
            int ageInMonths,
            List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)
        eligibleVaccinesSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectBeneficiaryClientReferenceId)?
        handleTaskSearch,
    TResult? Function(int ageInMonths, List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectBeneficiaryClientReferenceId)?
        handleTaskSearch,
    TResult Function(int ageInMonths, List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineTaskSearchEvent value) handleTaskSearch,
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccinesSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineTaskSearchEvent value)? handleTaskSearch,
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineTaskSearchEvent value)? handleTaskSearch,
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineSearchEventCopyWith<$Res> {
  factory $VaccineSearchEventCopyWith(
          VaccineSearchEvent value, $Res Function(VaccineSearchEvent) then) =
      _$VaccineSearchEventCopyWithImpl<$Res, VaccineSearchEvent>;
}

/// @nodoc
class _$VaccineSearchEventCopyWithImpl<$Res, $Val extends VaccineSearchEvent>
    implements $VaccineSearchEventCopyWith<$Res> {
  _$VaccineSearchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$VaccineTaskSearchEventImplCopyWith<$Res> {
  factory _$$VaccineTaskSearchEventImplCopyWith(
          _$VaccineTaskSearchEventImpl value,
          $Res Function(_$VaccineTaskSearchEventImpl) then) =
      __$$VaccineTaskSearchEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String projectBeneficiaryClientReferenceId});
}

/// @nodoc
class __$$VaccineTaskSearchEventImplCopyWithImpl<$Res>
    extends _$VaccineSearchEventCopyWithImpl<$Res, _$VaccineTaskSearchEventImpl>
    implements _$$VaccineTaskSearchEventImplCopyWith<$Res> {
  __$$VaccineTaskSearchEventImplCopyWithImpl(
      _$VaccineTaskSearchEventImpl _value,
      $Res Function(_$VaccineTaskSearchEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectBeneficiaryClientReferenceId = null,
  }) {
    return _then(_$VaccineTaskSearchEventImpl(
      projectBeneficiaryClientReferenceId: null ==
              projectBeneficiaryClientReferenceId
          ? _value.projectBeneficiaryClientReferenceId
          : projectBeneficiaryClientReferenceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VaccineTaskSearchEventImpl implements VaccineTaskSearchEvent {
  const _$VaccineTaskSearchEventImpl(
      {required this.projectBeneficiaryClientReferenceId});

  @override
  final String projectBeneficiaryClientReferenceId;

  @override
  String toString() {
    return 'VaccineSearchEvent.handleTaskSearch(projectBeneficiaryClientReferenceId: $projectBeneficiaryClientReferenceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineTaskSearchEventImpl &&
            (identical(other.projectBeneficiaryClientReferenceId,
                    projectBeneficiaryClientReferenceId) ||
                other.projectBeneficiaryClientReferenceId ==
                    projectBeneficiaryClientReferenceId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, projectBeneficiaryClientReferenceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineTaskSearchEventImplCopyWith<_$VaccineTaskSearchEventImpl>
      get copyWith => __$$VaccineTaskSearchEventImplCopyWithImpl<
          _$VaccineTaskSearchEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectBeneficiaryClientReferenceId)
        handleTaskSearch,
    required TResult Function(
            int ageInMonths,
            List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)
        eligibleVaccinesSearch,
  }) {
    return handleTaskSearch(projectBeneficiaryClientReferenceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectBeneficiaryClientReferenceId)?
        handleTaskSearch,
    TResult? Function(int ageInMonths, List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
  }) {
    return handleTaskSearch?.call(projectBeneficiaryClientReferenceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectBeneficiaryClientReferenceId)?
        handleTaskSearch,
    TResult Function(int ageInMonths, List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    required TResult orElse(),
  }) {
    if (handleTaskSearch != null) {
      return handleTaskSearch(projectBeneficiaryClientReferenceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineTaskSearchEvent value) handleTaskSearch,
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccinesSearch,
  }) {
    return handleTaskSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineTaskSearchEvent value)? handleTaskSearch,
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
  }) {
    return handleTaskSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineTaskSearchEvent value)? handleTaskSearch,
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
    required TResult orElse(),
  }) {
    if (handleTaskSearch != null) {
      return handleTaskSearch(this);
    }
    return orElse();
  }
}

abstract class VaccineTaskSearchEvent implements VaccineSearchEvent {
  const factory VaccineTaskSearchEvent(
          {required final String projectBeneficiaryClientReferenceId}) =
      _$VaccineTaskSearchEventImpl;

  String get projectBeneficiaryClientReferenceId;
  @JsonKey(ignore: true)
  _$$VaccineTaskSearchEventImplCopyWith<_$VaccineTaskSearchEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VaccineSearchEligibleVaccinesEventImplCopyWith<$Res> {
  factory _$$VaccineSearchEligibleVaccinesEventImplCopyWith(
          _$VaccineSearchEligibleVaccinesEventImpl value,
          $Res Function(_$VaccineSearchEligibleVaccinesEventImpl) then) =
      __$$VaccineSearchEligibleVaccinesEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int ageInMonths,
      List<VaccineDoseData> vaccineDataList,
      Map<String, dynamic> vaccineDoseDataVariation});
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
    Object? ageInMonths = null,
    Object? vaccineDataList = null,
    Object? vaccineDoseDataVariation = null,
  }) {
    return _then(_$VaccineSearchEligibleVaccinesEventImpl(
      ageInMonths: null == ageInMonths
          ? _value.ageInMonths
          : ageInMonths // ignore: cast_nullable_to_non_nullable
              as int,
      vaccineDataList: null == vaccineDataList
          ? _value._vaccineDataList
          : vaccineDataList // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>,
      vaccineDoseDataVariation: null == vaccineDoseDataVariation
          ? _value._vaccineDoseDataVariation
          : vaccineDoseDataVariation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$VaccineSearchEligibleVaccinesEventImpl
    implements VaccineSearchEligibleVaccinesEvent {
  const _$VaccineSearchEligibleVaccinesEventImpl(
      {required this.ageInMonths,
      required final List<VaccineDoseData> vaccineDataList,
      required final Map<String, dynamic> vaccineDoseDataVariation})
      : _vaccineDataList = vaccineDataList,
        _vaccineDoseDataVariation = vaccineDoseDataVariation;

  @override
  final int ageInMonths;
  final List<VaccineDoseData> _vaccineDataList;
  @override
  List<VaccineDoseData> get vaccineDataList {
    if (_vaccineDataList is EqualUnmodifiableListView) return _vaccineDataList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vaccineDataList);
  }

  final Map<String, dynamic> _vaccineDoseDataVariation;
  @override
  Map<String, dynamic> get vaccineDoseDataVariation {
    if (_vaccineDoseDataVariation is EqualUnmodifiableMapView)
      return _vaccineDoseDataVariation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_vaccineDoseDataVariation);
  }

  @override
  String toString() {
    return 'VaccineSearchEvent.eligibleVaccinesSearch(ageInMonths: $ageInMonths, vaccineDataList: $vaccineDataList, vaccineDoseDataVariation: $vaccineDoseDataVariation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchEligibleVaccinesEventImpl &&
            (identical(other.ageInMonths, ageInMonths) ||
                other.ageInMonths == ageInMonths) &&
            const DeepCollectionEquality()
                .equals(other._vaccineDataList, _vaccineDataList) &&
            const DeepCollectionEquality().equals(
                other._vaccineDoseDataVariation, _vaccineDoseDataVariation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      ageInMonths,
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
    required TResult Function(String projectBeneficiaryClientReferenceId)
        handleTaskSearch,
    required TResult Function(
            int ageInMonths,
            List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)
        eligibleVaccinesSearch,
  }) {
    return eligibleVaccinesSearch(
        ageInMonths, vaccineDataList, vaccineDoseDataVariation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectBeneficiaryClientReferenceId)?
        handleTaskSearch,
    TResult? Function(int ageInMonths, List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
  }) {
    return eligibleVaccinesSearch?.call(
        ageInMonths, vaccineDataList, vaccineDoseDataVariation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectBeneficiaryClientReferenceId)?
        handleTaskSearch,
    TResult Function(int ageInMonths, List<VaccineDoseData> vaccineDataList,
            Map<String, dynamic> vaccineDoseDataVariation)?
        eligibleVaccinesSearch,
    required TResult orElse(),
  }) {
    if (eligibleVaccinesSearch != null) {
      return eligibleVaccinesSearch(
          ageInMonths, vaccineDataList, vaccineDoseDataVariation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineTaskSearchEvent value) handleTaskSearch,
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccinesSearch,
  }) {
    return eligibleVaccinesSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineTaskSearchEvent value)? handleTaskSearch,
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
  }) {
    return eligibleVaccinesSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineTaskSearchEvent value)? handleTaskSearch,
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccinesSearch,
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
          {required final int ageInMonths,
          required final List<VaccineDoseData> vaccineDataList,
          required final Map<String, dynamic> vaccineDoseDataVariation}) =
      _$VaccineSearchEligibleVaccinesEventImpl;

  int get ageInMonths;
  List<VaccineDoseData> get vaccineDataList;
  Map<String, dynamic> get vaccineDoseDataVariation;
  @JsonKey(ignore: true)
  _$$VaccineSearchEligibleVaccinesEventImplCopyWith<
          _$VaccineSearchEligibleVaccinesEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VaccineSearchState {
  bool get loading => throw _privateConstructorUsedError;
  List<TaskModel>? get vaccineDeliveryDoseTasks =>
      throw _privateConstructorUsedError;
  List<String>? get availedVaccineDoseCodes =>
      throw _privateConstructorUsedError;
  List<String>? get allEligibleVaccineDoseCodes =>
      throw _privateConstructorUsedError;
  Map<int, Set<String>>? get allVaccinesDoseCodeByAgeIndex =>
      throw _privateConstructorUsedError;
  Map<int, Set<String>>? get eligibleVaccinesDoseCodeByAgeIndex =>
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
      List<TaskModel>? vaccineDeliveryDoseTasks,
      List<String>? availedVaccineDoseCodes,
      List<String>? allEligibleVaccineDoseCodes,
      Map<int, Set<String>>? allVaccinesDoseCodeByAgeIndex,
      Map<int, Set<String>>? eligibleVaccinesDoseCodeByAgeIndex});
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
    Object? vaccineDeliveryDoseTasks = freezed,
    Object? availedVaccineDoseCodes = freezed,
    Object? allEligibleVaccineDoseCodes = freezed,
    Object? allVaccinesDoseCodeByAgeIndex = freezed,
    Object? eligibleVaccinesDoseCodeByAgeIndex = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      vaccineDeliveryDoseTasks: freezed == vaccineDeliveryDoseTasks
          ? _value.vaccineDeliveryDoseTasks
          : vaccineDeliveryDoseTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>?,
      availedVaccineDoseCodes: freezed == availedVaccineDoseCodes
          ? _value.availedVaccineDoseCodes
          : availedVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      allEligibleVaccineDoseCodes: freezed == allEligibleVaccineDoseCodes
          ? _value.allEligibleVaccineDoseCodes
          : allEligibleVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      allVaccinesDoseCodeByAgeIndex: freezed == allVaccinesDoseCodeByAgeIndex
          ? _value.allVaccinesDoseCodeByAgeIndex
          : allVaccinesDoseCodeByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      eligibleVaccinesDoseCodeByAgeIndex: freezed ==
              eligibleVaccinesDoseCodeByAgeIndex
          ? _value.eligibleVaccinesDoseCodeByAgeIndex
          : eligibleVaccinesDoseCodeByAgeIndex // ignore: cast_nullable_to_non_nullable
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
      List<TaskModel>? vaccineDeliveryDoseTasks,
      List<String>? availedVaccineDoseCodes,
      List<String>? allEligibleVaccineDoseCodes,
      Map<int, Set<String>>? allVaccinesDoseCodeByAgeIndex,
      Map<int, Set<String>>? eligibleVaccinesDoseCodeByAgeIndex});
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
    Object? vaccineDeliveryDoseTasks = freezed,
    Object? availedVaccineDoseCodes = freezed,
    Object? allEligibleVaccineDoseCodes = freezed,
    Object? allVaccinesDoseCodeByAgeIndex = freezed,
    Object? eligibleVaccinesDoseCodeByAgeIndex = freezed,
  }) {
    return _then(_$VaccineSearchStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      vaccineDeliveryDoseTasks: freezed == vaccineDeliveryDoseTasks
          ? _value._vaccineDeliveryDoseTasks
          : vaccineDeliveryDoseTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>?,
      availedVaccineDoseCodes: freezed == availedVaccineDoseCodes
          ? _value._availedVaccineDoseCodes
          : availedVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      allEligibleVaccineDoseCodes: freezed == allEligibleVaccineDoseCodes
          ? _value._allEligibleVaccineDoseCodes
          : allEligibleVaccineDoseCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      allVaccinesDoseCodeByAgeIndex: freezed == allVaccinesDoseCodeByAgeIndex
          ? _value._allVaccinesDoseCodeByAgeIndex
          : allVaccinesDoseCodeByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      eligibleVaccinesDoseCodeByAgeIndex: freezed ==
              eligibleVaccinesDoseCodeByAgeIndex
          ? _value._eligibleVaccinesDoseCodeByAgeIndex
          : eligibleVaccinesDoseCodeByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
    ));
  }
}

/// @nodoc

class _$VaccineSearchStateImpl implements _VaccineSearchState {
  const _$VaccineSearchStateImpl(
      {this.loading = false,
      final List<TaskModel>? vaccineDeliveryDoseTasks,
      final List<String>? availedVaccineDoseCodes,
      final List<String>? allEligibleVaccineDoseCodes,
      final Map<int, Set<String>>? allVaccinesDoseCodeByAgeIndex,
      final Map<int, Set<String>>? eligibleVaccinesDoseCodeByAgeIndex})
      : _vaccineDeliveryDoseTasks = vaccineDeliveryDoseTasks,
        _availedVaccineDoseCodes = availedVaccineDoseCodes,
        _allEligibleVaccineDoseCodes = allEligibleVaccineDoseCodes,
        _allVaccinesDoseCodeByAgeIndex = allVaccinesDoseCodeByAgeIndex,
        _eligibleVaccinesDoseCodeByAgeIndex =
            eligibleVaccinesDoseCodeByAgeIndex;

  @override
  @JsonKey()
  final bool loading;
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

  final List<String>? _allEligibleVaccineDoseCodes;
  @override
  List<String>? get allEligibleVaccineDoseCodes {
    final value = _allEligibleVaccineDoseCodes;
    if (value == null) return null;
    if (_allEligibleVaccineDoseCodes is EqualUnmodifiableListView)
      return _allEligibleVaccineDoseCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<int, Set<String>>? _allVaccinesDoseCodeByAgeIndex;
  @override
  Map<int, Set<String>>? get allVaccinesDoseCodeByAgeIndex {
    final value = _allVaccinesDoseCodeByAgeIndex;
    if (value == null) return null;
    if (_allVaccinesDoseCodeByAgeIndex is EqualUnmodifiableMapView)
      return _allVaccinesDoseCodeByAgeIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<int, Set<String>>? _eligibleVaccinesDoseCodeByAgeIndex;
  @override
  Map<int, Set<String>>? get eligibleVaccinesDoseCodeByAgeIndex {
    final value = _eligibleVaccinesDoseCodeByAgeIndex;
    if (value == null) return null;
    if (_eligibleVaccinesDoseCodeByAgeIndex is EqualUnmodifiableMapView)
      return _eligibleVaccinesDoseCodeByAgeIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'VaccineSearchState(loading: $loading, vaccineDeliveryDoseTasks: $vaccineDeliveryDoseTasks, availedVaccineDoseCodes: $availedVaccineDoseCodes, allEligibleVaccineDoseCodes: $allEligibleVaccineDoseCodes, allVaccinesDoseCodeByAgeIndex: $allVaccinesDoseCodeByAgeIndex, eligibleVaccinesDoseCodeByAgeIndex: $eligibleVaccinesDoseCodeByAgeIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(
                other._vaccineDeliveryDoseTasks, _vaccineDeliveryDoseTasks) &&
            const DeepCollectionEquality().equals(
                other._availedVaccineDoseCodes, _availedVaccineDoseCodes) &&
            const DeepCollectionEquality().equals(
                other._allEligibleVaccineDoseCodes,
                _allEligibleVaccineDoseCodes) &&
            const DeepCollectionEquality().equals(
                other._allVaccinesDoseCodeByAgeIndex,
                _allVaccinesDoseCodeByAgeIndex) &&
            const DeepCollectionEquality().equals(
                other._eligibleVaccinesDoseCodeByAgeIndex,
                _eligibleVaccinesDoseCodeByAgeIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      const DeepCollectionEquality().hash(_vaccineDeliveryDoseTasks),
      const DeepCollectionEquality().hash(_availedVaccineDoseCodes),
      const DeepCollectionEquality().hash(_allEligibleVaccineDoseCodes),
      const DeepCollectionEquality().hash(_allVaccinesDoseCodeByAgeIndex),
      const DeepCollectionEquality().hash(_eligibleVaccinesDoseCodeByAgeIndex));

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
          final List<TaskModel>? vaccineDeliveryDoseTasks,
          final List<String>? availedVaccineDoseCodes,
          final List<String>? allEligibleVaccineDoseCodes,
          final Map<int, Set<String>>? allVaccinesDoseCodeByAgeIndex,
          final Map<int, Set<String>>? eligibleVaccinesDoseCodeByAgeIndex}) =
      _$VaccineSearchStateImpl;

  @override
  bool get loading;
  @override
  List<TaskModel>? get vaccineDeliveryDoseTasks;
  @override
  List<String>? get availedVaccineDoseCodes;
  @override
  List<String>? get allEligibleVaccineDoseCodes;
  @override
  Map<int, Set<String>>? get allVaccinesDoseCodeByAgeIndex;
  @override
  Map<int, Set<String>>? get eligibleVaccinesDoseCodeByAgeIndex;
  @override
  @JsonKey(ignore: true)
  _$$VaccineSearchStateImplCopyWith<_$VaccineSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
