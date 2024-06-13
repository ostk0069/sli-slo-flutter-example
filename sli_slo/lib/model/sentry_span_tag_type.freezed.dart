// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentry_span_tag_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;


final _privateConstructorUsedError = UnsupportedError('It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SentrySpanTagType {

 String get key => throw _privateConstructorUsedError; String get value => throw _privateConstructorUsedError;







@JsonKey(ignore: true)
$SentrySpanTagTypeCopyWith<SentrySpanTagType> get copyWith => throw _privateConstructorUsedError;

}

/// @nodoc
abstract class $SentrySpanTagTypeCopyWith<$Res>  {
  factory $SentrySpanTagTypeCopyWith(SentrySpanTagType value, $Res Function(SentrySpanTagType) then) = _$SentrySpanTagTypeCopyWithImpl<$Res, SentrySpanTagType>;
@useResult
$Res call({
 String key, String value
});



}

/// @nodoc
class _$SentrySpanTagTypeCopyWithImpl<$Res,$Val extends SentrySpanTagType> implements $SentrySpanTagTypeCopyWith<$Res> {
  _$SentrySpanTagTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? value = null,}) {
  return _then(_value.copyWith(
key: null == key ? _value.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _value.value : value // ignore: cast_nullable_to_non_nullable
as String,
  )as $Val);
}

}


/// @nodoc
abstract class _$$SentrySpanTagTypeImplCopyWith<$Res> implements $SentrySpanTagTypeCopyWith<$Res> {
  factory _$$SentrySpanTagTypeImplCopyWith(_$SentrySpanTagTypeImpl value, $Res Function(_$SentrySpanTagTypeImpl) then) = __$$SentrySpanTagTypeImplCopyWithImpl<$Res>;
@override @useResult
$Res call({
 String key, String value
});



}

/// @nodoc
class __$$SentrySpanTagTypeImplCopyWithImpl<$Res> extends _$SentrySpanTagTypeCopyWithImpl<$Res, _$SentrySpanTagTypeImpl> implements _$$SentrySpanTagTypeImplCopyWith<$Res> {
  __$$SentrySpanTagTypeImplCopyWithImpl(_$SentrySpanTagTypeImpl _value, $Res Function(_$SentrySpanTagTypeImpl) _then)
      : super(_value, _then);


@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? value = null,}) {
  return _then(_$SentrySpanTagTypeImpl(
key: null == key ? _value.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _value.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _$SentrySpanTagTypeImpl  implements _SentrySpanTagType {
  const _$SentrySpanTagTypeImpl({required this.key, required this.value});

  

@override final  String key;
@override final  String value;

@override
String toString() {
  return 'SentrySpanTagType._create(key: $key, value: $value)';
}


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _$SentrySpanTagTypeImpl&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,key,value);

@JsonKey(ignore: true)
@override
@pragma('vm:prefer-inline')
_$$SentrySpanTagTypeImplCopyWith<_$SentrySpanTagTypeImpl> get copyWith => __$$SentrySpanTagTypeImplCopyWithImpl<_$SentrySpanTagTypeImpl>(this, _$identity);








}


abstract class _SentrySpanTagType implements SentrySpanTagType {
  const factory _SentrySpanTagType({required final  String key, required final  String value}) = _$SentrySpanTagTypeImpl;
  

  

@override  String get key;@override  String get value;
@override @JsonKey(ignore: true)
_$$SentrySpanTagTypeImplCopyWith<_$SentrySpanTagTypeImpl> get copyWith => throw _privateConstructorUsedError;

}
