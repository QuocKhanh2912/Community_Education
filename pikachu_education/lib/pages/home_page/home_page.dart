import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikachu_education/data/data_modal/data_question_modal.dart';
import 'package:pikachu_education/data/data_modal/data_user_modal.dart';
import 'package:pikachu_education/service/database_service/database_service_question.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../bloc/bloc_home_page/data_home_bloc.dart';
import '../../bloc/bloc_profile_page/profile_page_bloc.dart';
import '../../routes/page_name.dart';
import '../../service/database_service/database_service.dart';
import '../../utils/management_image.dart';
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
  final GlobalKey<FormState> editQuestionFormFieldKey = GlobalKey<FormState>();
  bool showAddQuestionButton = true;

  final DataHomePageBloc _dataHomeBloc = DataHomePageBloc();

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  DataUserModal currentUserInfo =
  DataUserModal(
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
    await DatabaseService.getCurrentUserInfo(userID: userID);
    setState(() {
      currentUserInfo = currentUserFromDataBase;
    });
  }

  getListQuestionIdLiked({required String userId}) async {
    var listQuestionIdLikeFromSever =
    await QuestionDatabaseService.getListQuestionIdLiked(currentUserId: userId);
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
    return BlocProvider.value(
        value: _dataHomeBloc,
        child: BlocProvider(
          create: (context) => ProfilePageBloc(),
          child: BlocListener<DataHomePageBloc, DataHomePageState>(
              listener: (context, state) {
                if (state is FetchDataQuestionSuccessState) {
                  _refreshController.refreshCompleted();
                }
                if (state is PostDataQuestionSuccessState) {
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                }
                if (state is EditQuestionSuccessState) {
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                }
                if (state is DeleteQuestionSuccessState) {
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                }
                if (state is LogoutSuccessState) {
                  Navigator.pushNamed(context, PageName.loginPage);
                }
                if (state is LikedQuestionSuccessState) {
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                  getListQuestionIdLiked(userId: widget.userId);
                }
                if (state is RemovedLikeQuestionSuccessState) {
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                  getListQuestionIdLiked(userId: widget.userId);
                }
                if(state is PostAvatarSuccess){
                  context.read<DataHomePageBloc>().add(RefreshDataQuestion());
                  getListQuestionIdLiked(userId: widget.userId);
                }
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
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
                            SearchButton(
                              searchController: searchController,
                            )
                          ],
                        ),
                        BlocBuilder<DataHomePageBloc, DataHomePageState>(
                          builder: (context, state) {
                            if (state is FetchDataQuestionSuccessState) {
                              var dataQuestionFromServer =
                                  state.listDataUserModal;
                              return Expanded(
                                child: SmartRefresher(
                                    controller: _refreshController,
                                    onRefresh: () {
                                      context
                                          .read<DataHomePageBloc>()
                                          .add(RefreshDataQuestion());
                                    },
                                    child: ListViewQuestion(
                                      listQuestionIdLiked: listQuestionIdLiked,
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
                              );
                            } else {
                              return const Expanded(
                                child: Center(
                                    child: CircularProgressIndicator()),
                              );
                            }
                          },
                        )
                      ]),
                ),
              )),
        ));
  }
}
