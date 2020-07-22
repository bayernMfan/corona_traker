import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:provider_app/rep/API/country.dart';
import 'package:provider_app/rep/models/country_model.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  Country countryRepo;
  CountryBloc(this.countryRepo) : super(CountryInitial());

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is GetCountry) {
      yield CountryIsLoading();

      try {
        if (event.getParams == null) {
          List<CountryModel> countries = await countryRepo.getCountriesList();
          yield CountryLoaded(countries);
        } else {
          List<String> countryParams =
              await countryRepo.getCountriesParams(event.getParams);
          yield CountryLoaded(countryParams);
        }
      } catch (exception) {
        yield CountryNotLoaded(exception.toString());
      }
    } else if (event is ResetCountry) {
      yield CountryInitial();
    }
  }

  void dispose() {
    this.close();
  }
}
