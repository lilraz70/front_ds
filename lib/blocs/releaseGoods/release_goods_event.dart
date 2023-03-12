part of 'release_goods_bloc.dart';

abstract class ReleaseGoodsEvent extends Equatable {
  const ReleaseGoodsEvent();
}

class ReleaseGoodLoadingEvent extends ReleaseGoodsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}