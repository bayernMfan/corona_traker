part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();
  @override
  List<Object> get props => [];
}

class FetchGlobal extends GlobalEvent {
  final String _country;
  FetchGlobal([this._country]);
  get getCountry => _country;
  @override
  List<Object> get props => [_country];
}

class ResetGlobal extends GlobalEvent {}
