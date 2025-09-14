import 'package:alarm_domain/alarm_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_watcher_state.freezed.dart';

@freezed
class NoteWatcherState with _$NoteWatcherState {
  const factory NoteWatcherState.initial() = _Initial;
  const factory NoteWatcherState.loading() = _Loading;
  const factory NoteWatcherState.loadSuccess(List<Note> notes) = _LoadSuccess;
  const factory NoteWatcherState.loadFailure(String message) = _LoadFailure;
}
