import 'package:equatable/equatable.dart';

enum EnumStateSignIn{
  initSignIn,
  loadingSignIn,
  errSignIn,
  doneSignIn
}

class SignInState extends Equatable{
  final EnumStateSignIn enumStateSignIn ;


  const SignInState({this.enumStateSignIn = EnumStateSignIn.initSignIn});

  SignInState copyWith({required EnumStateSignIn enumStateSignIn}){
    return SignInState(
      enumStateSignIn: enumStateSignIn
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [enumStateSignIn];
}


/*
enum EnumStateHome {
  IntitState,
  Loading,
  Success,
  Err,
  Loadmore,
  LoadMoreSearch,
}

class StateHome extends Equatable {
  final List<Photo>? list;
  final EnumStateHome enumStateHome;

  const StateHome({this.list, this.enumStateHome = EnumStateHome.IntitState});

  StateHome copyWith({List<Photo>? list, required EnumStateHome enumStateHome,int? page}) {
    return StateHome(
      list: list,
      enumStateHome: enumStateHome,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [enumStateHome];
}
*/
