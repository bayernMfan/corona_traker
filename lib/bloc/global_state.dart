part of 'global_bloc.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();
  @override
  List<Object> get props => [];
}

class GlobalInitial extends GlobalState {}

class GlobalIsNotSerached extends GlobalState {}

class GlobalIsLoading extends GlobalState {}

class GlobalIsLoaded extends GlobalState {
  final _globalInfo;

  GlobalIsLoaded(this._globalInfo);

  GlobalModel get getGlobalInfo => _globalInfo;
  @override
  List<Object> get props => [_globalInfo];
}

class GlobalIsNotLoaded extends GlobalState {}
