import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/global/language/controller/language_controller.dart';
import 'package:healthvault/presentation/screen/appointment/controller/appointment_controller.dart';
import 'package:healthvault/presentation/screen/appointment/screen/appointment_screen.dart';
import 'package:healthvault/presentation/screen/bottom_navigationbar/controller/bottom_navigation_controller.dart';
import 'package:healthvault/presentation/screen/category_screen/clinics/screen/clinic_screen.dart';
import 'package:healthvault/presentation/screen/category_screen/doctor/controller/doctor_controller.dart';
import 'package:healthvault/presentation/screen/category_screen/doctor/screen/doctor_screen.dart';
import 'package:healthvault/presentation/screen/category_screen/info_provider_details/controller/info_provider_details_controller.dart';
import 'package:healthvault/presentation/screen/category_screen/info_provider_details/screen/info_provider_details_screen.dart';
import 'package:healthvault/presentation/screen/category_screen/pharmacy/controller/pharmacy_controller.dart';
import 'package:healthvault/presentation/screen/category_screen/pharmacy/screen/pharmacy_screen.dart';
import 'package:healthvault/presentation/screen/category_screen/plastic_surgery/controller/plastic_controller.dart';
import 'package:healthvault/presentation/screen/category_screen/plastic_surgery/screen/plastic_screen.dart';
import 'package:healthvault/presentation/screen/category_screen/wellness/controller/wellness_controller.dart';
import 'package:healthvault/presentation/screen/category_screen/wellness/screen/wellness_screen.dart';
import 'package:healthvault/presentation/screen/emergency_screen/controller/emergency_controller.dart';
import 'package:healthvault/presentation/screen/health_and_wellness_article/controller/health_article_controller.dart';
import 'package:healthvault/presentation/screen/health_and_wellness_article/screen/health_article_screen.dart';
import 'package:healthvault/presentation/screen/health_and_wellness_details/controller/health_wellness_details_controller.dart';
import 'package:healthvault/presentation/screen/home/controller/home_controller.dart';
import 'package:healthvault/presentation/screen/home/screen/home_screen.dart';
import 'package:healthvault/presentation/screen/language/screen/language_screen.dart';
import 'package:healthvault/presentation/screen/onboarding/controller/onboarding_controller.dart';
import 'package:healthvault/presentation/screen/onboarding/screen/onboarding_screen.dart';
import 'package:healthvault/presentation/screen/profile/change_password/controller/change_password_controller.dart';
import 'package:healthvault/presentation/screen/profile/change_password/screen/change_password_screen.dart';
import 'package:healthvault/presentation/screen/profile/document_profile/screen/document_profile_screen.dart';
import 'package:healthvault/presentation/screen/profile/edit_profile/controller/edit_profile_controller.dart';
import 'package:healthvault/presentation/screen/profile/family_member_document/controller/family_member_document_controller.dart';
import 'package:healthvault/presentation/screen/profile/faqs_profile/controller/faqs_controller.dart';
import 'package:healthvault/presentation/screen/profile/favourite_profile/controller/favourite_controller.dart';
import 'package:healthvault/presentation/screen/profile/favourite_profile/screen/favourite_screen.dart';
import 'package:healthvault/presentation/screen/profile/health_card_profile/controller/health_card_controller.dart';
import 'package:healthvault/presentation/screen/profile/health_card_profile/screen/health_card_screen.dart';
import 'package:healthvault/presentation/screen/profile/health_log_my_self/controller/health_log_mySelf_controller.dart';
import 'package:healthvault/presentation/screen/profile/health_log_profile/screen/health_log_screen.dart';

import 'package:healthvault/presentation/screen/profile/insurance_profile/controller/insurancce_controller.dart';
import 'package:healthvault/presentation/screen/profile/insurance_profile/screen/insurance_screen.dart';
import 'package:healthvault/presentation/screen/profile/language_profile/controller/language_profile_controller.dart';
import 'package:healthvault/presentation/screen/profile/language_profile/screen/language_profile_screen.dart';
import 'package:healthvault/presentation/screen/profile/notification_profile/screen/notification_screen.dart';
import 'package:healthvault/presentation/screen/profile/privacy_policy_profile/controller/privacy_policy_controller.dart';
import 'package:healthvault/presentation/screen/profile/privacy_policy_profile/screen/privacy_policy_screen.dart';
import 'package:healthvault/presentation/screen/profile/terms_and_condition_profile/controller/terms_condition_controller.dart';
import 'package:healthvault/presentation/screen/profile/terms_and_condition_profile/screen/terms_condition_screen.dart';
import 'package:healthvault/presentation/screen/provider/appalment_document/controller/appalment_document_controller.dart';
import 'package:healthvault/presentation/screen/provider/appalment_document/screen/appalment_document_screen.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/controller/doctor_indentification_controller.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/screen/doctor_identification_screen.dart';
import 'package:healthvault/presentation/screen/provider/medical_license/controller/medical_license_controller.dart';
import 'package:healthvault/presentation/screen/provider/medical_license/screen/medical_license_screen.dart';
import 'package:healthvault/presentation/screen/provider/passport_identification/controller/passport_identification_controller.dart';
import 'package:healthvault/presentation/screen/provider/passport_identification/screen/passport_identification_screen.dart';
import 'package:healthvault/presentation/screen/provider/provider_bottom_nav/controller/provider_bottom_nav_controller.dart';
import 'package:healthvault/presentation/screen/provider/provider_bottom_nav/screen/provider_bottom_nav_screen.dart';
import 'package:healthvault/presentation/screen/provider/provider_details/controller/provider_details_controller.dart';
import 'package:healthvault/presentation/screen/provider/provider_details/screen/provider_details_screen.dart';
import 'package:healthvault/presentation/screen/provider/provider_edit_schedule/controller/provider_edit_schedule_controller.dart';
import 'package:healthvault/presentation/screen/provider/provider_edit_schedule/screen/provider_edit_schedule_screen.dart';
import 'package:healthvault/presentation/screen/provider/provider_home/controller/provider_home_controller.dart';
import 'package:healthvault/presentation/screen/provider/provider_home/screen/provider_home_screen.dart';
import 'package:healthvault/presentation/screen/provider/provider_profile/controller/provider_profile_controller.dart';
import 'package:healthvault/presentation/screen/provider/provider_profile/screen/provider_profile_screen.dart';
import 'package:healthvault/presentation/screen/provider/provider_service/controller/provider_service_controller.dart';
import 'package:healthvault/presentation/screen/provider/provider_service/screen/provider_service_screen.dart';
import 'package:healthvault/presentation/screen/provider/provider_task/controller/provider_task_controller.dart';
import 'package:healthvault/presentation/screen/provider/provider_task/screen/provider_task_screen.dart';
import 'package:healthvault/presentation/screen/provider/select_provider/controller/provider_selection_controller.dart';
import 'package:healthvault/presentation/screen/provider/select_provider/screen/provider_selection_screen.dart';
import 'package:healthvault/presentation/screen/reminder/add_medicine/controller/add_reminder_controller.dart';
import 'package:healthvault/presentation/screen/reminder/add_medicine/screen/add_reminder_screen.dart';
import 'package:healthvault/presentation/screen/reminder/edit_medicine/controller/edit_reminder_controller.dart';
import 'package:healthvault/presentation/screen/reminder/edit_medicine/screen/edit_reminder_screen.dart';
import 'package:healthvault/presentation/screen/reminder/select_reminder/controller/select_reminder_controller.dart';
import 'package:healthvault/presentation/screen/reminder/select_reminder/screen/select_reminder_screen.dart';
import 'package:healthvault/presentation/screen/select/controller/select_controller.dart';
import 'package:healthvault/presentation/screen/select/screen/select_screen.dart';
import 'package:healthvault/presentation/screen/splash/controller/splash_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/Identification/controller/identification_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/forget/controller/forget_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/login/controller/login_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/registaration/controller/registration_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/reset/controller/reset_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/signup/controller/signup_controller.dart';
import 'package:healthvault/presentation/screen/user/auth/verification/controller/vefication_controller.dart';
import 'package:healthvault/service/api_service.dart';


import '../../presentation/screen/bottom_navigationbar/screen/bottom_navigation_screen.dart';
import '../../presentation/screen/category_screen/clinics/controller/clinic_controller.dart';
import '../../presentation/screen/category_screen/details/controller/details_controller.dart';
import '../../presentation/screen/category_screen/details/screen/details_screen.dart';
import '../../presentation/screen/category_screen/diagnostic_center/controller/diagonstic_controller.dart';
import '../../presentation/screen/category_screen/diagnostic_center/screen/diagnostic_screen.dart';
import '../../presentation/screen/category_screen/in_vito_fertilization/controller/in_vito_fertilization_controller.dart';
import '../../presentation/screen/category_screen/in_vito_fertilization/screen/in_vito_fertilization_screen.dart';
import '../../presentation/screen/category_screen/medical_tourism/controller/medical_tourism_controller.dart';
import '../../presentation/screen/category_screen/medical_tourism/screen/medical_tourism_screen.dart';
import '../../presentation/screen/category_screen/search/controller/search_controller.dart';
import '../../presentation/screen/category_screen/search/screen/search_screen.dart';
import '../../presentation/screen/emergency_screen/screen/emergency_screen.dart';
import '../../presentation/screen/health_and_wellness_details/screen/health_wellness_details_screen.dart';
import '../../presentation/screen/profile/account_setting_profile/controller/account_setting_controller.dart';
import '../../presentation/screen/profile/account_setting_profile/screen/acccount_setting_screen.dart';
import '../../presentation/screen/profile/add_document_profile/controller/add_document_controller.dart';
import '../../presentation/screen/profile/add_document_profile/screen/add_document_screen.dart';
import '../../presentation/screen/profile/document_profile/controller/document_profile_controller.dart';
import '../../presentation/screen/profile/edit_profile/screen/edit_profile_screen.dart';
import '../../presentation/screen/profile/family_member_document/screen/family_member_document_screen.dart';
import '../../presentation/screen/profile/faqs_profile/screen/faqs_screen.dart';
import '../../presentation/screen/profile/health_log_family/controller/health_log_family_controller.dart';
import '../../presentation/screen/profile/health_log_family/screen/health_log_family_screen.dart';
import '../../presentation/screen/profile/health_log_my_self/screen/health_log_mySelf_screen.dart';
import '../../presentation/screen/profile/health_log_profile/controller/health_log_controller.dart';
import '../../presentation/screen/profile/insurance_family_member/controller/insurance_family_controller.dart';
import '../../presentation/screen/profile/insurance_family_member/screen/insurance_family_screen.dart';
import '../../presentation/screen/profile/insurance_self_member/controller/insurance_myself_controller.dart';
import '../../presentation/screen/profile/insurance_self_member/screen/insurance_myself_screen.dart';
import '../../presentation/screen/profile/notification_profile/controller/notification_controller.dart';
import '../../presentation/screen/profile/profile/controller/profile_controller.dart';
import '../../presentation/screen/profile/profile/screen/profile_screen.dart';
import '../../presentation/screen/provider/pharmacy_identification/controller/pharmacy_identification_controller.dart';
import '../../presentation/screen/provider/pharmacy_identification/screen/pharmacy_identification_screen.dart';
import '../../presentation/screen/splash/screen/splash_screen.dart';
import '../../presentation/screen/user/auth/Identification/screen/identification_screen.dart';
import '../../presentation/screen/user/auth/forget/screen/forget_screen.dart';
import '../../presentation/screen/user/auth/login/screen/login_screen.dart';
import '../../presentation/screen/user/auth/registaration/screen/registration_screen.dart';
import '../../presentation/screen/user/auth/reset/screen/reset_screen.dart';
import '../../presentation/screen/user/auth/signup/screen/signup_screen.dart';
import '../../presentation/screen/user/auth/verification/screen/verification_screen.dart';
import '../../presentation/screen/user/auth/verify/controller/verify_controller.dart';
import '../../presentation/screen/user/auth/verify/screen/verify_screen.dart';

class AppRouter {
  static final List<GetPage<dynamic>> pages = [

    GetPage(
      name: RoutePath.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: RoutePath.onboard,
      page: () =>  OnBoardingScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(OnBoardingController());
      }),
    ),


    GetPage(
      name: RoutePath.languages,
      page: () =>  LanguageScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(LanguageController());
      }),
    ),

    GetPage(
      name: RoutePath.select,
      page: () =>  SelectScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(SelectController());
      }),
    ),
    GetPage(
      name: RoutePath.login,
      page: () =>  LoginScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),


    GetPage(
      name: RoutePath.signup,
      page: () =>  SignupScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(SignupController());
      }),
    ),



    GetPage(
      name: RoutePath.verification,
      page: () =>  VerificationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(VerificationController());
      }),
    ),



    GetPage(
      name: RoutePath.reset,
      page: () =>  ResetScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ResetController());
      }),
    ),




    GetPage(
      name: RoutePath.forget,
      page: () =>  ForgetScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ForgetController());
      }),
    ),




    GetPage(
      name: RoutePath.verify,
      page: () =>  VerifyScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(VerifyController());
      }),
    ),



    GetPage(
      name: RoutePath.registration,
      page: () =>  RegistrationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(RegistrationController());
      }),
    ),





    GetPage(
      name: RoutePath.identification,
      page: () =>  IdentificationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(IdentificationController());
      }),
    ),




    GetPage(
      name: RoutePath.home,
      page: () =>  HomeScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),



    GetPage(
      name: RoutePath.doctor,
      page: () =>  DoctorScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(DoctorController(apiClient: ApiClient()));
      }),
    ),

    GetPage(
      name: RoutePath.pharmacy,
      page: () =>  PharmacyScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(PharmacyController());
      }),
    ),


    GetPage(
      name: RoutePath.clinic,
      page: () =>  ClinicScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ClinicController());
      }),
    ),

    GetPage(
      name: RoutePath.emergency,
      page: () =>  EmergencyScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(EmergencyController());
      }),
    ),




    GetPage(
      name: RoutePath.diagnostic,
      page: () =>  DiagnosticScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(DiagonsticController());
      }),
    ),



    GetPage(
      name: RoutePath.plastic,
      page: () =>  PlasticScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(PlasticController());
      }),
    ),





    GetPage(
      name: RoutePath.medicalTourism,
      page: () =>  MedicalTourismScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(MedicalTourismController());
      }),
    ),



    GetPage(
      name: RoutePath.inVitoFertilization,
      page: () =>  InVitoFertilizationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(InVitoFertilizationController());
      }),
    ),




    GetPage(
      name: RoutePath.wellness,
      page: () =>  WellnessScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(WellnessController());
      }),
    ),



    GetPage(
      name: RoutePath.details,
      page: () =>  DetailsScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(DetailsController());
      }),
    ),

    GetPage(
      name: RoutePath.infoProviderDetails,
      page: () =>  InfoProviderDetailsScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(InfoProviderDetailsController());
      }),
    ),



    GetPage(
      name: RoutePath.search,
      page: () =>  SearchScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(SearchController());
      }),
    ),





    GetPage(
      name: RoutePath.search,
      page: () =>  SearchScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(SearchController());
      }),
    ),






    GetPage(
      name: RoutePath.healthArticle,
      page: () =>  HealthArticleScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(HealthArticleController());
      }),
    ),





    GetPage(
      name: RoutePath.healthDetail,
      page: () => HealthWellnessDetailsScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        // Register dependencies in order
        Get.put(HealthArticleController());       // <-- add this
        Get.put(HealthWellnessDetailsController());
      }),
    ),





    GetPage(
      name: RoutePath.appointment,
      page: () =>  AppointmentScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(AppointmentController());
      }),
    ),




    GetPage(
      name: RoutePath.selectReminder,
      page: () =>  SelectReminderScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(SelectReminderController());
      }),
    ),

    GetPage(
      name: RoutePath.editReminder,
      page: () =>  EditReminderScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(EditReminderController());
      }),
    ),


    GetPage(
      name: RoutePath.addReminder,
      page: () =>  AddReminderScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(AddReminderController());
      }),
    ),


    GetPage(
      name: RoutePath.bottomNav,
      page: () =>  BottomNavigationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(BottomNavController());
      }),
    ),


    GetPage(
      name: RoutePath.editProfile,
      page: () =>  EditProfileScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(EditProfileController());
      }),
    ),



    GetPage(
      name: RoutePath.profile,
      page: () =>  ProfileScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      }),
    ),

    GetPage(
      name: RoutePath.document,
      page: () =>  DocumentProfileScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(DocumentProfileController());
      }),
    ),

    GetPage(
      name: RoutePath.addDocument,
      page: () =>  AddDocumentScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(AddDocumentController());
      }),
    ),

   GetPage(
      name: RoutePath.familyDocument,
      page: () =>  FamilyMemberDocumentScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(FamilyMemberDocumentController());
      }),
    ),


   GetPage(
      name: RoutePath.insurance,
      page: () =>  InsuranceScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(InsuranceController());
      }),
    ),


   GetPage(
      name: RoutePath.insuranceMySelf,
      page: () =>  InsuranceMyselfScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(InsuranceMyselfController());
      }),
    ),


   GetPage(
      name: RoutePath.insuranceFamily,
      page: () =>  InsuranceFamilyScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(InsuranceFamilyController());
      }),
    ),



   GetPage(
      name: RoutePath.healthLog,
      page: () =>  HealthLogScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(HealthLogController());
      }),
    ),




   GetPage(
      name: RoutePath.healthLogMySelf,
      page: () =>  HealthLogMyselfScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(HealthLogMyselfController());
      }),
    ),




   GetPage(
      name: RoutePath.healthLogFamily,
      page: () =>  HealthLogFamilyScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(HealthLogFamilyController());
      }),
    ),


   GetPage(
      name: RoutePath.healthCard,
      page: () =>  HealthCardScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(HealthCardController());
      }),
    ),




   GetPage(
      name: RoutePath.notification,
      page: () =>  NotificationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
    ),

  GetPage(
      name: RoutePath.favourite,
      page: () =>  FavouriteScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(FavouriteController());
      }),
    ),


  GetPage(
      name: RoutePath.termsAndCondition,
      page: () =>  TermsConditionScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(TermsConditionController());
      }),
    ),



  GetPage(
      name: RoutePath.faq,
      page: () =>  FaqsScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(FaqsController());
      }),
    ),



  GetPage(
      name: RoutePath.policy,
      page: () =>  PrivacyPolicyScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(PrivacyPolicyController());
      }),
    ),



  GetPage(
      name: RoutePath.accountSetting,
      page: () =>  AccountSettingScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(AccountSettingController());
      }),
    ),



  GetPage(
      name: RoutePath.changePassword,
      page: () =>  ChangePasswordScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ChangePasswordController());
      }),
    ),



  GetPage(
      name: RoutePath.changeLanguageProfile,
      page: () =>  LanguageProfileScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(LanguageProfileController());
      }),
    ),


  GetPage(
      name: RoutePath.providerSelection,
      page: () =>  ProviderSelectionScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderSelectionController());
      }),
    ),



  GetPage(
      name: RoutePath.doctorIdentification,
      page: () =>  DoctorIdentificationScreen(),
      transition: Transition.fadeIn,
    binding: BindingsBuilder(() {
      final args = Get.arguments;  // <-- argument পাওয়া গেল

      final providerLabel = args["providerLabel"] ?? "";

      Get.put(DoctorIdentificationController(providerLabel));
    }),
    ),



  GetPage(
      name: RoutePath.pharmacyIdentification,
      page: () =>  PharmacyIdentificationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(PharmacyIdentificationController());
      }),
    ),




  GetPage(
      name: RoutePath.providerHome,
      page: () =>  ProviderHomeScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderHomeController());
      }),
    ),



  GetPage(
      name: RoutePath.providerNav,
      page: () =>  ProviderBottomNavScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderBottomNavController());
      }),
    ),



  GetPage(
      name: RoutePath.providerTask,
      page: () =>  ProviderTaskScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderTaskController());
      }),
    ),



  GetPage(
      name: RoutePath.providerDetails,
      page: () =>  ProviderDetailsScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderDetailsController());
      }),
    ),



  GetPage(
      name: RoutePath.appalmentDocument,
      page: () =>  AppalmentDocumentScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(AppalmentDocumentController());
      }),
    ),




  GetPage(
      name: RoutePath.medicalLicense,
      page: () =>  MedicalLicenseScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(MedicalLicenseController());
      }),
    ),



  GetPage(
      name: RoutePath.passportPhoto,
      page: () =>  PassportIdentificationScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PassportIdentificationController());
        Get.lazyPut(() => PharmacyIdentificationController());

      }),
    ),


  GetPage(
      name: RoutePath.providerProfile,
      page: () =>  ProviderProfileScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderProfileController());
      }),
    ),



  GetPage(
      name: RoutePath.providerService,
      page: () =>  ProviderServiceScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderServiceController());
      }),
    ),



  GetPage(
      name: RoutePath.providerSchedule,
      page: () =>  ProviderEditScheduleScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(ProviderEditScheduleController());
      }),
    ),






  ];
}
