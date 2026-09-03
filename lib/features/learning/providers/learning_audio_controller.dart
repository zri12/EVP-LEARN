import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

enum LearningAudioStatus { idle, loading, playing, paused, completed, error }

class LearningAudioState {
  const LearningAudioState({
    this.status = LearningAudioStatus.idle,
    this.assetPath,
    this.position = Duration.zero,
    this.duration,
  });

  final LearningAudioStatus status;
  final String? assetPath;
  final Duration position;
  final Duration? duration;

  LearningAudioState copyWith({
    LearningAudioStatus? status,
    String? assetPath,
    Duration? position,
    Duration? duration,
  }) => LearningAudioState(
    status: status ?? this.status,
    assetPath: assetPath ?? this.assetPath,
    position: position ?? this.position,
    duration: duration ?? this.duration,
  );
}

class LearningAudioController extends StateNotifier<LearningAudioState> {
  LearningAudioController({AudioPlayer? player})
    : _player = player ?? AudioPlayer(),
      super(const LearningAudioState()) {
    _subscriptions = [
      _player.positionStream.listen(
        (value) => state = state.copyWith(position: value),
      ),
      _player.durationStream.listen(
        (value) => state = state.copyWith(duration: value),
      ),
      _player.playerStateStream.listen((value) {
        if (value.processingState == ProcessingState.completed) {
          state = state.copyWith(status: LearningAudioStatus.completed);
        } else if (value.playing) {
          state = state.copyWith(status: LearningAudioStatus.playing);
        } else if (state.assetPath != null) {
          state = state.copyWith(status: LearningAudioStatus.paused);
        }
      }),
    ];
  }

  final AudioPlayer _player;
  late final List<StreamSubscription<Object?>> _subscriptions;

  Future<void> toggle(String assetPath) async {
    try {
      if (state.assetPath == assetPath &&
          state.status == LearningAudioStatus.playing) {
        await _player.pause();
        return;
      }
      if (state.assetPath != assetPath) {
        state = LearningAudioState(
          status: LearningAudioStatus.loading,
          assetPath: assetPath,
        );
        await _player.setAsset(assetPath);
      }
      await _player.play();
    } on Object {
      state = state.copyWith(status: LearningAudioStatus.error);
    }
  }

  Future<void> restart() async {
    if (state.assetPath == null) return;
    await _player.seek(Duration.zero);
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
    state = const LearningAudioState();
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _player.dispose();
    super.dispose();
  }
}

final learningAudioProvider =
    StateNotifierProvider.autoDispose<
      LearningAudioController,
      LearningAudioState
    >((ref) {
      final controller = LearningAudioController();
      return controller;
    });
