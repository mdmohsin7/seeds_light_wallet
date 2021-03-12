import 'package:bloc/bloc.dart';
import 'package:seeds/v2/domain-shared/page_state.dart';
import 'package:seeds/v2/screens/profile_screens/profile/interactor/mappers/profile_state_mapper.dart';
import 'package:seeds/v2/screens/profile_screens/profile/interactor/usecases/get_profile_use_case.dart';
import 'package:seeds/v2/screens/profile_screens/profile/interactor/viewmodels/bloc.dart';

/// --- BLOC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield state.copyWith(pageState: PageState.loading);

      var result = await GetProfileUseCase().run();

      yield ProfileStateMapper().mapResultToState(state, result);
    }
  }
}