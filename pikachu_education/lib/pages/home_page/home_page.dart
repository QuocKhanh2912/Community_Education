import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pikachu_education/data/modal/question_modal.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';
import 'package:pikachu_education/data/subject/list_subject.dart';
import 'package:pikachu_education/domain/repositories/auth_repositories.dart';
import 'package:pikachu_education/domain/repositories/database_repositories.dart';
import 'package:pikachu_education/pages/authentication/component/dialog_custom.dart';
import 'package:pikachu_education/pages/authentication/login_page/bloc/login_page/login_bloc.dart';
import 'package:pikachu_education/pages/authentication/profile_page/bloc/profile_page/profile_page_bloc.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/home_page/data_home_bloc.dart';
import 'component/add_question/add_question_button.dart';
import 'component/draw_page.dart';
import 'component/list_view_question/list_view_question.dart';
import 'component/search_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userId});

  final String userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController subjectFilterController = TextEditingController();
  final GlobalKey<FormState> editQuestionFormFieldKey = GlobalKey<FormState>();
  bool showAddQuestionButton = true;

  final DataHomePageBloc _dataHomeBloc = DataHomePageBloc();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  DataUserModal currentUserInfo = DataUserModal(
      userId: 'userId', userName: 'userName', email: 'email', avatarUrl: '');
  DataQuestionModal questionInitial = DataQuestionModal(
      userId: 'userId',
      userName: 'userName',
      timePost: 'timePost',
      questionId: 'questionId',
      questionSubject: 'questionSubject',
      questionTitle: 'questionTitle',
      questionContent: 'questionContent');
  List<String> listQuestionIdLiked = [];

  getCurrentUserInfo(String userID) async {
    var currentUserFromDataBase =
        await AuthRepositories.getCurrentUserInfo(userID: userID);
    setState(() {
      currentUserInfo = currentUserFromDataBase;
    });
  }

  getListQuestionIdLiked({required String userId}) async {
    var listQuestionIdLikeFromSever =
        await DatabaseRepositories.getListQuestionIdLiked(
            currentUserId: userId);
    setState(() {
      listQuestionIdLiked = listQuestionIdLikeFromSever;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    titleController.dispose();
    subjectController.dispose();
    contentController.dispose();
    _refreshController.dispose();
    subjectFilterController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _dataHomeBloc.add(FetchDataQuestionEvent());
    getCurrentUserInfo(widget.userId);
    getListQuestionIdLiked(userId: widget.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _dataHomeBloc,
        ),
        BlocProvider(
          create: (context) => ProfilePageBloc(),
        )
      ],
      child: Scaffold(
        backgroundColor: ManagementColor.white,
        body: MultiBlocListener(
          listeners: [
            BlocListener<DataHomePageBloc, DataHomePageState>(
              listener: (context, state) {
                if (state is FetchDataQuestionSuccessState) {
                  _refreshController.refreshCompleted();
                } else if (state is PostDataQuestionSuccessState ||
                    state is DeleteQuestionSuccessState ||
                    state is EditQuestionSuccessState) {
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                } else if (state is LikedQuestionSuccessState ||
                    state is RemovedLikeQuestionSuccessState ||
                    state is PostAvatarSuccess) {
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                  getListQuestionIdLiked(userId: widget.userId);
                }
              },
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LogoutSuccessState) {
                  Navigator.pushNamed(context, PageName.loginPage);
                }
                if (state is LogoutUnSuccessState) {
                  showDialog(
                    context: context,
                    builder: (context) => DialogCustom.falseLogout(context),
                  );
                }
              },
            )
          ],
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ManagementImage.logo),
                      ],
                    ),
                    Stack(
                      children: [
                        DrawPageForHomePage(
                            currentUserInfo: currentUserInfo,
                            dataHomePageBloc: _dataHomeBloc),
                        AddQuestionButton(
                            dataHomeBloc: _dataHomeBloc,
                            currentUserInfo: currentUserInfo),
                        BlocBuilder<DataHomePageBloc, DataHomePageState>(
                          builder: (context, state) {
                            if (state is FetchDataQuestionSuccessState) {
                              return SearchButton(
                                searchController: searchController,
                                listQuestions: state.listDataUserModal,
                                subjectFilterController:
                                    subjectFilterController,
                              );
                            }
                            return SearchButton(
                              searchController: searchController,
                              listQuestions: const [],
                              subjectFilterController: subjectFilterController,
                            );
                          },
                        )
                      ],
                    ),
                    BlocBuilder<DataHomePageBloc, DataHomePageState>(
                      builder: (context, state) {
                        if (state is FetchDataQuestionSuccessState ||
                            state is SearchContentQuestionSuccessState) {
                          List<DataQuestionModal> dataQuestionFromServer = [];
                          if (state is FetchDataQuestionSuccessState) {
                            dataQuestionFromServer = state.listDataUserModal;
                          }
                          if (state is SearchContentQuestionSuccessState) {
                            dataQuestionFromServer = state.listQuestionSearched;
                          }
                          return Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 10, bottom: 10),
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width /
                                          2.3,
                                      height: 30,
                                      child: DropdownButtonFormField(
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.black),
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          fillColor: ManagementColor.white,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        icon: const Icon(Icons
                                            .arrow_drop_down_circle_outlined),
                                        hint: Text(AppLocalizations.of(context)
                                                ?.subject ??
                                            ''),
                                        items:
                                            DataAddQuestion.listSubject(context)
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            subjectFilterController.text =
                                                value ?? '';
                                            context
                                                .read<DataHomePageBloc>()
                                                .add(SearchContentQuestionEvent(
                                                    characterToSearch:
                                                        searchController.text,
                                                    subjectToFilter:
                                                        subjectFilterController.text,currentList: dataQuestionFromServer));
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SmartRefresher(
                                      controller: _refreshController,
                                      onRefresh: () {
                                        context
                                            .read<DataHomePageBloc>()
                                            .add(RefreshDataQuestion());
                                        subjectController.clear();
                                      },
                                      child: ListViewQuestion(
                                        listQuestionIdLiked:
                                            listQuestionIdLiked,
                                        titleController: titleController,
                                        editQuestionFormFieldKey:
                                            editQuestionFormFieldKey,
                                        subjectController: subjectController,
                                        contentController: contentController,
                                        dataHomePageBloc: _dataHomeBloc,
                                        dataQuestionFromServer:
                                            dataQuestionFromServer,
                                        currentUserInfo: currentUserInfo,
                                      )),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
