import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:provider_app/rep/API/global_repo.dart';
import 'package:provider_app/rep/models/global_model.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalRepo globalRepo;
  GlobalBloc(this.globalRepo) : super(GlobalInitial());

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {
    if (event is FetchGlobal) {
      yield GlobalIsLoading();

      try {
        if (event.getCountry != null) {
          GlobalModel globalInfo = await globalRepo.getGlobal(event.getCountry);
          yield GlobalIsLoaded(globalInfo);
        } else {
          GlobalModel globalInfo = await globalRepo.getGlobal();
          yield GlobalIsLoaded(globalInfo);
        }
      } catch (exception) {
        yield GlobalIsNotLoaded(exception.toString());
      }
    } else if (event is ResetGlobal) {
      yield GlobalInitial();
    }
  }

  void dispose() {
    this.close();
  }
}
