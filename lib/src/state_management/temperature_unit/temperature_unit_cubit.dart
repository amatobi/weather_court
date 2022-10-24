import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathercourt/src/config/constants.dart';
import 'package:weathercourt/src/utils/converters.dart';
import '../../cache/local_cache_contract.dart';



class TemperatureUnitCubit extends Cubit<TemperatureUnit> {
  final ILocalCache _localCache;
  TemperatureUnitCubit(this._localCache) : super(TemperatureUnit.celsius);

  setTemperatureUnit(TemperatureUnit unit) {
    _localCache.saveInt(Constants.prefKeyTemerature, unit.index);
    emit(unit);
  }

  getTemperatureUnit() {
    final value = _localCache.fetchInt(Constants.prefKeyTemerature);
    final unit = TemperatureUnit.values[value];
    emit(unit);
  }
}
