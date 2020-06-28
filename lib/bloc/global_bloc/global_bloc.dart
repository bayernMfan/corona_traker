import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:provider_app/rep/API/global_repo.dart';
import 'package:provider_app/rep/models/global_model.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {

  GlobalRepo globalRepo;
  GlobalBloc(this.globalRepo);

  @override
  GlobalState get initialState => GlobalInitial();

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {
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