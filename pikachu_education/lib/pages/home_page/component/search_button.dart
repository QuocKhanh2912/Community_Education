import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/pages/home_page/bloc/home_page/data_home_bloc.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchButton extends StatefulWidget {
  const SearchButton(
      {super.key,
      required this.searchController,
      required this.listQuestions,
      required this.subjectFilterController});

  final TextEditingController searchController;
  final TextEditingController subjectFilterController;
  final List<DataQuestionModal> listQuestions;

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataHomePageBloc, DataHomePageState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SizedBox(
              height: 50,
              child: AnimSearchBar(
                boxShadow: true,
                width: MediaQuery.of(context).size.width,
                helpText: AppLocalizations.of(context)?.searchQuestion ?? '',
                prefixIcon: const Icon(
                  Icons.search,
                  size: 35,
                ),
                textController: widget.searchController,
                onSuffixTap: () {
                  context.read<DataHomePageBloc>().add(
                      SearchContentQuestionEvent(
                          characterToSearch: widget.searchController.text,
                          subjectToFilter:
                              widget.subjectFilterController.text,currentList: widget.listQuestions));
                },
                suffixIcon: const Icon(Icons.search),
                textFieldColor: ManagementColor.lightYellow,
                color: ManagementColor.yellow,
                onSubmitted: (p0) {},
                animationDurationInMilli: 500,
              ),
            ),
          ),
        );
      },
    );
  }
}
