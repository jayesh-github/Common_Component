import 'package:common_jds_flutter/common/app_colors.dart';
import 'package:common_jds_flutter/common/styles/dimens.dart';
import 'package:common_jds_flutter/widgets/dropdown/model/dropdownitem.dart';
import 'package:common_jds_flutter/widgets/dropdown/single_select_search_dropdown.dart';
import 'package:common_jds_flutter_example/common/widget_story_ui.dart';
import 'package:flutter/material.dart';

import '../data/single_select_search_dropdown_widget_properties.dart';

class SingleSelectSearchDropdownWidgetPage extends StatefulWidget {
  const SingleSelectSearchDropdownWidgetPage({Key? key}) : super(key: key);

  @override
  State<SingleSelectSearchDropdownWidgetPage> createState() =>
      _SingleSelectSearchDropdownWidgetPageState();
}

class _SingleSelectSearchDropdownWidgetPageState
    extends State<SingleSelectSearchDropdownWidgetPage> {
  DropdownItem? selectedDropdown;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.size64, horizontal: Dimens.size32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetStory(
                    title: WidgetProperties.pageDetail.title,
                    description: WidgetProperties.pageDetail.description,
                    code: WidgetProperties.pageDetail.code ?? '',
                    classPropertiesData: WidgetProperties.classPropertiesData,
                    widget: SingleSelectSearchDropdown(
                      items: WidgetProperties.dropdownList,
                      selectedItem: selectedDropdown,
                      searchController: searchController,
                      onSearchQueryChanged: (searchQuery) {
                        WidgetProperties.dropdownList = WidgetProperties
                            .tempDropdownList
                            .where((element) => element.description!
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                        setState(() {});
                      },
                      onClear: () {
                        WidgetProperties.dropdownList =
                            WidgetProperties.tempDropdownList;
                        setState(() {});
                      },
                      onItemSelected: (selected) {
                        setState(() {
                          selectedDropdown = selected;
                        });
                      },
                      onMenuStateChanged: (state) {
                        searchController.clear();
                        WidgetProperties.dropdownList =
                            WidgetProperties.tempDropdownList;
                        setState(() {});
                      },
                      hint: 'Dropdown Hint',
                      borderColor: AppColors.black,
                    ),
                  ),
                ])));
  }
}
