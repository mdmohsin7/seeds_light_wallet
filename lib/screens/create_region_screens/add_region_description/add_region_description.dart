import 'package:flutter/material.dart';
import 'package:seeds/components/flat_button_long.dart';
import 'package:seeds/components/text_form_field_custom.dart';
import 'package:seeds/design/app_theme.dart';
import 'package:seeds/domain-shared/ui_constants.dart';
import 'package:seeds/utils/build_context_extension.dart';

class AddRegionDescription extends StatelessWidget {
  const AddRegionDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.loc.createRegionSelectRegionAppBarTitle),
        ),
        body: SafeArea(
            minimum: const EdgeInsets.all(horizontalEdgePadding),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormFieldCustom(
                        autofocus: true,
                        maxLines: 10,
                        labelText: context.loc.createRegionAddDescriptionInputFormTitle,
                      ),
                      Text(context.loc.createRegionAddDescriptionPageInfo,
                          style: Theme.of(context).textTheme.subtitle2OpacityEmphasis),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButtonLong(
                      title: "${context.loc.createRegionSelectRegionButtonTitle} (3/5)", onPressed: () {}),
                ),
              ],
            )));
  }
}