part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();
  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountryIsLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final _data;

  CountryLoaded(this._data);

  List<CountryModel> get getCountries => _data;
  List<String> get getProps => _data;
  @override
  List<Object> get props => [_data];
}

class CountryNotLoaded extends CountryState {
  final String _message;
  CountryNotLoaded(this._message);
  get getMessage => _message;
  @override
  List<Object> get props => [_message];
}
