part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
  @override
  List<Object> get props => [];
}

class GetCountry extends CountryEvent {
  final String _param;
  GetCountry([this._param]);
  get getParams => _param;
  @override
  List<Object> get props => [_param];
}

class ResetCountry extends CountryEvent {}
