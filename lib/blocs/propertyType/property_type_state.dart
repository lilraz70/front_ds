part of 'property_type_bloc.dart';

abstract class PropertyTypeState extends Equatable {
  const PropertyTypeState();
}

class PropertiesLoadingState extends PropertyTypeState {
  @override
  List<Object> get props => [];
}


class PropertiesLoadedState extends PropertyTypeState {

  PropertiesLoadedState(this.properties);
  List<PropertyModel> properties;

  @override
  List<Object> get props => [properties];
}


class PropertiesErrorState extends PropertyTypeState {

  PropertiesErrorState(this.errorMsg);

  String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}
