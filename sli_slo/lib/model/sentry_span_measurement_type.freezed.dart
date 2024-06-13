// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentry_span_measurement_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;


final _privateConstructorUsedError = UnsupportedError('It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SentrySpanMeasurementType {

 String get name => throw _privateConstructorUsedError; num get value => throw _privateConstructorUsedError; SentryMeasurementUnit? get unit => throw _privateConstructorUsedError;







@JsonKey(ignore: true)
$SentrySpanMeasurementTypeCopyWith<SentrySpanMeasurementType> get copyWith => throw _privateConstructorUsedError;

}

/// @nodoc
abstract class $SentrySpanMeasurementTypeCopyWith<$Res>  {
  factory $SentrySpanMeasurementTypeCopyWith(SentrySpanMeasurementType value, $Res Function(SentrySpanMeasurementType) then) = _$SentrySpanMeasurementTypeCopyWithImpl<$Res, SentrySpanMeasurementType>;
@useResult
$Res call({
 String name, num value, SentryMeasurementUnit? unit
});



}

/// @nodoc
class _$SentrySpanMeasurementTypeCopyWithImpl<$Res,$Val extends SentrySpanMeasurementType> implements $SentrySpanMeasurementTypeCopyWith<$Res> {
  _$SentrySpanMeasurementTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,Object? unit = freezed,}) {
  return _then(_value.copyWith(
name: null == name ? _value.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _value.value : value // ignore: cast_nullable_to_non_nullable
as num,unit: freezed == unit ? _value.unit : unit // ignore: cast_nullable_to_non_nullable
as SentryMeasurementUnit?,
  )as $Val);
}

}


/// @nodoc
abstract class _$$SentrySpanMeasurementTypeImplCopyWith<$Res> implements $SentrySpanMeasurementTypeCopyWith<$Res> {
  factory _$$SentrySpanMeasurementTypeImplCopyWith(_$SentrySpanMeasurementTypeImpl value, $Res Function(_$SentrySpanMeasurementTypeImpl) then) = __$$SentrySpanMeasurementTypeImplCopyWithImpl<$Res>;
@override @useResult
$Res call({
 String name, num value, SentryMeasurementUnit? unit
});



}

/// @nodoc
class __$$SentrySpanMeasurementTypeImplCopyWithImpl<$Res> extends _$SentrySpanMeasurementTypeCopyWithImpl<$Res, _$SentrySpanMeasurementTypeImpl> implements _$$SentrySpanMeasurementTypeImplCopyWith<$Res> {
  __$$SentrySpanMeasurementTypeImplCopyWithImpl(_$SentrySpanMeasurementTypeImpl _value, $Res Function(_$SentrySpanMeasurementTypeImpl) _then)
      : super(_value, _then);


@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,Object? unit = freezed,}) {
  return _then(_$SentrySpanMeasurementTypeImpl(
name: null == name ? _value.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _value.value : value // ignore: cast_nullable_to_non_nullable
as num,unit: freezed == unit ? _value.unit : unit // ignore: cast_nullable_to_non_nullable
as SentryMeasurementUnit?,
  ));
}


}

/// @nodoc


class _$SentrySpanMeasurementTypeImpl  implements _SentrySpanMeasurementType {
  const _$SentrySpanMeasurementTypeImpl({required this.name, required this.value, required this.unit});

  

@override final  String name;
@override final  num value;
@override final  SentryMeasurementUnit? unit;

@override
String toString() {
  return 'SentrySpanMeasurementType._create(name: $name, value: $value, unit: $unit)';
}


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _$SentrySpanMeasurementTypeImpl&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit));
}


@override
int get hashCode => Object.hash(runtimeType,name,value,unit);

@JsonKey(ignore: true)
@override
@pragma('vm:prefer-inline')
_$$SentrySpanMeasurementTypeImplCopyWith<_$SentrySpanMeasurementTypeImpl> get copyWith => __$$SentrySpanMeasurementTypeImplCopyWithImpl<_$SentrySpanMeasurementTypeImpl>(this, _$identity);








}


abstract class _SentrySpanMeasurementType implements SentrySpanMeasurementType {
  const factory _SentrySpanMeasurementType({required final  String name, required final  num value, required final  SentryMeasurementUnit? unit}) = _$SentrySpanMeasurementTypeImpl;
  

  

@override  String get name;@override  num get value;@override  SentryMeasurementUnit? get unit;
@override @JsonKey(ignore: true)
_$$SentrySpanMeasurementTypeImplCopyWith<_$SentrySpanMeasurementTypeImpl> get copyWith => throw _privateConstructorUsedError;

}
