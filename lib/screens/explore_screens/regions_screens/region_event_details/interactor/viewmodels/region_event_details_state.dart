part of 'region_event_details_bloc.dart';

class RegionEventDetailsState extends Equatable {
  final PageCommand? pageCommand;
  final PageState pageState;
  final RegionEventModel event;
  final bool isUserJoined;

  const RegionEventDetailsState({
    this.pageCommand,
    required this.pageState,
    required this.event,
    required this.isUserJoined,
  });

  @override
  List<Object?> get props => [
        pageCommand,
        pageState,
        event,
        isUserJoined,
      ];

  RegionEventDetailsState copyWith({
    PageCommand? pageCommand,
    PageState? pageState,
    RegionEventModel? event,
    bool? isUserJoined,
  }) {
    return RegionEventDetailsState(
      pageCommand: pageCommand,
      pageState: pageState ?? this.pageState,
      event: event ?? this.event,
      isUserJoined: isUserJoined ?? this.isUserJoined,
    );
  }

  factory RegionEventDetailsState.initial(RegionEventModel event) {
    return RegionEventDetailsState(
      pageState: PageState.initial,
      event: event,
      isUserJoined: event.users.contains(settingsStorage.accountName),
    );
  }
}