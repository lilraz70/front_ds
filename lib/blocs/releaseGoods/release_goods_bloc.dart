import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'release_goods_event.dart';
part 'release_goods_state.dart';

class ReleaseGoodsBloc extends Bloc<ReleaseGoodsEvent, ReleaseGoodsState> {
  ReleaseGoodsBloc() : super(ReleaseGoodsInitial()) {
    on<ReleaseGoodsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
