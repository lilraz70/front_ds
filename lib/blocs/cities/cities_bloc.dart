import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:front_ds/models/CityModel.dart';
import 'package:front_ds/requests/citiesRepos.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {

  final CitiesRepository citiesRepository;

  CitiesBloc(this.citiesRepository) : super(CitiesLoadingState()) {

    on<LoadingCitiesEvent>((event, emit) async {
     emit(CitiesLoadingState());
     //print("LoadingStateCalled");

     try{
        final cities= await citiesRepository.getCities(citiesRepository.id);
       // print(cities.length);
        //print("LoadedState called");
        emit(CitiesLoadedState(cities));
     } catch(e){
       emit(CitiesErrorState(e.toString()));
     }
    });


  }
}
