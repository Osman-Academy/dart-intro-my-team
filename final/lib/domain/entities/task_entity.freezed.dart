// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TaskEntity _$TaskEntityFromJson(Map<String, dynamic> json) {
  return _TaskEntity.fromJson(json);
}

/// @nodoc
mixin _$TaskEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson)
  TaskStatus get status => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError;
  UserEntity? get assignee => throw _privateConstructorUsedError;

  /// Serializes this TaskEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskEntityCopyWith<TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEntityCopyWith<$Res> {
  factory $TaskEntityCopyWith(
    TaskEntity value,
    $Res Function(TaskEntity) then,
  ) = _$TaskEntityCopyWithImpl<$Res, TaskEntity>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson)
    TaskStatus status,
    String projectId,
    UserEntity? assignee,
  });

  $UserEntityCopyWith<$Res>? get assignee;
}

/// @nodoc
class _$TaskEntityCopyWithImpl<$Res, $Val extends TaskEntity>
    implements $TaskEntityCopyWith<$Res> {
  _$TaskEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? projectId = null,
    Object? assignee = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TaskStatus,
            projectId: null == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String,
            assignee: freezed == assignee
                ? _value.assignee
                : assignee // ignore: cast_nullable_to_non_nullable
                      as UserEntity?,
          )
          as $Val,
    );
  }

  /// Create a copy of TaskEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res>? get assignee {
    if (_value.assignee == null) {
      return null;
    }

    return $UserEntityCopyWith<$Res>(_value.assignee!, (value) {
      return _then(_value.copyWith(assignee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskEntityImplCopyWith<$Res>
    implements $TaskEntityCopyWith<$Res> {
  factory _$$TaskEntityImplCopyWith(
    _$TaskEntityImpl value,
    $Res Function(_$TaskEntityImpl) then,
  ) = __$$TaskEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson)
    TaskStatus status,
    String projectId,
    UserEntity? assignee,
  });

  @override
  $UserEntityCopyWith<$Res>? get assignee;
}

/// @nodoc
class __$$TaskEntityImplCopyWithImpl<$Res>
    extends _$TaskEntityCopyWithImpl<$Res, _$TaskEntityImpl>
    implements _$$TaskEntityImplCopyWith<$Res> {
  __$$TaskEntityImplCopyWithImpl(
    _$TaskEntityImpl _value,
    $Res Function(_$TaskEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? projectId = null,
    Object? assignee = freezed,
  }) {
    return _then(
      _$TaskEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TaskStatus,
        projectId: null == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String,
        assignee: freezed == assignee
            ? _value.assignee
            : assignee // ignore: cast_nullable_to_non_nullable
                  as UserEntity?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskEntityImpl implements _TaskEntity {
  const _$TaskEntityImpl({
    required this.id,
    required this.title,
    required this.description,
    @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson)
    required this.status,
    required this.projectId,
    this.assignee,
  });

  factory _$TaskEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson)
  final TaskStatus status;
  @override
  final String projectId;
  @override
  final UserEntity? assignee;

  @override
  String toString() {
    return 'TaskEntity(id: $id, title: $title, description: $description, status: $status, projectId: $projectId, assignee: $assignee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.assignee, assignee) ||
                other.assignee == assignee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    status,
    projectId,
    assignee,
  );

  /// Create a copy of TaskEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskEntityImplCopyWith<_$TaskEntityImpl> get copyWith =>
      __$$TaskEntityImplCopyWithImpl<_$TaskEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskEntityImplToJson(this);
  }
}

abstract class _TaskEntity implements TaskEntity {
  const factory _TaskEntity({
    required final String id,
    required final String title,
    required final String description,
    @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson)
    required final TaskStatus status,
    required final String projectId,
    final UserEntity? assignee,
  }) = _$TaskEntityImpl;

  factory _TaskEntity.fromJson(Map<String, dynamic> json) =
      _$TaskEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson)
  TaskStatus get status;
  @override
  String get projectId;
  @override
  UserEntity? get assignee;

  /// Create a copy of TaskEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskEntityImplCopyWith<_$TaskEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
