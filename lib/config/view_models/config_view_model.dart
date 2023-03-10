import 'package:carrotmarket/config/models/config_model.dart';
import 'package:carrotmarket/config/repositories/config_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigViewModel extends Notifier<ConfigModel> {
  final ConfigRepository _configRepository;

  ConfigViewModel(this._configRepository);

  @override
  ConfigModel build() {
    return ConfigModel(darkMode: _configRepository.getDarkMode());
  }

  void setDarkMode(bool value) {
    _configRepository.setDarkMode(value);
    state = ConfigModel(darkMode: value);
  }
}

final configProvider = NotifierProvider<ConfigViewModel, ConfigModel>(
  () => throw UnimplementedError(),
);
