part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const introScreen = _Paths.introScreen;

  ///Credentials
  static const login = _Paths.login;
  static const signUp = _Paths.signUp;

  ///create profile

  static const nameProfile = _Paths.nameProfile;

  ///------BottombarNavigation----///
  static const bottomBarHome = _Paths.bottomBarHome;
  static const bottomBarProfile = _Paths.bottomBarProfile;

  ///----Profile---///
  static const otherUserProfile = _Paths.otherUserProfile;
  static const userProfile = _Paths.userProfile;
  static const editProfile = _Paths.editProfile;

  static const tabbarView = _Paths.tabbarView;

  static const account = _Paths.account;
}

abstract class _Paths {
  static const introScreen = '/introScreen';

  ///Credentials
  static const login = '/login';
  static const signUp = '/signUp';

  ///create profile

  static const nameProfile = '/nameProfile';

  ///------BottombarNavigation----///
  static const bottomBarHome = '/bottomBarHome';

  static const bottomBarProfile = '/bottomBarProfile';

  static const otherUserProfile = '/otherUserProfile';

  static const userProfile = '/userProfile';
  static const editProfile = '/editProfile';

  static const tabbarView = '/tabbarView';

  static const account = '/account';
}
