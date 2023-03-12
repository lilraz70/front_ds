import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:front_ds/models/QuartierModel.dart';
import 'package:meta/meta.dart';

import '../../requests/quartiersRepos.dart';

part 'quartiers_event.dart';
part 'quartiers_state.dart';

class QuartiersBloc extends Bloc<QuartiersEvent, QuartiersState> {
  final QuartiersRepository quartiersRepository;
  QuartiersBloc(this.quartiersRepository) : super(QuartiersLoadingState()) {
    on<QuartiersEvent>((event, emit) async {

      emit(QuartiersLoadingState());


      try{
        final quartiers= await quartiersRepository.getQuartiers();

        emit(QuartiersLoadedState(quartiers));
        print(" Quartier LoadedState called");
      } catch(e){
        emit(QuartiersErrorState(e.toString()));
      }
    });
  }
}
