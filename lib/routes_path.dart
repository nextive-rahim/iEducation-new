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
      name: RoutesPath.initial,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RoutesPath.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RoutesPath.signup,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: RoutesPath.courseDetail,
      page: () => const CourseDetail(),
    ),
    GetPage(
      name: RoutesPath.bottomNavPage,
      page: () => const BottomNavigation(),
    ),
    GetPage(
      name: RoutesPath.freeCoursePage,
      page: () => const FreeCoursePage(),
    ),
    GetPage(
      name: RoutesPath.individualCoursePage,
      page: () => const IndividualCoursePage(),
    ),
    GetPage(
      name: RoutesPath.login,
      page: () => LoginPage(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: RoutesPath.videoSectionContent,
      page: () => const VideoSectionContent(),
    ),
    GetPage(
      name: RoutesPath.videoPlayPage,
      page: () => const VideoPlayPage(),
    ),
    GetPage(
      name: RoutesPath.courseCheckoutPage,
      page: () => const CourseCheckoutPage(),
    ),
    GetPage(
      name: RoutesPath.contratulations,
      page: () => const Contratulations(),
    ),
    GetPage(
      name: RoutesPath.courseContentPage,
      page: () => const CourseContentPage(),
    ),
    GetPage(
      name: RoutesPath.courseContentDetailPage,
      page: () => const CourseContentDetailPage(),
    ),
    GetPage(
      name: RoutesPath.selectedContentPage,
      page: () => const SelectedContentPage(),
    ),
    GetPage(
      name: RoutesPath.pdfViewPage,
      page: () => const PdfViewer(),
    ),
    GetPage(
      name: RoutesPath.courseAndCategoryPage,
      page: () => const CourseAndCategoryPage(),
    ),
    GetPage(
      name: RoutesPath.freeExamPage,
      page: () => const FreeExamPage(),
    ),
    GetPage(
      name: RoutesPath.examDetailPage,
      page: () => const ExamDetailPage(),
    ),
    GetPage(
      name: RoutesPath.examReviewPage,
      page: () => const ExamReviewPage(),
    ),
    GetPage(
      name: RoutesPath.examGivenPage,
      page: () => const ExamGivenPage(),
    ),
    GetPage(
      name: RoutesPath.leaderBoardPage,
      page: () => const LeaderBoardPage(),
    ),
    GetPage(
      name: RoutesPath.blogPage,
      page: () => const BlogPage(),
    ),
    GetPage(
      name: RoutesPath.blogDetailPage,
      page: () => const BlogDetailPage(),
    ),
    GetPage(
      name: RoutesPath.productPage,
      page: () => const ProductPage(),
    ),
    GetPage(
      name: RoutesPath.productDetail,
      page: () => const ProductDetail(),
    ),
    GetPage(
      name: RoutesPath.addressPage,
      page: () => const AddressPage(),
    ),
    GetPage(
      name: RoutesPath.createAddress,
      page: () => const CreateAddress(),
    ),
    GetPage(
      name: RoutesPath.productCheckout,
      page: () => const ProductCheckout(),
    ),
    GetPage(
      name: RoutesPath.checkOutPage,
      page: () => const CheckOutPage(),
    ),
    GetPage(
      name: RoutesPath.forgetPassword,
      page: () => ForgetPassword(),
    ),
    GetPage(
      name: RoutesPath.confirmPhoneNumber,
      page: () => const ConfirmPhoneNumber(),
    ),
    GetPage(
      name: RoutesPath.createNewPassword,
      page: () => CreateNewPassword(),
    ),
    GetPage(
      name: RoutesPath.noticePage,
      page: () => const NoticeListPage(),
    ),
    GetPage(
      name: RoutesPath.noticeDetailPage,
      page: () => const NoticeDetailPage(),
    ),
    GetPage(
      name: RoutesPath.packageListPage,
      page: () => const PackageListPage(),
    ),
    GetPage(
      name: RoutesPath.packageBuyPage,
      page: () => const PackageBuyPage(),
    ),
    GetPage(
      name: RoutesPath.aboutUsPage,
      page: () => const AboutUsPage(),
    ),
    GetPage(
      name: RoutesPath.contactUsPage,
      page: () => const ContactUsPage(),
    ),
    GetPage(
      name: RoutesPath.orderListPage,
      page: () => const OrderListPage(),
    ),
    GetPage(
      name: RoutesPath.myCoursePage,
      page: () => const MyCoursePage(),
    ),
    GetPage(
      name: RoutesPath.profilePage,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: RoutesPath.myImagePicker,
      page: () => ImagePickerWrapper(),
    ),
    GetPage(
      name: RoutesPath.examCategories,
      page: () => const ExamCategories(),
    ),
    GetPage(
      name: RoutesPath.noteViewPage,
      page: () => const NoteViewPage(),
    ),
  ];
}
