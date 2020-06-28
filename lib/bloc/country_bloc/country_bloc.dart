import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  @override
  CountryState get initialState => CountryInitial();

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
