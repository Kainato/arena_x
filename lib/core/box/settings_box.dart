enum SettingsBox { id, darkMode, primaryColor }

extension SettingsBoxExtension on SettingsBox {
  String get boxName {
    switch (this) {
      case SettingsBox.id:
        return 'settingsBox';
      default:
        return '';
    }
  }

  String get boxKey {
    switch (this) {
      case SettingsBox.darkMode:
        return 'darkMode';
      case SettingsBox.primaryColor:
        return 'primaryColor';
      default:
        return '';
    }
  }
}
