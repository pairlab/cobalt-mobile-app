// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teleoperation_incoming_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TeleoperationIncomingData {
  int get remoteResetBit => throw _privateConstructorUsedError;
  int get remoteTaskCompletionBit => throw _privateConstructorUsedError;
  int get remoteTaskTimeoutBit => throw _privateConstructorUsedError;

  /// Create a copy of TeleoperationIncomingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeleoperationIncomingDataCopyWith<TeleoperationIncomingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeleoperationIncomingDataCopyWith<$Res> {
  factory $TeleoperationIncomingDataCopyWith(TeleoperationIncomingData value,
          $Res Function(TeleoperationIncomingData) then) =
      _$TeleoperationIncomingDataCopyWithImpl<$Res, TeleoperationIncomingData>;
  @useResult
  $Res call(
      {int remoteResetBit,
      int remoteTaskCompletionBit,
      int remoteTaskTimeoutBit});
}

/// @nodoc
class _$TeleoperationIncomingDataCopyWithImpl<$Res,
        $Val extends TeleoperationIncomingData>
    implements $TeleoperationIncomingDataCopyWith<$Res> {
  _$TeleoperationIncomingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeleoperationIncomingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remoteResetBit = null,
    Object? remoteTaskCompletionBit = null,
    Object? remoteTaskTimeoutBit = null,
  }) {
    return _then(_value.copyWith(
      remoteResetBit: null == remoteResetBit
          ? _value.remoteResetBit
          : remoteResetBit // ignore: cast_nullable_to_non_nullable
              as int,
      remoteTaskCompletionBit: null == remoteTaskCompletionBit
          ? _value.remoteTaskCompletionBit
          : remoteTaskCompletionBit // ignore: cast_nullable_to_non_nullable
              as int,
      remoteTaskTimeoutBit: null == remoteTaskTimeoutBit
          ? _value.remoteTaskTimeoutBit
          : remoteTaskTimeoutBit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeleoperationIncomingDataImplCopyWith<$Res>
    implements $TeleoperationIncomingDataCopyWith<$Res> {
  factory _$$TeleoperationIncomingDataImplCopyWith(
          _$TeleoperationIncomingDataImpl value,
          $Res Function(_$TeleoperationIncomingDataImpl) then) =
      __$$TeleoperationIncomingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int remoteResetBit,
      int remoteTaskCompletionBit,
      int remoteTaskTimeoutBit});
}

/// @nodoc
class __$$TeleoperationIncomingDataImplCopyWithImpl<$Res>
    extends _$TeleoperationIncomingDataCopyWithImpl<$Res,
        _$TeleoperationIncomingDataImpl>
    implements _$$TeleoperationIncomingDataImplCopyWith<$Res> {
  __$$TeleoperationIncomingDataImplCopyWithImpl(
      _$TeleoperationIncomingDataImpl _value,
      $Res Function(_$TeleoperationIncomingDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeleoperationIncomingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remoteResetBit = null,
    Object? remoteTaskCompletionBit = null,
    Object? remoteTaskTimeoutBit = null,
  }) {
    return _then(_$TeleoperationIncomingDataImpl(
      remoteResetBit: null == remoteResetBit
          ? _value.remoteResetBit
          : remoteResetBit // ignore: cast_nullable_to_non_nullable
              as int,
      remoteTaskCompletionBit: null == remoteTaskCompletionBit
          ? _value.remoteTaskCompletionBit
          : remoteTaskCompletionBit // ignore: cast_nullable_to_non_nullable
              as int,
      remoteTaskTimeoutBit: null == remoteTaskTimeoutBit
          ? _value.remoteTaskTimeoutBit
          : remoteTaskTimeoutBit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TeleoperationIncomingDataImpl extends _TeleoperationIncomingData {
  _$TeleoperationIncomingDataImpl(
      {required this.remoteResetBit,
      required this.remoteTaskCompletionBit,
      required this.remoteTaskTimeoutBit})
      : super._();

  @override
  final int remoteResetBit;
  @override
  final int remoteTaskCompletionBit;
  @override
  final int remoteTaskTimeoutBit;

  @override
  String toString() {
    return 'TeleoperationIncomingData(remoteResetBit: $remoteResetBit, remoteTaskCompletionBit: $remoteTaskCompletionBit, remoteTaskTimeoutBit: $remoteTaskTimeoutBit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeleoperationIncomingDataImpl &&
            (identical(other.remoteResetBit, remoteResetBit) ||
                other.remoteResetBit == remoteResetBit) &&
            (identical(
                    other.remoteTaskCompletionBit, remoteTaskCompletionBit) ||
                other.remoteTaskCompletionBit == remoteTaskCompletionBit) &&
            (identical(other.remoteTaskTimeoutBit, remoteTaskTimeoutBit) ||
                other.remoteTaskTimeoutBit == remoteTaskTimeoutBit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, remoteResetBit,
      remoteTaskCompletionBit, remoteTaskTimeoutBit);

  /// Create a copy of TeleoperationIncomingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeleoperationIncomingDataImplCopyWith<_$TeleoperationIncomingDataImpl>
      get copyWith => __$$TeleoperationIncomingDataImplCopyWithImpl<
          _$TeleoperationIncomingDataImpl>(this, _$identity);
}

abstract class _TeleoperationIncomingData extends TeleoperationIncomingData {
  factory _TeleoperationIncomingData(
          {required final int remoteResetBit,
          required final int remoteTaskCompletionBit,
          required final int remoteTaskTimeoutBit}) =
      _$TeleoperationIncomingDataImpl;
  _TeleoperationIncomingData._() : super._();

  @override
  int get remoteResetBit;
  @override
  int get remoteTaskCompletionBit;
  @override
  int get remoteTaskTimeoutBit;

  /// Create a copy of TeleoperationIncomingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeleoperationIncomingDataImplCopyWith<_$TeleoperationIncomingDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
