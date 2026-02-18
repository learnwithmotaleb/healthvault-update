import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../model/model.dart';

final _log = Logger();

class AddDocumentController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _picker = ImagePicker();

  final String baseUrl = "${ApiUrl.mainDomain}/";

  final RxList<String> mySelfImages   = <String>[].obs;
  final RxList<String> familyImages   = <String>[].obs;
  final RxBool isLoading              = false.obs;
  final RxBool isMySelfUploading      = false.obs;
  final RxBool isFamilyUploading      = false.obs;

  @override
  void onInit() {
    super.onInit();
    _log.i("[DOC] Controller initialized — baseUrl: $baseUrl");
    _log.i("[DOC] fetchDocumentSelf URL: ${ApiUrl.fetchDocumentSelf}");
    fetchImages();
  }

  // ── raw path → full URL ─────────────────────────────────────────────
  String _toUrl(String raw) {
    final url = baseUrl + raw.replaceAll(r'\', '/');
    _log.d("[DOC] _toUrl: $raw → $url");
    return url;
  }

  // ── full URL → raw path ─────────────────────────────────────────────
  String _toPath(String fullUrl) {
    final path = fullUrl.replaceFirst(baseUrl, '').replaceAll('/', r'\');
    _log.d("[DOC] _toPath: $fullUrl → $path");
    return path;
  }

  // ════════════════════════════════════════════════════════════════════
  //  FETCH (GET)
  // ════════════════════════════════════════════════════════════════════
  Future<void> fetchImages() async {
    _log.i("[DOC] fetchImages() → ${ApiUrl.fetchDocumentSelf}");
    isLoading.value = true;

    final res = await _apiClient.put(
      url: ApiUrl.fetchDocumentSelf,
      isToken: true,
    );

    isLoading.value = false;

    _log.i("[DOC] statusCode: ${res.statusCode}");
    _log.i("[DOC] raw body type: ${res.body.runtimeType}");
    _log.i("[DOC] raw body: ${res.body}");

    if (!res.isOk) {
      _log.e("[DOC] fetch failed: ${res.statusCode} ${res.statusText}");
      AppSnackBar.fail("Failed to load documents (${res.statusCode})");
      return;
    }

    try {
      // res.body is already decoded by ApiClient._handleResponse
      final Map<String, dynamic> body = res.body is String
          ? jsonDecode(res.body)   // fallback if still string
          : Map<String, dynamic>.from(res.body);

      _log.i("[DOC] body keys: ${body.keys}");

      final rawData = body['data'];
      _log.i("[DOC] data type: ${rawData.runtimeType}");
      _log.i("[DOC] data value: $rawData");

      if (rawData == null) {
        _log.w("[DOC] data is null — no documents yet");
        mySelfImages.clear();
        familyImages.clear();
        return;
      }

      // Handle both List and Map
      final Map<String, dynamic> dataJson = rawData is List
          ? Map<String, dynamic>.from(rawData.first)
          : Map<String, dynamic>.from(rawData);

      _log.i("[DOC] dataJson keys: ${dataJson.keys}");

      final mySelfRaw  = dataJson['medical_mySelf_image'];
      final familyRaw  = dataJson['medical_family_image'];

      _log.i("[DOC] mySelf raw: $mySelfRaw (type: ${mySelfRaw.runtimeType})");
      _log.i("[DOC] family raw: $familyRaw (type: ${familyRaw.runtimeType})");

      mySelfImages.value = mySelfRaw != null
          ? List<String>.from(mySelfRaw).map(_toUrl).toList()
          : [];

      familyImages.value = familyRaw != null
          ? List<String>.from(familyRaw).map(_toUrl).toList()
          : [];

      _log.i("[DOC] ✅ mySelfImages: ${mySelfImages.length} → ${mySelfImages}");
      _log.i("[DOC] ✅ familyImages: ${familyImages.length} → ${familyImages}");

    } catch (e, stack) {
      _log.e("[DOC] ❌ parse error: $e");
      _log.e("[DOC] stack: $stack");
      AppSnackBar.fail("Parse error: $e");
    }
  }

  // ════════════════════════════════════════════════════════════════════
  //  UPLOAD
  // ════════════════════════════════════════════════════════════════════
  Future<void> pickAndUploadMySelf() async {
    _log.i("[DOC] pickAndUploadMySelf() called");
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) {
      _log.w("[DOC] pickAndUploadMySelf: no image selected");
      return;
    }
    _log.i("[DOC] picked MySelf: ${picked.path}");
    await _uploadMySelf(File(picked.path));
  }

  Future<void> pickAndUploadFamily() async {
    _log.i("[DOC] pickAndUploadFamily() called");
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) {
      _log.w("[DOC] pickAndUploadFamily: no image selected");
      return;
    }
    _log.i("[DOC] picked Family: ${picked.path}");
    await _uploadFamily(File(picked.path));
  }

  Future<void> _uploadMySelf(File file) async {
    _log.i("[DOC] _uploadMySelf → URL: ${ApiUrl.addDocumentSelf}, file: ${file.path}");
    isMySelfUploading.value = true;

    final res = await _apiClient.putMultipart(
      url: ApiUrl.addDocumentSelf,
      fileKey: "medical_mySelf_image",
      file: file,
      isToken: true,
    );

    isMySelfUploading.value = false;
    _log.i("[DOC] _uploadMySelf result: ${res.statusCode} — ${res.body}");

    if (res.isOk) {
      AppSnackBar.success("MySelf image uploaded");
      await fetchImages();
    } else {
      _log.e("[DOC] _uploadMySelf failed: ${res.statusCode} ${res.statusText}");
      AppSnackBar.fail("Upload failed (${res.statusCode})");
    }
  }

  Future<void> _uploadFamily(File file) async {
    _log.i("[DOC] _uploadFamily → URL: ${ApiUrl.addDocumentFamily}, file: ${file.path}");
    isFamilyUploading.value = true;

    final res = await _apiClient.putMultipart(
      url: ApiUrl.addDocumentFamily,
      fileKey: "medical_family_image",
      file: file,
      isToken: true,
    );

    isFamilyUploading.value = false;
    _log.i("[DOC] _uploadFamily result: ${res.statusCode} — ${res.body}");

    if (res.isOk) {
      AppSnackBar.success("Family image uploaded");
      await fetchImages();
    } else {
      _log.e("[DOC] _uploadFamily failed: ${res.statusCode} ${res.statusText}");
      AppSnackBar.fail("Upload failed (${res.statusCode})");
    }
  }

  // ════════════════════════════════════════════════════════════════════
  //  REMOVE (PUT with body)
  // ════════════════════════════════════════════════════════════════════
  Future<void> removeMySelf(String fullUrl) async {
    final path = _toPath(fullUrl);
    _log.i("[DOC] removeMySelf → URL: ${ApiUrl.removeDocumentSelf}");
    _log.i("[DOC] removeMySelf → body: {deleteMedical_mySelf_image: [$path]}");

    final res = await _apiClient.put(
      url: ApiUrl.removeDocumentSelf,
      isToken: true,
      body: {"deleteMedical_mySelf_image": [path]},
    );

    _log.i("[DOC] removeMySelf result: ${res.statusCode} — ${res.body}");

    if (res.isOk) {
      mySelfImages.remove(fullUrl);
      AppSnackBar.success("Image removed");
    } else {
      _log.e("[DOC] removeMySelf failed: ${res.statusCode} ${res.statusText}");
      AppSnackBar.fail("Failed to remove image (${res.statusCode})");
    }
  }

  Future<void> removeFamily(String fullUrl) async {
    final path = _toPath(fullUrl);
    _log.i("[DOC] removeFamily → URL: ${ApiUrl.removeDocumentFamily}");
    _log.i("[DOC] removeFamily → body: {deleteMedical_family_image: [$path]}");

    final res = await _apiClient.put(
      url: ApiUrl.removeDocumentFamily,
      isToken: true,
      body: {"deleteMedical_family_image": [path]},
    );

    _log.i("[DOC] removeFamily result: ${res.statusCode} — ${res.body}");

    if (res.isOk) {
      familyImages.remove(fullUrl);
      AppSnackBar.success("Image removed");
    } else {
      _log.e("[DOC] removeFamily failed: ${res.statusCode} ${res.statusText}");
      AppSnackBar.fail("Failed to remove image (${res.statusCode})");
    }
  }
}