import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SearchButton extends StatefulWidget {
  const SearchButton({super.key,required this.searchController});

  final TextEditingController searchController;

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 8, right: 8),
        child: SizedBox(
          height: 50,
          child: AnimSearchBar(
            boxShadow: true,
            width: MediaQuery.of(context).size.width,
            helpText: AppLocalizations.of(context)?.searchQuestion??'',
            prefixIcon: const Icon(
              Icons.search,
              size: 35,
            ),
            textController: widget.searchController,
            onSuffixTap: () {
              setState(() {
                widget.searchController.clear();
              });
            },
            textFieldColor: ManagementColor.lightYellow,
            color: ManagementColor.yellow,
            onSubmitted: (p0) {},
            animationDurationInMilli: 500,
          ),
        ),
      ),
    );
  }
}
