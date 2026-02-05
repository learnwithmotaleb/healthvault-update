import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthvault/core/routes/route_path.dart';
import 'package:healthvault/helper/tost_message/show_snackbar.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/controller/service_selection_controller.dart';
import 'package:healthvault/presentation/screen/provider/doctor_identification/model/service_create_model.dart';

import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/service_data_model.dart';

class DoctorIdentificationController extends GetxController {

  final ApiClient apiClient = ApiClient();

  /// Required parameter from previous screen
  final String providerLabel;

  DoctorIdentificationController(this.providerLabel);

  @override
  void onInit() {
    super.onInit();
    fetchServiceCreated();


    print("Provider Label: ${providerLabel.toUpperCase()}");
  }
  /// Text controllers
  final specialisationsController = TextEditingController();
  final idOrPassPortNumberController = TextEditingController();
  final medicalLicenseNumberController = TextEditingController();
  final doctorServiceController = TextEditingController();
  final yearOfExperienceController = TextEditingController();
  final languagesSpokenController = TextEditingController();
  final addressController = TextEditingController();
  final aboutController = TextEditingController();

  /// Form key
  final formKey = GlobalKey<FormState>();

  /// Loading indicator
  final isLoading = false.obs;

  /// Service list fetched from API
  RxList<ServiceData> serviceList = <ServiceData>[].obs;

  /// Selected service
  Rx<ServiceData?> selectedService = Rx<ServiceData?>(null);

  Future<void> fetchServiceCreated() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get(
        url: ApiUrl.adminCreateService(providerLabel.toUpperCase()),
        isToken: true,
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = ServiceCreatedModel.fromJson(response.body);

        if (model.data != null && model.data!.isNotEmpty) {

          // Convert Data → ServiceData
          serviceList.assignAll(
              model.data!.map((d) => ServiceData(
                id: d.sId,
                providerType: d.providerType,
                title: d.title,
                price: d.price,
              )).toList()
          );

        } else {
          AppSnackBar.info("No services available.");
        }


      } else {
        AppSnackBar.fail(response.body['message'] ?? "Failed to load services");
      }
    } catch (e) {
      AppSnackBar.fail("Error fetching services: $e");
    } finally {
      isLoading.value = false;
    }
  }


  /// Set selected service (title + price)
  void selectService(ServiceData data) {
    selectedService.value = data;
    doctorServiceController.text = "${data.title} - ৳${data.price}";

    final serviceCtrl = Get.find<ServiceSelectionController>();
    serviceCtrl.setService(
      data.id ?? "",
      data.title ?? "",
      data.price?.toString() ?? "",
    );
  }



  @override
  void onClose() {
    specialisationsController.dispose();
    idOrPassPortNumberController.dispose();
    medicalLicenseNumberController.dispose();
    doctorServiceController.dispose();
    yearOfExperienceController.dispose();
    languagesSpokenController.dispose();
    addressController.dispose();
    aboutController.dispose();

    super.onClose();
  }
}
