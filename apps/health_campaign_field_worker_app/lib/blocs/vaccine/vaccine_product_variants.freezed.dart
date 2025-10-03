// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_product_variants.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VaccineProductVariantEvent {
  String get projectId => throw _privateConstructorUsedError;
  List<VaccineDoseData>? get vaccineDataList =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String projectId, List<VaccineDoseData>? vaccineDataList)
        load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId, List<VaccineDoseData>? vaccineDataList)?
        load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId, List<VaccineDoseData>? vaccineDataList)?
        load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineProductVariantLoadEvent value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineProductVariantLoadEvent value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineProductVariantLoadEvent value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VaccineProductVariantEventCopyWith<VaccineProductVariantEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineProductVariantEventCopyWith<$Res> {
  factory $VaccineProductVariantEventCopyWith(VaccineProductVariantEvent value,
          $Res Function(VaccineProductVariantEvent) then) =
      _$VaccineProductVariantEventCopyWithImpl<$Res,
          VaccineProductVariantEvent>;
  @useResult
  $Res call({String projectId, List<VaccineDoseData>? vaccineDataList});
}

/// @nodoc
class _$VaccineProductVariantEventCopyWithImpl<$Res,
        $Val extends VaccineProductVariantEvent>
    implements $VaccineProductVariantEventCopyWith<$Res> {
  _$VaccineProductVariantEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? vaccineDataList = freezed,
  }) {
    return _then(_value.copyWith(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineDataList: freezed == vaccineDataList
          ? _value.vaccineDataList
          : vaccineDataList // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VaccineProductVariantLoadEventImplCopyWith<$Res>
    implements $VaccineProductVariantEventCopyWith<$Res> {
  factory _$$VaccineProductVariantLoadEventImplCopyWith(
          _$VaccineProductVariantLoadEventImpl value,
          $Res Function(_$VaccineProductVariantLoadEventImpl) then) =
      __$$VaccineProductVariantLoadEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String projectId, List<VaccineDoseData>? vaccineDataList});
}

/// @nodoc
class __$$VaccineProductVariantLoadEventImplCopyWithImpl<$Res>
    extends _$VaccineProductVariantEventCopyWithImpl<$Res,
        _$VaccineProductVariantLoadEventImpl>
    implements _$$VaccineProductVariantLoadEventImplCopyWith<$Res> {
  __$$VaccineProductVariantLoadEventImplCopyWithImpl(
      _$VaccineProductVariantLoadEventImpl _value,
      $Res Function(_$VaccineProductVariantLoadEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? vaccineDataList = freezed,
  }) {
    return _then(_$VaccineProductVariantLoadEventImpl(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      vaccineDataList: freezed == vaccineDataList
          ? _value._vaccineDataList
          : vaccineDataList // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>?,
    ));
  }
}

/// @nodoc

class _$VaccineProductVariantLoadEventImpl
    implements VaccineProductVariantLoadEvent {
  const _$VaccineProductVariantLoadEventImpl(
      {required this.projectId,
      required final List<VaccineDoseData>? vaccineDataList})
      : _vaccineDataList = vaccineDataList;

  @override
  final String projectId;
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
    return 'VaccineProductVariantEvent.load(projectId: $projectId, vaccineDataList: $vaccineDataList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineProductVariantLoadEventImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            const DeepCollectionEquality()
                .equals(other._vaccineDataList, _vaccineDataList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectId,
      const DeepCollectionEquality().hash(_vaccineDataList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineProductVariantLoadEventImplCopyWith<
          _$VaccineProductVariantLoadEventImpl>
      get copyWith => __$$VaccineProductVariantLoadEventImplCopyWithImpl<
          _$VaccineProductVariantLoadEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String projectId, List<VaccineDoseData>? vaccineDataList)
        load,
  }) {
    return load(projectId, vaccineDataList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId, List<VaccineDoseData>? vaccineDataList)?
        load,
  }) {
    return load?.call(projectId, vaccineDataList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId, List<VaccineDoseData>? vaccineDataList)?
        load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(projectId, vaccineDataList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VaccineProductVariantLoadEvent value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VaccineProductVariantLoadEvent value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VaccineProductVariantLoadEvent value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class VaccineProductVariantLoadEvent
    implements VaccineProductVariantEvent {
  const factory VaccineProductVariantLoadEvent(
          {required final String projectId,
          required final List<VaccineDoseData>? vaccineDataList}) =
      _$VaccineProductVariantLoadEventImpl;

  @override
  String get projectId;
  @override
  List<VaccineDoseData>? get vaccineDataList;
  @override
  @JsonKey(ignore: true)
  _$$VaccineProductVariantLoadEventImplCopyWith<
          _$VaccineProductVariantLoadEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VaccineProductVariantState {
  bool? get loading => throw _privateConstructorUsedError;
  List<ProductVariantModel>? get productVariants =>
      throw _privateConstructorUsedError;
  List<VaccineDoseData>? get vaccineData => throw _privateConstructorUsedError;
  Map<String, dynamic>? get vaccineDoseDataVariation =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VaccineProductVariantStateCopyWith<VaccineProductVariantState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VaccineProductVariantStateCopyWith<$Res> {
  factory $VaccineProductVariantStateCopyWith(VaccineProductVariantState value,
          $Res Function(VaccineProductVariantState) then) =
      _$VaccineProductVariantStateCopyWithImpl<$Res,
          VaccineProductVariantState>;
  @useResult
  $Res call(
      {bool? loading,
      List<ProductVariantModel>? productVariants,
      List<VaccineDoseData>? vaccineData,
      Map<String, dynamic>? vaccineDoseDataVariation});
}

/// @nodoc
class _$VaccineProductVariantStateCopyWithImpl<$Res,
        $Val extends VaccineProductVariantState>
    implements $VaccineProductVariantStateCopyWith<$Res> {
  _$VaccineProductVariantStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = freezed,
    Object? productVariants = freezed,
    Object? vaccineData = freezed,
    Object? vaccineDoseDataVariation = freezed,
  }) {
    return _then(_value.copyWith(
      loading: freezed == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool?,
      productVariants: freezed == productVariants
          ? _value.productVariants
          : productVariants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>?,
      vaccineData: freezed == vaccineData
          ? _value.vaccineData
          : vaccineData // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>?,
      vaccineDoseDataVariation: freezed == vaccineDoseDataVariation
          ? _value.vaccineDoseDataVariation
          : vaccineDoseDataVariation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VaccineProductVariantStateImplCopyWith<$Res>
    implements $VaccineProductVariantStateCopyWith<$Res> {
  factory _$$VaccineProductVariantStateImplCopyWith(
          _$VaccineProductVariantStateImpl value,
          $Res Function(_$VaccineProductVariantStateImpl) then) =
      __$$VaccineProductVariantStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? loading,
      List<ProductVariantModel>? productVariants,
      List<VaccineDoseData>? vaccineData,
      Map<String, dynamic>? vaccineDoseDataVariation});
}

/// @nodoc
class __$$VaccineProductVariantStateImplCopyWithImpl<$Res>
    extends _$VaccineProductVariantStateCopyWithImpl<$Res,
        _$VaccineProductVariantStateImpl>
    implements _$$VaccineProductVariantStateImplCopyWith<$Res> {
  __$$VaccineProductVariantStateImplCopyWithImpl(
      _$VaccineProductVariantStateImpl _value,
      $Res Function(_$VaccineProductVariantStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = freezed,
    Object? productVariants = freezed,
    Object? vaccineData = freezed,
    Object? vaccineDoseDataVariation = freezed,
  }) {
    return _then(_$VaccineProductVariantStateImpl(
      loading: freezed == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool?,
      productVariants: freezed == productVariants
          ? _value._productVariants
          : productVariants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>?,
      vaccineData: freezed == vaccineData
          ? _value._vaccineData
          : vaccineData // ignore: cast_nullable_to_non_nullable
              as List<VaccineDoseData>?,
      vaccineDoseDataVariation: freezed == vaccineDoseDataVariation
          ? _value._vaccineDoseDataVariation
          : vaccineDoseDataVariation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$VaccineProductVariantStateImpl implements _VaccineProductVariantState {
  const _$VaccineProductVariantStateImpl(
      {this.loading,
      final List<ProductVariantModel>? productVariants,
      final List<VaccineDoseData>? vaccineData,
      final Map<String, dynamic>? vaccineDoseDataVariation})
      : _productVariants = productVariants,
        _vaccineData = vaccineData,
        _vaccineDoseDataVariation = vaccineDoseDataVariation;

  @override
  final bool? loading;
  final List<ProductVariantModel>? _productVariants;
  @override
  List<ProductVariantModel>? get productVariants {
    final value = _productVariants;
    if (value == null) return null;
    if (_productVariants is EqualUnmodifiableListView) return _productVariants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<VaccineDoseData>? _vaccineData;
  @override
  List<VaccineDoseData>? get vaccineData {
    final value = _vaccineData;
    if (value == null) return null;
    if (_vaccineData is EqualUnmodifiableListView) return _vaccineData;
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
    return 'VaccineProductVariantState(loading: $loading, productVariants: $productVariants, vaccineData: $vaccineData, vaccineDoseDataVariation: $vaccineDoseDataVariation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VaccineProductVariantStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality()
                .equals(other._productVariants, _productVariants) &&
            const DeepCollectionEquality()
                .equals(other._vaccineData, _vaccineData) &&
            const DeepCollectionEquality().equals(
                other._vaccineDoseDataVariation, _vaccineDoseDataVariation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      const DeepCollectionEquality().hash(_productVariants),
      const DeepCollectionEquality().hash(_vaccineData),
      const DeepCollectionEquality().hash(_vaccineDoseDataVariation));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VaccineProductVariantStateImplCopyWith<_$VaccineProductVariantStateImpl>
      get copyWith => __$$VaccineProductVariantStateImplCopyWithImpl<
          _$VaccineProductVariantStateImpl>(this, _$identity);
}

abstract class _VaccineProductVariantState
    implements VaccineProductVariantState {
  const factory _VaccineProductVariantState(
          {final bool? loading,
          final List<ProductVariantModel>? productVariants,
          final List<VaccineDoseData>? vaccineData,
          final Map<String, dynamic>? vaccineDoseDataVariation}) =
      _$VaccineProductVariantStateImpl;

  @override
  bool? get loading;
  @override
  List<ProductVariantModel>? get productVariants;
  @override
  List<VaccineDoseData>? get vaccineData;
  @override
  Map<String, dynamic>? get vaccineDoseDataVariation;
  @override
  @JsonKey(ignore: true)
  _$$VaccineProductVariantStateImplCopyWith<_$VaccineProductVariantStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
