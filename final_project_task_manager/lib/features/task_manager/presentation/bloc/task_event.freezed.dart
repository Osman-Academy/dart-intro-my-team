// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String query) search,
    required TResult Function(String title) add,
    required TResult Function(Task task) edit,
    required TResult Function(String id) delete,
    required TResult Function(String id) toggle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String query)? search,
    TResult? Function(String title)? add,
    TResult? Function(Task task)? edit,
    TResult? Function(String id)? delete,
    TResult? Function(String id)? toggle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String query)? search,
    TResult Function(String title)? add,
    TResult Function(Task task)? edit,
    TResult Function(String id)? delete,
    TResult Function(String id)? toggle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Search value) search,
    required TResult Function(_Add value) add,
    required TResult Function(_Edit value) edit,
    required TResult Function(_Delete value) delete,
    required TResult Function(_Toggle value) toggle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Search value)? search,
    TResult? Function(_Add value)? add,
    TResult? Function(_Edit value)? edit,
    TResult? Function(_Delete value)? delete,
    TResult? Function(_Toggle value)? toggle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Search value)? search,
    TResult Function(_Add value)? add,
    TResult Function(_Edit value)? edit,
    TResult Function(_Delete value)? delete,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEventCopyWith<$Res> {
  factory $TaskEventCopyWith(TaskEvent value, $Res Function(TaskEvent) then) =
      _$TaskEventCopyWithImpl<$Res, TaskEvent>;
}

/// @nodoc
class _$TaskEventCopyWithImpl<$Res, $Val extends TaskEvent>
    implements $TaskEventCopyWith<$Res> {
  _$TaskEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
          _$LoadImpl value, $Res Function(_$LoadImpl) then) =
      __$$LoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'TaskEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String query) search,
    required TResult Function(String title) add,
    required TResult Function(Task task) edit,
    required TResult Function(String id) delete,
    required TResult Function(String id) toggle,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String query)? search,
    TResult? Function(String title)? add,
    TResult? Function(Task task)? edit,
    TResult? Function(String id)? delete,
    TResult? Function(String id)? toggle,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String query)? search,
    TResult Function(String title)? add,
    TResult Function(Task task)? edit,
    TResult Function(String id)? delete,
    TResult Function(String id)? toggle,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Search value) search,
    required TResult Function(_Add value) add,
    required TResult Function(_Edit value) edit,
    required TResult Function(_Delete value) delete,
    required TResult Function(_Toggle value) toggle,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Search value)? search,
    TResult? Function(_Add value)? add,
    TResult? Function(_Edit value)? edit,
    TResult? Function(_Delete value)? delete,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Search value)? search,
    TResult Function(_Add value)? add,
    TResult Function(_Edit value)? edit,
    TResult Function(_Delete value)? delete,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements TaskEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$SearchImplCopyWith<$Res> {
  factory _$$SearchImplCopyWith(
          _$SearchImpl value, $Res Function(_$SearchImpl) then) =
      __$$SearchImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$SearchImpl>
    implements _$$SearchImplCopyWith<$Res> {
  __$$SearchImplCopyWithImpl(
      _$SearchImpl _value, $Res Function(_$SearchImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchImpl implements _Search {
  const _$SearchImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'TaskEvent.search(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchImplCopyWith<_$SearchImpl> get copyWith =>
      __$$SearchImplCopyWithImpl<_$SearchImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String query) search,
    required TResult Function(String title) add,
    required TResult Function(Task task) edit,
    required TResult Function(String id) delete,
    required TResult Function(String id) toggle,
  }) {
    return search(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String query)? search,
    TResult? Function(String title)? add,
    TResult? Function(Task task)? edit,
    TResult? Function(String id)? delete,
    TResult? Function(String id)? toggle,
  }) {
    return search?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String query)? search,
    TResult Function(String title)? add,
    TResult Function(Task task)? edit,
    TResult Function(String id)? delete,
    TResult Function(String id)? toggle,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Search value) search,
    required TResult Function(_Add value) add,
    required TResult Function(_Edit value) edit,
    required TResult Function(_Delete value) delete,
    required TResult Function(_Toggle value) toggle,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Search value)? search,
    TResult? Function(_Add value)? add,
    TResult? Function(_Edit value)? edit,
    TResult? Function(_Delete value)? delete,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Search value)? search,
    TResult Function(_Add value)? add,
    TResult Function(_Edit value)? edit,
    TResult Function(_Delete value)? delete,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class _Search implements TaskEvent {
  const factory _Search(final String query) = _$SearchImpl;

  String get query;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchImplCopyWith<_$SearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddImplCopyWith<$Res> {
  factory _$$AddImplCopyWith(_$AddImpl value, $Res Function(_$AddImpl) then) =
      __$$AddImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$AddImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$AddImpl>
    implements _$$AddImplCopyWith<$Res> {
  __$$AddImplCopyWithImpl(_$AddImpl _value, $Res Function(_$AddImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$AddImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddImpl implements _Add {
  const _$AddImpl(this.title);

  @override
  final String title;

  @override
  String toString() {
    return 'TaskEvent.add(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddImplCopyWith<_$AddImpl> get copyWith =>
      __$$AddImplCopyWithImpl<_$AddImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String query) search,
    required TResult Function(String title) add,
    required TResult Function(Task task) edit,
    required TResult Function(String id) delete,
    required TResult Function(String id) toggle,
  }) {
    return add(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String query)? search,
    TResult? Function(String title)? add,
    TResult? Function(Task task)? edit,
    TResult? Function(String id)? delete,
    TResult? Function(String id)? toggle,
  }) {
    return add?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String query)? search,
    TResult Function(String title)? add,
    TResult Function(Task task)? edit,
    TResult Function(String id)? delete,
    TResult Function(String id)? toggle,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Search value) search,
    required TResult Function(_Add value) add,
    required TResult Function(_Edit value) edit,
    required TResult Function(_Delete value) delete,
    required TResult Function(_Toggle value) toggle,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Search value)? search,
    TResult? Function(_Add value)? add,
    TResult? Function(_Edit value)? edit,
    TResult? Function(_Delete value)? delete,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Search value)? search,
    TResult Function(_Add value)? add,
    TResult Function(_Edit value)? edit,
    TResult Function(_Delete value)? delete,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class _Add implements TaskEvent {
  const factory _Add(final String title) = _$AddImpl;

  String get title;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddImplCopyWith<_$AddImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditImplCopyWith<$Res> {
  factory _$$EditImplCopyWith(
          _$EditImpl value, $Res Function(_$EditImpl) then) =
      __$$EditImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Task task});

  $TaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$EditImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$EditImpl>
    implements _$$EditImplCopyWith<$Res> {
  __$$EditImplCopyWithImpl(_$EditImpl _value, $Res Function(_$EditImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$EditImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskCopyWith<$Res> get task {
    return $TaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$EditImpl implements _Edit {
  const _$EditImpl(this.task);

  @override
  final Task task;

  @override
  String toString() {
    return 'TaskEvent.edit(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditImplCopyWith<_$EditImpl> get copyWith =>
      __$$EditImplCopyWithImpl<_$EditImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String query) search,
    required TResult Function(String title) add,
    required TResult Function(Task task) edit,
    required TResult Function(String id) delete,
    required TResult Function(String id) toggle,
  }) {
    return edit(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String query)? search,
    TResult? Function(String title)? add,
    TResult? Function(Task task)? edit,
    TResult? Function(String id)? delete,
    TResult? Function(String id)? toggle,
  }) {
    return edit?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String query)? search,
    TResult Function(String title)? add,
    TResult Function(Task task)? edit,
    TResult Function(String id)? delete,
    TResult Function(String id)? toggle,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Search value) search,
    required TResult Function(_Add value) add,
    required TResult Function(_Edit value) edit,
    required TResult Function(_Delete value) delete,
    required TResult Function(_Toggle value) toggle,
  }) {
    return edit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Search value)? search,
    TResult? Function(_Add value)? add,
    TResult? Function(_Edit value)? edit,
    TResult? Function(_Delete value)? delete,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return edit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Search value)? search,
    TResult Function(_Add value)? add,
    TResult Function(_Edit value)? edit,
    TResult Function(_Delete value)? delete,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(this);
    }
    return orElse();
  }
}

abstract class _Edit implements TaskEvent {
  const factory _Edit(final Task task) = _$EditImpl;

  Task get task;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditImplCopyWith<_$EditImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteImplCopyWith<$Res> {
  factory _$$DeleteImplCopyWith(
          _$DeleteImpl value, $Res Function(_$DeleteImpl) then) =
      __$$DeleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$DeleteImpl>
    implements _$$DeleteImplCopyWith<$Res> {
  __$$DeleteImplCopyWithImpl(
      _$DeleteImpl _value, $Res Function(_$DeleteImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$DeleteImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteImpl implements _Delete {
  const _$DeleteImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'TaskEvent.delete(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteImplCopyWith<_$DeleteImpl> get copyWith =>
      __$$DeleteImplCopyWithImpl<_$DeleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String query) search,
    required TResult Function(String title) add,
    required TResult Function(Task task) edit,
    required TResult Function(String id) delete,
    required TResult Function(String id) toggle,
  }) {
    return delete(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String query)? search,
    TResult? Function(String title)? add,
    TResult? Function(Task task)? edit,
    TResult? Function(String id)? delete,
    TResult? Function(String id)? toggle,
  }) {
    return delete?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String query)? search,
    TResult Function(String title)? add,
    TResult Function(Task task)? edit,
    TResult Function(String id)? delete,
    TResult Function(String id)? toggle,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Search value) search,
    required TResult Function(_Add value) add,
    required TResult Function(_Edit value) edit,
    required TResult Function(_Delete value) delete,
    required TResult Function(_Toggle value) toggle,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Search value)? search,
    TResult? Function(_Add value)? add,
    TResult? Function(_Edit value)? edit,
    TResult? Function(_Delete value)? delete,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Search value)? search,
    TResult Function(_Add value)? add,
    TResult Function(_Edit value)? edit,
    TResult Function(_Delete value)? delete,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class _Delete implements TaskEvent {
  const factory _Delete(final String id) = _$DeleteImpl;

  String get id;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteImplCopyWith<_$DeleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleImplCopyWith<$Res> {
  factory _$$ToggleImplCopyWith(
          _$ToggleImpl value, $Res Function(_$ToggleImpl) then) =
      __$$ToggleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$ToggleImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$ToggleImpl>
    implements _$$ToggleImplCopyWith<$Res> {
  __$$ToggleImplCopyWithImpl(
      _$ToggleImpl _value, $Res Function(_$ToggleImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ToggleImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToggleImpl implements _Toggle {
  const _$ToggleImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'TaskEvent.toggle(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleImplCopyWith<_$ToggleImpl> get copyWith =>
      __$$ToggleImplCopyWithImpl<_$ToggleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String query) search,
    required TResult Function(String title) add,
    required TResult Function(Task task) edit,
    required TResult Function(String id) delete,
    required TResult Function(String id) toggle,
  }) {
    return toggle(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String query)? search,
    TResult? Function(String title)? add,
    TResult? Function(Task task)? edit,
    TResult? Function(String id)? delete,
    TResult? Function(String id)? toggle,
  }) {
    return toggle?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String query)? search,
    TResult Function(String title)? add,
    TResult Function(Task task)? edit,
    TResult Function(String id)? delete,
    TResult Function(String id)? toggle,
    required TResult orElse(),
  }) {
    if (toggle != null) {
      return toggle(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Search value) search,
    required TResult Function(_Add value) add,
    required TResult Function(_Edit value) edit,
    required TResult Function(_Delete value) delete,
    required TResult Function(_Toggle value) toggle,
  }) {
    return toggle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Search value)? search,
    TResult? Function(_Add value)? add,
    TResult? Function(_Edit value)? edit,
    TResult? Function(_Delete value)? delete,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return toggle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Search value)? search,
    TResult Function(_Add value)? add,
    TResult Function(_Edit value)? edit,
    TResult Function(_Delete value)? delete,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (toggle != null) {
      return toggle(this);
    }
    return orElse();
  }
}

abstract class _Toggle implements TaskEvent {
  const factory _Toggle(final String id) = _$ToggleImpl;

  String get id;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleImplCopyWith<_$ToggleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
