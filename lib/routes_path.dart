import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/common-widget/ImagePickerWrapper.dart';
import 'package:ieducation/common-widget/splash_page.dart';
import 'package:ieducation/pages/about-us/view/about_us.dart';
import 'package:ieducation/pages/about-us/view/contact_us.dart';
import 'package:ieducation/pages/address/view/adress_list_page.dart';
import 'package:ieducation/pages/address/view/create_address_page.dart';
import 'package:ieducation/pages/auth/binding/auth_binding.dart';
import 'package:ieducation/pages/auth/view/confirm_phone_number.dart';
import 'package:ieducation/pages/auth/view/create_new_password.dart';
import 'package:ieducation/pages/auth/view/forget_password.dart';
import 'package:ieducation/pages/auth/view/login_page.dart';
import 'package:ieducation/pages/auth/view/sign_up.dart';
import 'package:ieducation/pages/blogs/view/blog.dart';
import 'package:ieducation/pages/blogs/view/blog_detail.dart';
import 'package:ieducation/pages/bottom-navigation/view/bottom_navigation.dart';
import 'package:ieducation/pages/contratulations/contratulations.dart';
import 'package:ieducation/pages/course/view/course-and-category/course_and_category.dart';
import 'package:ieducation/pages/course/view/course-content/view/course_content_detail_page.dart';
import 'package:ieducation/pages/course/view/course-content/view/course_content_page.dart';
import 'package:ieducation/pages/course/view/course-content/view/selected-content/selected_content_page.dart';
import 'package:ieducation/pages/course/view/course_detail.dart';
import 'package:ieducation/pages/course/view/free_course_page.dart';
import 'package:ieducation/pages/course/view/individual_course_page.dart';
import 'package:ieducation/pages/course/view/my_course_page.dart';
import 'package:ieducation/pages/course/view/payment/course_checkout.dart';
import 'package:ieducation/pages/course/view/video_play_page.dart';
import 'package:ieducation/pages/course/view/video_section_content.dart';
import 'package:ieducation/pages/exam/view/exam_categories.dart';
import 'package:ieducation/pages/exam/view/free_exam_page.dart';
import 'package:ieducation/pages/exam/view/individual_exam/exam_detail_page.dart';
import 'package:ieducation/pages/exam/view/individual_exam/exam_given_page.dart';
import 'package:ieducation/pages/exam/view/individual_exam/exam_review_page.dart';
import 'package:ieducation/pages/leaderboard/view/leaderboard.dart';
import 'package:ieducation/pages/note-view/note_view_page.dart';
import 'package:ieducation/pages/notices/view/notice_detail.dart';
import 'package:ieducation/pages/notices/view/notice_list.dart';
import 'package:ieducation/pages/orders/view/checkout_page.dart';
import 'package:ieducation/pages/orders/view/order_list.dart';
import 'package:ieducation/pages/package/view/package_buy_page.dart';
import 'package:ieducation/pages/package/view/package_list_page.dart';
import 'package:ieducation/pages/pdf-view/pdf_view_page.dart';
import 'package:ieducation/pages/products/view/product_checkout_page.dart';
import 'package:ieducation/pages/products/view/product_detail.dart';
import 'package:ieducation/pages/products/view/product_page.dart';
import 'package:ieducation/pages/profile/view/profile_page.dart';
import 'package:ieducation/routes.dart';

class Routes {
  static final List<GetPage> routes = [
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.initial,
      page: () => const SplashPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.signup,
      page: () => SignUpPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.courseDetail,
      page: () => const CourseDetail(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.bottomNavPage,
      page: () => const BottomNavigation(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.freeCoursePage,
      page: () => const FreeCoursePage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.individualCoursePage,
      page: () => const IndividualCoursePage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.login,
      page: () => LoginPage(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.videoSectionContent,
      page: () => const VideoSectionContent(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.videoPlayPage,
      page: () => const VideoPlayPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.courseCheckoutPage,
      page: () => const CourseCheckoutPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.contratulations,
      page: () => const Contratulations(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.courseContentPage,
      page: () => const CourseContentPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.courseContentDetailPage,
      page: () => const CourseContentDetailPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.selectedContentPage,
      page: () => const SelectedContentPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.pdfViewPage,
      page: () => const PdfViewer(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.courseAndCategoryPage,
      page: () => const CourseAndCategoryPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.freeExamPage,
      page: () => const FreeExamPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.examDetailPage,
      page: () => const ExamDetailPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.examReviewPage,
      page: () => const ExamReviewPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.examGivenPage,
      page: () => const ExamGivenPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.leaderBoardPage,
      page: () => const LeaderBoardPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.blogPage,
      page: () => const BlogPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.blogDetailPage,
      page: () => const BlogDetailPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.productPage,
      page: () => const ProductPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.productDetail,
      page: () => const ProductDetail(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.addressPage,
      page: () => const AddressPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.createAddress,
      page: () => const CreateAddress(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.productCheckout,
      page: () => const ProductCheckout(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.checkOutPage,
      page: () => const CheckOutPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.forgetPassword,
      page: () => ForgetPassword(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.confirmPhoneNumber,
      page: () => const ConfirmPhoneNumber(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.createNewPassword,
      page: () => CreateNewPassword(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.noticePage,
      page: () => const NoticeListPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.noticeDetailPage,
      page: () => const NoticeDetailPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.packageListPage,
      page: () => const PackageListPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.packageBuyPage,
      page: () => const PackageBuyPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.aboutUsPage,
      page: () => const AboutUsPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.contactUsPage,
      page: () => const ContactUsPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.orderListPage,
      page: () => const OrderListPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.myCoursePage,
      page: () => const MyCoursePage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.profilePage,
      page: () => const ProfilePage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.myImagePicker,
      page: () => ImagePickerWrapper(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.examCategories,
      page: () => const ExamCategories(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      name: RoutesPath.noteViewPage,
      page: () => const NoteViewPage(),
    ),
  ];
}
