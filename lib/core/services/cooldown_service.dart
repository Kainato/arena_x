class CooldownService {
  final Map<String, DateTime> _cooldowns = {};

  bool isReady(String key) {
    final now = DateTime.now();
    final until = _cooldowns[key];
    return until == null || now.isAfter(until);
  }

  Duration timeLeft(String key) {
    final now = DateTime.now();
    final until = _cooldowns[key];
    if (until == null) return Duration.zero;
    return until.isAfter(now) ? until.difference(now) : Duration.zero;
  }

  void setCooldown(String key, Duration duration) {
    _cooldowns[key] = DateTime.now().add(duration);
  }
}
