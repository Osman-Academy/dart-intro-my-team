// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TaskState {
  List<Task> get allTasks => throw _privateConstructorUsedError;
  List<Task> get filteredTasks => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskStateCopyWith<TaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStateCopyWith<$Res> {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) then) =
      _$TaskStateCopyWithImpl<$Res, TaskState>;
  @useResult
  $Res call({List<Task> allTasks, List<Task> filteredTasks, bool isLoading});
}

/// @nodoc
class _$TaskStateCopyWithImpl<$Res, $Val extends TaskState>
    implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTasks = null,
    Object? filteredTasks = null,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            allTasks: null == allTasks
                ? _value.allTasks
                : allTasks // ignore: cast_nullable_to_non_nullable
                      as List<Task>,
            filteredTasks: null == filteredTasks
                ? _value.filteredTasks
                : filteredTasks // ignore: cast_nullable_to_non_nullable
                      as List<Task>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskStateImplCopyWith<$Res>
    implements $TaskStateCopyWith<$Res> {
  factory _$$TaskStateImplCopyWith(
    _$TaskStateImpl value,
    $Res Function(_$TaskStateImpl) then,
  ) = __$$TaskStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Task> allTasks, List<Task> filteredTasks, bool isLoading});
}

/// @nodoc
class __$$TaskStateImplCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$TaskStateImpl>
    implements _$$TaskStateImplCopyWith<$Res> {
  __$$TaskStateImplCopyWithImpl(
    _$TaskStateImpl _value,
    $Res Function(_$TaskStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTasks = null,
    Object? filteredTasks = null,
    Object? isLoading = null,
  }) {
    return _then(
      _$TaskStateImpl(
        allTasks: null == allTasks
            ? _value._allTasks
            : allTasks // ignore: cast_nullable_to_non_nullable
                  as List<Task>,
        filteredTasks: null == filteredTasks
            ? _value._filteredTasks
            : filteredTasks // ignore: cast_nullable_to_non_nullable
                  as List<Task>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TaskStateImpl implements _TaskState {
  const _$TaskStateImpl({
    required final List<Task> allTasks,
    required final List<Task> filteredTasks,
    required this.isLoading,
  }) : _allTasks = allTasks,
       _filteredTasks = filteredTasks;

  final List<Task> _allTasks;
  @override
  List<Task> get allTasks {
    if (_allTasks is EqualUnmodifiableListView) return _allTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allTasks);
  }

  final List<Task> _filteredTasks;
  @override
  List<Task> get filteredTasks {
    if (_filteredTasks is EqualUnmodifiableListView) return _filteredTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredTasks);
  }

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'TaskState(allTasks: $allTasks, filteredTasks: $filteredTasks, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskStateImpl &&
            const DeepCollectionEquality().equals(other._allTasks, _allTasks) &&
            const DeepCollectionEquality().equals(
              other._filteredTasks,
              _filteredTasks,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_allTasks),
    const DeepCollectionEquality().hash(_filteredTasks),
    isLoading,
  );

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskStateImplCopyWith<_$TaskStateImpl> get copyWith =>
      __$$TaskStateImplCopyWithImpl<_$TaskStateImpl>(this, _$identity);
}

abstract class _TaskState implements TaskState {
  const factory _TaskState({
    required final List<Task> allTasks,
    required final List<Task> filteredTasks,
    required final bool isLoading,
  }) = _$TaskStateImpl;

  @override
  List<Task> get allTasks;
  @override
  List<Task> get filteredTasks;
  @override
  bool get isLoading;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskStateImplCopyWith<_$TaskStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
