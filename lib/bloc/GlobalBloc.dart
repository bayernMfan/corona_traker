import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:provider_app/rep/API/GlobalRepo.dart';
import 'package:provider_app/rep/models/GlobalModel.dart';

class GlobalEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchGlobal extends GlobalEvent{

}

class ResetGlobal extends GlobalEvent{
  
}

class GlobalState extends Equatable{
  @override
  List<Object> get props => [];

}

class GlobalIsNotSerached extends GlobalState{

}
class GlobalIsLoading extends GlobalState{
  
}
class GlobalIsLoaded extends GlobalState{
  final _globalInfo;

  GlobalIsLoaded(this._globalInfo);

  GlobalModel get getGlobalInfo => _globalInfo;
  @override
  List<Object> get props => [_globalInfo];
}
class GlobalIsNotLoaded extends GlobalState{
  
}

class GlobalBloc extends Bloc<GlobalEvent, GlobalState>{

  GlobalRepo globalRepo;
  GlobalBloc(this.globalRepo);

  @override
  GlobalState get initialState => GlobalIsNotSerached();

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async*{
    if(event is FetchGlobal){
      yield GlobalIsLoading();

      try{
        GlobalModel globalInfo = await globalRepo.getGlobal();
        yield GlobalIsLoaded(globalInfo);
      }catch(_){
        yield GlobalIsNotLoaded();
      }
    }else if(event is ResetGlobal){
      yield GlobalIsNotSerached();
    }
  }

  void dispose(){
    this.close();
  }
}