class SubjectModal {
  int subjectId;
  String subjectEn;
  String subjectVn;

  SubjectModal(
      {required this.subjectId,
      required this.subjectEn,
      required this.subjectVn});

  static SubjectModal mathematics =
      SubjectModal(subjectId: 1, subjectEn: 'Mathematics', subjectVn: 'Toán');
  static SubjectModal literature =
      SubjectModal(subjectId: 2, subjectEn: 'Literature', subjectVn: 'Văn học');
  static SubjectModal foreignLanguage = SubjectModal(
      subjectId: 3, subjectEn: 'Foreign language', subjectVn: 'Ngoại ngữ');
  static SubjectModal history =
      SubjectModal(subjectId: 4, subjectEn: 'History', subjectVn: 'Lịch Sử');
  static SubjectModal physicalEducation = SubjectModal(
      subjectId: 5,
      subjectEn: 'Physical Education',
      subjectVn: 'Giáo dục thể chất');
  static SubjectModal physics =
      SubjectModal(subjectId: 6, subjectEn: 'Physics', subjectVn: 'Vật Lý');
  static SubjectModal chemistry =
      SubjectModal(subjectId: 7, subjectEn: 'Chemistry', subjectVn: 'Hóa Học');
  static SubjectModal technology = SubjectModal(
      subjectId: 8, subjectEn: 'Technology', subjectVn: 'Công Nghệ');
  static SubjectModal music =
      SubjectModal(subjectId: 9, subjectEn: 'Music', subjectVn: 'Âm Nhạc');
  static SubjectModal biology =
      SubjectModal(subjectId: 10, subjectEn: 'Biology', subjectVn: 'Sinh Học');
  static SubjectModal civicEducation = SubjectModal(
      subjectId: 11,
      subjectEn: 'Civic Education',
      subjectVn: 'Dáo dục công dân');
  static SubjectModal fineArt = SubjectModal(
      subjectId: 12, subjectEn: 'Fine Art', subjectVn: 'Nghệ thuật');
  static SubjectModal engineering = SubjectModal(
      subjectId: 13, subjectEn: 'Engineering', subjectVn: 'Kỹ thuật');
  static SubjectModal english =
      SubjectModal(subjectId: 14, subjectEn: 'English', subjectVn: 'Tiếng anh');
  static SubjectModal informatics = SubjectModal(
      subjectId: 15,
      subjectEn: 'Informatics',
      subjectVn: 'Công nghệ thông tin');
  static SubjectModal other =
      SubjectModal(subjectId: 16, subjectEn: 'other', subjectVn: 'khác');

  List<SubjectModal> listSubject = [
    mathematics,
    literature,
    foreignLanguage,
    history,
    physicalEducation,
    chemistry,
    technology,
    music,
    biology,
    civicEducation,
    fineArt,
    engineering,
    english,
    informatics,
    other
  ];
}
