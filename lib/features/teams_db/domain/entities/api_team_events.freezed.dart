// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'api_team_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
APITeamEvents _$APITeamEventsFromJson(Map<String, dynamic> json) {
  return _APITeamEvents.fromJson(json);
}

class _$APITeamEventsTearOff {
  const _$APITeamEventsTearOff();

  _APITeamEvents call(
      {@required @nullable String strHomeTeam,
      @required @nullable String strAwayTeam,
      @required @nullable String dateEvent,
      @required @nullable String idHomeTeam,
      @required @nullable String idAwayTeam}) {
    return _APITeamEvents(
      strHomeTeam: strHomeTeam,
      strAwayTeam: strAwayTeam,
      dateEvent: dateEvent,
      idHomeTeam: idHomeTeam,
      idAwayTeam: idAwayTeam,
    );
  }
}

// ignore: unused_element
const $APITeamEvents = _$APITeamEventsTearOff();

mixin _$APITeamEvents {
  @nullable
  String get strHomeTeam;
  @nullable
  String get strAwayTeam;
  @nullable
  String get dateEvent;
  @nullable
  String get idHomeTeam;
  @nullable
  String get idAwayTeam;

  Map<String, dynamic> toJson();
  $APITeamEventsCopyWith<APITeamEvents> get copyWith;
}

abstract class $APITeamEventsCopyWith<$Res> {
  factory $APITeamEventsCopyWith(
          APITeamEvents value, $Res Function(APITeamEvents) then) =
      _$APITeamEventsCopyWithImpl<$Res>;
  $Res call(
      {@nullable String strHomeTeam,
      @nullable String strAwayTeam,
      @nullable String dateEvent,
      @nullable String idHomeTeam,
      @nullable String idAwayTeam});
}

class _$APITeamEventsCopyWithImpl<$Res>
    implements $APITeamEventsCopyWith<$Res> {
  _$APITeamEventsCopyWithImpl(this._value, this._then);

  final APITeamEvents _value;
  // ignore: unused_field
  final $Res Function(APITeamEvents) _then;

  @override
  $Res call({
    Object strHomeTeam = freezed,
    Object strAwayTeam = freezed,
    Object dateEvent = freezed,
    Object idHomeTeam = freezed,
    Object idAwayTeam = freezed,
  }) {
    return _then(_value.copyWith(
      strHomeTeam:
          strHomeTeam == freezed ? _value.strHomeTeam : strHomeTeam as String,
      strAwayTeam:
          strAwayTeam == freezed ? _value.strAwayTeam : strAwayTeam as String,
      dateEvent: dateEvent == freezed ? _value.dateEvent : dateEvent as String,
      idHomeTeam:
          idHomeTeam == freezed ? _value.idHomeTeam : idHomeTeam as String,
      idAwayTeam:
          idAwayTeam == freezed ? _value.idAwayTeam : idAwayTeam as String,
    ));
  }
}

abstract class _$APITeamEventsCopyWith<$Res>
    implements $APITeamEventsCopyWith<$Res> {
  factory _$APITeamEventsCopyWith(
          _APITeamEvents value, $Res Function(_APITeamEvents) then) =
      __$APITeamEventsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable String strHomeTeam,
      @nullable String strAwayTeam,
      @nullable String dateEvent,
      @nullable String idHomeTeam,
      @nullable String idAwayTeam});
}

class __$APITeamEventsCopyWithImpl<$Res>
    extends _$APITeamEventsCopyWithImpl<$Res>
    implements _$APITeamEventsCopyWith<$Res> {
  __$APITeamEventsCopyWithImpl(
      _APITeamEvents _value, $Res Function(_APITeamEvents) _then)
      : super(_value, (v) => _then(v as _APITeamEvents));

  @override
  _APITeamEvents get _value => super._value as _APITeamEvents;

  @override
  $Res call({
    Object strHomeTeam = freezed,
    Object strAwayTeam = freezed,
    Object dateEvent = freezed,
    Object idHomeTeam = freezed,
    Object idAwayTeam = freezed,
  }) {
    return _then(_APITeamEvents(
      strHomeTeam:
          strHomeTeam == freezed ? _value.strHomeTeam : strHomeTeam as String,
      strAwayTeam:
          strAwayTeam == freezed ? _value.strAwayTeam : strAwayTeam as String,
      dateEvent: dateEvent == freezed ? _value.dateEvent : dateEvent as String,
      idHomeTeam:
          idHomeTeam == freezed ? _value.idHomeTeam : idHomeTeam as String,
      idAwayTeam:
          idAwayTeam == freezed ? _value.idAwayTeam : idAwayTeam as String,
    ));
  }
}

@JsonSerializable()
class _$_APITeamEvents with DiagnosticableTreeMixin implements _APITeamEvents {
  const _$_APITeamEvents(
      {@required @nullable this.strHomeTeam,
      @required @nullable this.strAwayTeam,
      @required @nullable this.dateEvent,
      @required @nullable this.idHomeTeam,
      @required @nullable this.idAwayTeam});

  factory _$_APITeamEvents.fromJson(Map<String, dynamic> json) =>
      _$_$_APITeamEventsFromJson(json);

  @override
  @nullable
  final String strHomeTeam;
  @override
  @nullable
  final String strAwayTeam;
  @override
  @nullable
  final String dateEvent;
  @override
  @nullable
  final String idHomeTeam;
  @override
  @nullable
  final String idAwayTeam;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'APITeamEvents(strHomeTeam: $strHomeTeam, strAwayTeam: $strAwayTeam, dateEvent: $dateEvent, idHomeTeam: $idHomeTeam, idAwayTeam: $idAwayTeam)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'APITeamEvents'))
      ..add(DiagnosticsProperty('strHomeTeam', strHomeTeam))
      ..add(DiagnosticsProperty('strAwayTeam', strAwayTeam))
      ..add(DiagnosticsProperty('dateEvent', dateEvent))
      ..add(DiagnosticsProperty('idHomeTeam', idHomeTeam))
      ..add(DiagnosticsProperty('idAwayTeam', idAwayTeam));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _APITeamEvents &&
            (identical(other.strHomeTeam, strHomeTeam) ||
                const DeepCollectionEquality()
                    .equals(other.strHomeTeam, strHomeTeam)) &&
            (identical(other.strAwayTeam, strAwayTeam) ||
                const DeepCollectionEquality()
                    .equals(other.strAwayTeam, strAwayTeam)) &&
            (identical(other.dateEvent, dateEvent) ||
                const DeepCollectionEquality()
                    .equals(other.dateEvent, dateEvent)) &&
            (identical(other.idHomeTeam, idHomeTeam) ||
                const DeepCollectionEquality()
                    .equals(other.idHomeTeam, idHomeTeam)) &&
            (identical(other.idAwayTeam, idAwayTeam) ||
                const DeepCollectionEquality()
                    .equals(other.idAwayTeam, idAwayTeam)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(strHomeTeam) ^
      const DeepCollectionEquality().hash(strAwayTeam) ^
      const DeepCollectionEquality().hash(dateEvent) ^
      const DeepCollectionEquality().hash(idHomeTeam) ^
      const DeepCollectionEquality().hash(idAwayTeam);

  @override
  _$APITeamEventsCopyWith<_APITeamEvents> get copyWith =>
      __$APITeamEventsCopyWithImpl<_APITeamEvents>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_APITeamEventsToJson(this);
  }
}

abstract class _APITeamEvents implements APITeamEvents {
  const factory _APITeamEvents(
      {@required @nullable String strHomeTeam,
      @required @nullable String strAwayTeam,
      @required @nullable String dateEvent,
      @required @nullable String idHomeTeam,
      @required @nullable String idAwayTeam}) = _$_APITeamEvents;

  factory _APITeamEvents.fromJson(Map<String, dynamic> json) =
      _$_APITeamEvents.fromJson;

  @override
  @nullable
  String get strHomeTeam;
  @override
  @nullable
  String get strAwayTeam;
  @override
  @nullable
  String get dateEvent;
  @override
  @nullable
  String get idHomeTeam;
  @override
  @nullable
  String get idAwayTeam;
  @override
  _$APITeamEventsCopyWith<_APITeamEvents> get copyWith;
}
