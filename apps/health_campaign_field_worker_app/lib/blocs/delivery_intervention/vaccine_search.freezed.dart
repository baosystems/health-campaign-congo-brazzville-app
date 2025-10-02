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
    required TResult Function(int ageInDays, List<VaccineData>? vaccineDataList)
        eligibleVaccines,
    required TResult Function(String projectBeneficiaryClientReferenceId)
        handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int ageInDays, List<VaccineData>? vaccineDataList)?
        eligibleVaccines,
    TResult? Function(String projectBeneficiaryClientReferenceId)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int ageInDays, List<VaccineData>? vaccineDataList)?
        eligibleVaccines,
    TResult Function(String projectBeneficiaryClientReferenceId)? handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccines,
    required TResult Function(VaccineSearchTaskEvent value) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccines,
    TResult? Function(VaccineSearchTaskEvent value)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccines,
    TResult Function(VaccineSearchTaskEvent value)? handleSearch,
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
abstract class _$$VaccineSearchEligibleVaccinesEventImplCopyWith<$Res> {
  factory _$$VaccineSearchEligibleVaccinesEventImplCopyWith(
          _$VaccineSearchEligibleVaccinesEventImpl value,
          $Res Function(_$VaccineSearchEligibleVaccinesEventImpl) then) =
      __$$VaccineSearchEligibleVaccinesEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int ageInDays, List<VaccineData>? vaccineDataList});
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
  }) {
    return _then(_$VaccineSearchEligibleVaccinesEventImpl(
      ageInDays: null == ageInDays
          ? _value.ageInDays
          : ageInDays // ignore: cast_nullable_to_non_nullable
              as int,
      vaccineDataList: freezed == vaccineDataList
          ? _value._vaccineDataList
          : vaccineDataList // ignore: cast_nullable_to_non_nullable
              as List<VaccineData>?,
    ));
  }
}

/// @nodoc

class _$VaccineSearchEligibleVaccinesEventImpl
    implements VaccineSearchEligibleVaccinesEvent {
  const _$VaccineSearchEligibleVaccinesEventImpl(
      {required this.ageInDays,
      required final List<VaccineData>? vaccineDataList})
      : _vaccineDataList = vaccineDataList;

  @override
  final int ageInDays;
  final List<VaccineData>? _vaccineDataList;
  @override
  List<VaccineData>? get vaccineDataList {
    final value = _vaccineDataList;
    if (value == null) return null;
    if (_vaccineDataList is EqualUnmodifiableListView) return _vaccineDataList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VaccineSearchEvent.eligibleVaccines(ageInDays: $ageInDays, vaccineDataList: $vaccineDataList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchEligibleVaccinesEventImpl &&
            (identical(other.ageInDays, ageInDays) ||
                other.ageInDays == ageInDays) &&
            const DeepCollectionEquality()
                .equals(other._vaccineDataList, _vaccineDataList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ageInDays,
      const DeepCollectionEquality().hash(_vaccineDataList));

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
    required TResult Function(int ageInDays, List<VaccineData>? vaccineDataList)
        eligibleVaccines,
    required TResult Function(String projectBeneficiaryClientReferenceId)
        handleSearch,
  }) {
    return eligibleVaccines(ageInDays, vaccineDataList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int ageInDays, List<VaccineData>? vaccineDataList)?
        eligibleVaccines,
    TResult? Function(String projectBeneficiaryClientReferenceId)? handleSearch,
  }) {
    return eligibleVaccines?.call(ageInDays, vaccineDataList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int ageInDays, List<VaccineData>? vaccineDataList)?
        eligibleVaccines,
    TResult Function(String projectBeneficiaryClientReferenceId)? handleSearch,
    required TResult orElse(),
  }) {
    if (eligibleVaccines != null) {
      return eligibleVaccines(ageInDays, vaccineDataList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccines,
    required TResult Function(VaccineSearchTaskEvent value) handleSearch,
  }) {
    return eligibleVaccines(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccines,
    TResult? Function(VaccineSearchTaskEvent value)? handleSearch,
  }) {
    return eligibleVaccines?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccines,
    TResult Function(VaccineSearchTaskEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (eligibleVaccines != null) {
      return eligibleVaccines(this);
    }
    return orElse();
  }
}

abstract class VaccineSearchEligibleVaccinesEvent
    implements VaccineSearchEvent {
  const factory VaccineSearchEligibleVaccinesEvent(
          {required final int ageInDays,
          required final List<VaccineData>? vaccineDataList}) =
      _$VaccineSearchEligibleVaccinesEventImpl;

  int get ageInDays;
  List<VaccineData>? get vaccineDataList;
  @JsonKey(ignore: true)
  _$$VaccineSearchEligibleVaccinesEventImplCopyWith<
          _$VaccineSearchEligibleVaccinesEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VaccineSearchTaskEventImplCopyWith<$Res> {
  factory _$$VaccineSearchTaskEventImplCopyWith(
          _$VaccineSearchTaskEventImpl value,
          $Res Function(_$VaccineSearchTaskEventImpl) then) =
      __$$VaccineSearchTaskEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String projectBeneficiaryClientReferenceId});
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
  }) {
    return _then(_$VaccineSearchTaskEventImpl(
      projectBeneficiaryClientReferenceId: null ==
              projectBeneficiaryClientReferenceId
          ? _value.projectBeneficiaryClientReferenceId
          : projectBeneficiaryClientReferenceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VaccineSearchTaskEventImpl implements VaccineSearchTaskEvent {
  const _$VaccineSearchTaskEventImpl(
      {required this.projectBeneficiaryClientReferenceId});

  @override
  final String projectBeneficiaryClientReferenceId;

  @override
  String toString() {
    return 'VaccineSearchEvent.handleSearch(projectBeneficiaryClientReferenceId: $projectBeneficiaryClientReferenceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchTaskEventImpl &&
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
  _$$VaccineSearchTaskEventImplCopyWith<_$VaccineSearchTaskEventImpl>
      get copyWith => __$$VaccineSearchTaskEventImplCopyWithImpl<
          _$VaccineSearchTaskEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int ageInDays, List<VaccineData>? vaccineDataList)
        eligibleVaccines,
    required TResult Function(String projectBeneficiaryClientReferenceId)
        handleSearch,
  }) {
    return handleSearch(projectBeneficiaryClientReferenceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int ageInDays, List<VaccineData>? vaccineDataList)?
        eligibleVaccines,
    TResult? Function(String projectBeneficiaryClientReferenceId)? handleSearch,
  }) {
    return handleSearch?.call(projectBeneficiaryClientReferenceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int ageInDays, List<VaccineData>? vaccineDataList)?
        eligibleVaccines,
    TResult Function(String projectBeneficiaryClientReferenceId)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(projectBeneficiaryClientReferenceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineSearchEligibleVaccinesEvent value)
        eligibleVaccines,
    required TResult Function(VaccineSearchTaskEvent value) handleSearch,
  }) {
    return handleSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccines,
    TResult? Function(VaccineSearchTaskEvent value)? handleSearch,
  }) {
    return handleSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineSearchEligibleVaccinesEvent value)?
        eligibleVaccines,
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
          {required final String projectBeneficiaryClientReferenceId}) =
      _$VaccineSearchTaskEventImpl;

  String get projectBeneficiaryClientReferenceId;
  @JsonKey(ignore: true)
  _$$VaccineSearchTaskEventImplCopyWith<_$VaccineSearchTaskEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VaccineSearchState {
  bool get loading => throw _privateConstructorUsedError;
  TaskModel? get task => throw _privateConstructorUsedError;
  List<int>? get ageIndex => throw _privateConstructorUsedError;
  Map<int, Set<String>>? get vaccinesByAgeIndex =>
      throw _privateConstructorUsedError;
  Map<int, Set<String>>? get eligibleVaccinesByAgeIndex =>
      throw _privateConstructorUsedError;
  List<String>? get allVaccineCodes => throw _privateConstructorUsedError;
  List<String>? get selectedCodes => throw _privateConstructorUsedError;
  List<String>? get noSelectedCodes => throw _privateConstructorUsedError;

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
      TaskModel? task,
      List<int>? ageIndex,
      Map<int, Set<String>>? vaccinesByAgeIndex,
      Map<int, Set<String>>? eligibleVaccinesByAgeIndex,
      List<String>? allVaccineCodes,
      List<String>? selectedCodes,
      List<String>? noSelectedCodes});
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
    Object? task = freezed,
    Object? ageIndex = freezed,
    Object? vaccinesByAgeIndex = freezed,
    Object? eligibleVaccinesByAgeIndex = freezed,
    Object? allVaccineCodes = freezed,
    Object? selectedCodes = freezed,
    Object? noSelectedCodes = freezed,
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
      ageIndex: freezed == ageIndex
          ? _value.ageIndex
          : ageIndex // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      vaccinesByAgeIndex: freezed == vaccinesByAgeIndex
          ? _value.vaccinesByAgeIndex
          : vaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      eligibleVaccinesByAgeIndex: freezed == eligibleVaccinesByAgeIndex
          ? _value.eligibleVaccinesByAgeIndex
          : eligibleVaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      allVaccineCodes: freezed == allVaccineCodes
          ? _value.allVaccineCodes
          : allVaccineCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      selectedCodes: freezed == selectedCodes
          ? _value.selectedCodes
          : selectedCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      noSelectedCodes: freezed == noSelectedCodes
          ? _value.noSelectedCodes
          : noSelectedCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      TaskModel? task,
      List<int>? ageIndex,
      Map<int, Set<String>>? vaccinesByAgeIndex,
      Map<int, Set<String>>? eligibleVaccinesByAgeIndex,
      List<String>? allVaccineCodes,
      List<String>? selectedCodes,
      List<String>? noSelectedCodes});
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
    Object? task = freezed,
    Object? ageIndex = freezed,
    Object? vaccinesByAgeIndex = freezed,
    Object? eligibleVaccinesByAgeIndex = freezed,
    Object? allVaccineCodes = freezed,
    Object? selectedCodes = freezed,
    Object? noSelectedCodes = freezed,
  }) {
    return _then(_$VaccineSearchStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel?,
      ageIndex: freezed == ageIndex
          ? _value._ageIndex
          : ageIndex // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      vaccinesByAgeIndex: freezed == vaccinesByAgeIndex
          ? _value._vaccinesByAgeIndex
          : vaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      eligibleVaccinesByAgeIndex: freezed == eligibleVaccinesByAgeIndex
          ? _value._eligibleVaccinesByAgeIndex
          : eligibleVaccinesByAgeIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, Set<String>>?,
      allVaccineCodes: freezed == allVaccineCodes
          ? _value._allVaccineCodes
          : allVaccineCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      selectedCodes: freezed == selectedCodes
          ? _value._selectedCodes
          : selectedCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      noSelectedCodes: freezed == noSelectedCodes
          ? _value._noSelectedCodes
          : noSelectedCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$VaccineSearchStateImpl implements _VaccineSearchState {
  const _$VaccineSearchStateImpl(
      {this.loading = false,
      this.task,
      final List<int>? ageIndex,
      final Map<int, Set<String>>? vaccinesByAgeIndex,
      final Map<int, Set<String>>? eligibleVaccinesByAgeIndex,
      final List<String>? allVaccineCodes,
      final List<String>? selectedCodes,
      final List<String>? noSelectedCodes})
      : _ageIndex = ageIndex,
        _vaccinesByAgeIndex = vaccinesByAgeIndex,
        _eligibleVaccinesByAgeIndex = eligibleVaccinesByAgeIndex,
        _allVaccineCodes = allVaccineCodes,
        _selectedCodes = selectedCodes,
        _noSelectedCodes = noSelectedCodes;

  @override
  @JsonKey()
  final bool loading;
  @override
  final TaskModel? task;
  final List<int>? _ageIndex;
  @override
  List<int>? get ageIndex {
    final value = _ageIndex;
    if (value == null) return null;
    if (_ageIndex is EqualUnmodifiableListView) return _ageIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
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

  final List<String>? _allVaccineCodes;
  @override
  List<String>? get allVaccineCodes {
    final value = _allVaccineCodes;
    if (value == null) return null;
    if (_allVaccineCodes is EqualUnmodifiableListView) return _allVaccineCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _selectedCodes;
  @override
  List<String>? get selectedCodes {
    final value = _selectedCodes;
    if (value == null) return null;
    if (_selectedCodes is EqualUnmodifiableListView) return _selectedCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _noSelectedCodes;
  @override
  List<String>? get noSelectedCodes {
    final value = _noSelectedCodes;
    if (value == null) return null;
    if (_noSelectedCodes is EqualUnmodifiableListView) return _noSelectedCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VaccineSearchState(loading: $loading, task: $task, ageIndex: $ageIndex, vaccinesByAgeIndex: $vaccinesByAgeIndex, eligibleVaccinesByAgeIndex: $eligibleVaccinesByAgeIndex, allVaccineCodes: $allVaccineCodes, selectedCodes: $selectedCodes, noSelectedCodes: $noSelectedCodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineSearchStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.task, task) || other.task == task) &&
            const DeepCollectionEquality().equals(other._ageIndex, _ageIndex) &&
            const DeepCollectionEquality()
                .equals(other._vaccinesByAgeIndex, _vaccinesByAgeIndex) &&
            const DeepCollectionEquality().equals(
                other._eligibleVaccinesByAgeIndex,
                _eligibleVaccinesByAgeIndex) &&
            const DeepCollectionEquality()
                .equals(other._allVaccineCodes, _allVaccineCodes) &&
            const DeepCollectionEquality()
                .equals(other._selectedCodes, _selectedCodes) &&
            const DeepCollectionEquality()
                .equals(other._noSelectedCodes, _noSelectedCodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      task,
      const DeepCollectionEquality().hash(_ageIndex),
      const DeepCollectionEquality().hash(_vaccinesByAgeIndex),
      const DeepCollectionEquality().hash(_eligibleVaccinesByAgeIndex),
      const DeepCollectionEquality().hash(_allVaccineCodes),
      const DeepCollectionEquality().hash(_selectedCodes),
      const DeepCollectionEquality().hash(_noSelectedCodes));

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
      final TaskModel? task,
      final List<int>? ageIndex,
      final Map<int, Set<String>>? vaccinesByAgeIndex,
      final Map<int, Set<String>>? eligibleVaccinesByAgeIndex,
      final List<String>? allVaccineCodes,
      final List<String>? selectedCodes,
      final List<String>? noSelectedCodes}) = _$VaccineSearchStateImpl;

  @override
  bool get loading;
  @override
  TaskModel? get task;
  @override
  List<int>? get ageIndex;
  @override
  Map<int, Set<String>>? get vaccinesByAgeIndex;
  @override
  Map<int, Set<String>>? get eligibleVaccinesByAgeIndex;
  @override
  List<String>? get allVaccineCodes;
  @override
  List<String>? get selectedCodes;
  @override
  List<String>? get noSelectedCodes;
  @override
  @JsonKey(ignore: true)
  _$$VaccineSearchStateImplCopyWith<_$VaccineSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
