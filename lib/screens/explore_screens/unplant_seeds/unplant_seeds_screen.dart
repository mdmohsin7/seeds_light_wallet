import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds/blocs/rates/viewmodels/rates_bloc.dart';
import 'package:seeds/components/balance_row.dart';
import 'package:seeds/components/flat_button_long.dart';
import 'package:seeds/components/full_page_error_indicator.dart';
import 'package:seeds/components/full_page_loading_indicator.dart';
import 'package:seeds/datasource/local/models/token_data_model.dart';
import 'package:seeds/domain-shared/page_state.dart';
import 'package:seeds/domain-shared/ui_constants.dart';
import 'components/unplant_seeds_amount_entry.dart';
import 'interactor/viewmodels/unplant_seeds_bloc.dart';
import 'interactor/viewmodels/unplant_seeds_event.dart';
import 'interactor/viewmodels/unplant_seeds_state.dart';

/// UNPLANT SEEDS SCREEN
class UnplantSeedsScreen extends StatelessWidget {
  const UnplantSeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UnplantSeedsBloc(BlocProvider.of<RatesBloc>(context).state)..add(const LoadUserPlantedBalance()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Unplant')),
        body: BlocConsumer<UnplantSeedsBloc, UnplantSeedsState>(
          listener: (context, state) {},
          builder: (context, UnplantSeedsState state) {
            switch (state.pageState) {
              case PageState.initial:
                return const SizedBox.shrink();
              case PageState.loading:
                return const FullPageLoadingIndicator();
              case PageState.failure:
                return const FullPageErrorIndicator();
              case PageState.success:
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalEdgePadding),
                        height: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!,
                        child: Column(
                          children: [
                            const SizedBox(height: 26),
                            Text('Unplant amount', style: Theme.of(context).textTheme.headline6),
                            const SizedBox(height: 16),
                            UnplantSeedsAmountEntry(
                              controller: state.controller,
                              unplantedBalanceFiat: state.unplantedInputAmountFiat,
                              tokenDataModel: TokenDataModel(0),
                              onValueChange: (value) {
                                BlocProvider.of<UnplantSeedsBloc>(context).add(OnAmountChange(amountChanged: value));
                              },
                              autoFocus: state.onFocus,
                              onTapMax: () {
                                BlocProvider.of<UnplantSeedsBloc>(context)
                                    .add(OnMaxButtonTap(maxAmount: state.plantedBalance?.amount.toString() ?? '0'));
                              },
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            BalanceRow(
                                label: "Planted Balance",
                                tokenAmount: state.plantedBalance,
                                fiatAmount: state.plantedBalanceFiat)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(horizontalEdgePadding),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FlatButtonLong(
                          title: 'Unplant Seeds',
                          enabled: false,
                          //Next pr
                          onPressed: () => {},
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}