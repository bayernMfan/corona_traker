part of 'global_bloc.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();
  @override
  List<Object> get props => [];
}

class GlobalInitial extends GlobalState {}

class GlobalIsLoading extends GlobalState {}

class GlobalIsLoaded extends GlobalState {
  final GlobalModel _globalInfo;

  GlobalIsLoaded(this._globalInfo);

  GlobalModel get getGlobalInfo {
    return _globalInfo;
  }

  @override
  List<Object> get props => [_globalInfo];
}

class GlobalIsNotLoaded extends GlobalState {
  final String _message;
  GlobalIsNotLoaded(this._message);
  get getMessage => _message;
  @override
  List<Object> get props => [_message];
}
