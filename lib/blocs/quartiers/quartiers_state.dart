part of 'quartiers_bloc.dart';

@immutable
abstract class QuartiersState extends Equatable{
  const QuartiersState();
}

class QuartiersLoadingState extends QuartiersState {
  @override
  List<Object> get props => [];
}


class QuartiersLoadedState extends QuartiersState {

  QuartiersLoadedState(this.quartiers);
  List<QuartierModel> quartiers;

  @override
  List<Object> get props => [quartiers];
}


class QuartiersErrorState extends QuartiersState {

  QuartiersErrorState(this.errorMsg);
  String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}
