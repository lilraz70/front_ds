part of 'cities_bloc.dart';

abstract class CitiesState extends Equatable {
  const CitiesState();
}

class CitiesLoadingState extends CitiesState {
  @override
  List<Object> get props => [];
}


class CitiesLoadedState extends CitiesState {

  CitiesLoadedState(this.cities);
  List<CityModel> cities;

  @override
  List<Object> get props => [cities];
}


class CitiesErrorState extends CitiesState {

  CitiesErrorState(this.errorMsg);
  String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}