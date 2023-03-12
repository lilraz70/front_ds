import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:front_ds/models/PropertyModel.dart';

import '../../requests/propertiesTypeRepos.dart';

part 'property_type_event.dart';
part 'property_type_state.dart';

class PropertyTypeBloc extends Bloc<PropertyTypeEvent, PropertyTypeState> {

  final PropertiesTypeRepository propertiesTypeRepository;
  PropertyTypeBloc(this.propertiesTypeRepository) : super(PropertiesLoadingState()) {
    on<LoadingPropertyEvent>((event, emit) async {
      emit(PropertiesLoadingState());
      print("Property LoadingStateCalled");

      try{
        final properties= await propertiesTypeRepository.getProperties();
        // print(cities.length);

        emit(PropertiesLoadedState(properties));

        print("Property LoadedState called");
      } catch(e){
        emit(PropertiesErrorState(e.toString()));
      }
    });
  }
}
