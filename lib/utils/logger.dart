enum LogLevel { info, warning, error }

class Logger {
  static void log(String message, {LogLevel level = LogLevel.info}) {
    final prefix = switch (level) {
      LogLevel.info => 'ℹ️ INFO:',
      LogLevel.warning => '⚠️ WARNING:',
      LogLevel.error => '❌ ERROR:',
    };
    print('$prefix $message');
  }
}
