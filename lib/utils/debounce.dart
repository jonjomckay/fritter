import 'dart:async';

import 'package:flutter/material.dart';

// Based on easy_debounce by magnuswikihog, released under the MIT License: https://github.com/magnuswikhog/easy_debounce
typedef DebounceCallback = VoidCallback;

class _DebounceTask {
  Timer timer;
  DebounceCallback callback;

  _DebounceTask(this.callback, this.timer);
}

class Debouncer {
  static final Map<String, _DebounceTask> _tasks = {};

  static void debounce(String id, Duration duration, DebounceCallback callback) {
    _tasks[id]?.timer.cancel();

    _tasks[id] = _DebounceTask(
        callback,
        Timer(duration, () {
          _tasks[id]?.timer.cancel();
          _tasks.remove(id);

          callback();
        }));
  }
}
