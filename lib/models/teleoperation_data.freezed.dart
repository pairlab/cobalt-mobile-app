// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teleoperation_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TeleoperationData {
  int get enable => throw _privateConstructorUsedError;
  int get valid => throw _privateConstructorUsedError;
  int get engaged => throw _privateConstructorUsedError;
  int get reset => throw _privateConstructorUsedError;
  int get completion => throw _privateConstructorUsedError;
  int get timeout => throw _privateConstructorUsedError;
  int get demo_decision_indicator => throw _privateConstructorUsedError;
  int get keep_demo_decision => throw _privateConstructorUsedError;
  int get grasp => throw _privateConstructorUsedError;
  double get time_offset => throw _privateConstructorUsedError;
  Float64List? get dpos => throw _privateConstructorUsedError;
  Float64List? get rotation => throw _privateConstructorUsedError;
  bool get serverReady => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  String? get serverIp => throw _privateConstructorUsedError;

  /// Create a copy of TeleoperationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeleoperationDataCopyWith<TeleoperationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeleoperationDataCopyWith<$Res> {
  factory $TeleoperationDataCopyWith(
          TeleoperationData value, $Res Function(TeleoperationData) then) =
      _$TeleoperationDataCopyWithImpl<$Res, TeleoperationData>;
  @useResult
  $Res call(
      {int enable,
      int valid,
      int engaged,
      int reset,
      int completion,
      int timeout,
      int demo_decision_indicator,
      int keep_demo_decision,
      int grasp,
      double time_offset,
      Float64List? dpos,
      Float64List? rotation,
      bool serverReady,
      String? sessionId,
      String? deviceId,
      String? serverIp});
}

/// @nodoc
class _$TeleoperationDataCopyWithImpl<$Res, $Val extends TeleoperationData>
    implements $TeleoperationDataCopyWith<$Res> {
  _$TeleoperationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeleoperationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enable = null,
    Object? valid = null,
    Object? engaged = null,
    Object? reset = null,
    Object? completion = null,
    Object? timeout = null,
    Object? demo_decision_indicator = null,
    Object? keep_demo_decision = null,
    Object? grasp = null,
    Object? time_offset = null,
    Object? dpos = freezed,
    Object? rotation = freezed,
    Object? serverReady = null,
    Object? sessionId = freezed,
    Object? deviceId = freezed,
    Object? serverIp = freezed,
  }) {
    return _then(_value.copyWith(
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as int,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as int,
      engaged: null == engaged
          ? _value.engaged
          : engaged // ignore: cast_nullable_to_non_nullable
              as int,
      reset: null == reset
          ? _value.reset
          : reset // ignore: cast_nullable_to_non_nullable
              as int,
      completion: null == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as int,
      timeout: null == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as int,
      demo_decision_indicator: null == demo_decision_indicator
          ? _value.demo_decision_indicator
          : demo_decision_indicator // ignore: cast_nullable_to_non_nullable
              as int,
      keep_demo_decision: null == keep_demo_decision
          ? _value.keep_demo_decision
          : keep_demo_decision // ignore: cast_nullable_to_non_nullable
              as int,
      grasp: null == grasp
          ? _value.grasp
          : grasp // ignore: cast_nullable_to_non_nullable
              as int,
      time_offset: null == time_offset
          ? _value.time_offset
          : time_offset // ignore: cast_nullable_to_non_nullable
              as double,
      dpos: freezed == dpos
          ? _value.dpos
          : dpos // ignore: cast_nullable_to_non_nullable
              as Float64List?,
      rotation: freezed == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as Float64List?,
      serverReady: null == serverReady
          ? _value.serverReady
          : serverReady // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverIp: freezed == serverIp
          ? _value.serverIp
          : serverIp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeleoperationDataImplCopyWith<$Res>
    implements $TeleoperationDataCopyWith<$Res> {
  factory _$$TeleoperationDataImplCopyWith(_$TeleoperationDataImpl value,
          $Res Function(_$TeleoperationDataImpl) then) =
      __$$TeleoperationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int enable,
      int valid,
      int engaged,
      int reset,
      int completion,
      int timeout,
      int demo_decision_indicator,
      int keep_demo_decision,
      int grasp,
      double time_offset,
      Float64List? dpos,
      Float64List? rotation,
      bool serverReady,
      String? sessionId,
      String? deviceId,
      String? serverIp});
}

/// @nodoc
class __$$TeleoperationDataImplCopyWithImpl<$Res>
    extends _$TeleoperationDataCopyWithImpl<$Res, _$TeleoperationDataImpl>
    implements _$$TeleoperationDataImplCopyWith<$Res> {
  __$$TeleoperationDataImplCopyWithImpl(_$TeleoperationDataImpl _value,
      $Res Function(_$TeleoperationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeleoperationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enable = null,
    Object? valid = null,
    Object? engaged = null,
    Object? reset = null,
    Object? completion = null,
    Object? timeout = null,
    Object? demo_decision_indicator = null,
    Object? keep_demo_decision = null,
    Object? grasp = null,
    Object? time_offset = null,
    Object? dpos = freezed,
    Object? rotation = freezed,
    Object? serverReady = null,
    Object? sessionId = freezed,
    Object? deviceId = freezed,
    Object? serverIp = freezed,
  }) {
    return _then(_$TeleoperationDataImpl(
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as int,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as int,
      engaged: null == engaged
          ? _value.engaged
          : engaged // ignore: cast_nullable_to_non_nullable
              as int,
      reset: null == reset
          ? _value.reset
          : reset // ignore: cast_nullable_to_non_nullable
              as int,
      completion: null == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as int,
      timeout: null == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as int,
      demo_decision_indicator: null == demo_decision_indicator
          ? _value.demo_decision_indicator
          : demo_decision_indicator // ignore: cast_nullable_to_non_nullable
              as int,
      keep_demo_decision: null == keep_demo_decision
          ? _value.keep_demo_decision
          : keep_demo_decision // ignore: cast_nullable_to_non_nullable
              as int,
      grasp: null == grasp
          ? _value.grasp
          : grasp // ignore: cast_nullable_to_non_nullable
              as int,
      time_offset: null == time_offset
          ? _value.time_offset
          : time_offset // ignore: cast_nullable_to_non_nullable
              as double,
      dpos: freezed == dpos
          ? _value.dpos
          : dpos // ignore: cast_nullable_to_non_nullable
              as Float64List?,
      rotation: freezed == rotation
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as Float64List?,
      serverReady: null == serverReady
          ? _value.serverReady
          : serverReady // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverIp: freezed == serverIp
          ? _value.serverIp
          : serverIp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TeleoperationDataImpl extends _TeleoperationData {
  _$TeleoperationDataImpl(
      {required this.enable,
      required this.valid,
      required this.engaged,
      required this.reset,
      required this.completion,
      required this.timeout,
      required this.demo_decision_indicator,
      required this.keep_demo_decision,
      required this.grasp,
      required this.time_offset,
      required this.dpos,
      required this.rotation,
      required this.serverReady,
      this.sessionId,
      this.deviceId,
      this.serverIp})
      : super._();

  @override
  final int enable;
  @override
  final int valid;
  @override
  final int engaged;
  @override
  final int reset;
  @override
  final int completion;
  @override
  final int timeout;
  @override
  final int demo_decision_indicator;
  @override
  final int keep_demo_decision;
  @override
  final int grasp;
  @override
  final double time_offset;
  @override
  final Float64List? dpos;
  @override
  final Float64List? rotation;
  @override
  final bool serverReady;
  @override
  final String? sessionId;
  @override
  final String? deviceId;
  @override
  final String? serverIp;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeleoperationDataImpl &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.engaged, engaged) || other.engaged == engaged) &&
            (identical(other.reset, reset) || other.reset == reset) &&
            (identical(other.completion, completion) ||
                other.completion == completion) &&
            (identical(other.timeout, timeout) || other.timeout == timeout) &&
            (identical(
                    other.demo_decision_indicator, demo_decision_indicator) ||
                other.demo_decision_indicator == demo_decision_indicator) &&
            (identical(other.keep_demo_decision, keep_demo_decision) ||
                other.keep_demo_decision == keep_demo_decision) &&
            (identical(other.grasp, grasp) || other.grasp == grasp) &&
            (identical(other.time_offset, time_offset) ||
                other.time_offset == time_offset) &&
            const DeepCollectionEquality().equals(other.dpos, dpos) &&
            const DeepCollectionEquality().equals(other.rotation, rotation) &&
            (identical(other.serverReady, serverReady) ||
                other.serverReady == serverReady) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.serverIp, serverIp) ||
                other.serverIp == serverIp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      enable,
      valid,
      engaged,
      reset,
      completion,
      timeout,
      demo_decision_indicator,
      keep_demo_decision,
      grasp,
      time_offset,
      const DeepCollectionEquality().hash(dpos),
      const DeepCollectionEquality().hash(rotation),
      serverReady,
      sessionId,
      deviceId,
      serverIp);

  /// Create a copy of TeleoperationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeleoperationDataImplCopyWith<_$TeleoperationDataImpl> get copyWith =>
      __$$TeleoperationDataImplCopyWithImpl<_$TeleoperationDataImpl>(
          this, _$identity);
}

abstract class _TeleoperationData extends TeleoperationData {
  factory _TeleoperationData(
      {required final int enable,
      required final int valid,
      required final int engaged,
      required final int reset,
      required final int completion,
      required final int timeout,
      required final int demo_decision_indicator,
      required final int keep_demo_decision,
      required final int grasp,
      required final double time_offset,
      required final Float64List? dpos,
      required final Float64List? rotation,
      required final bool serverReady,
      final String? sessionId,
      final String? deviceId,
      final String? serverIp}) = _$TeleoperationDataImpl;
  _TeleoperationData._() : super._();

  @override
  int get enable;
  @override
  int get valid;
  @override
  int get engaged;
  @override
  int get reset;
  @override
  int get completion;
  @override
  int get timeout;
  @override
  int get demo_decision_indicator;
  @override
  int get keep_demo_decision;
  @override
  int get grasp;
  @override
  double get time_offset;
  @override
  Float64List? get dpos;
  @override
  Float64List? get rotation;
  @override
  bool get serverReady;
  @override
  String? get sessionId;
  @override
  String? get deviceId;
  @override
  String? get serverIp;

  /// Create a copy of TeleoperationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeleoperationDataImplCopyWith<_$TeleoperationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
