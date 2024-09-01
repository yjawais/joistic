import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:joistic/models/company_model.dart';

class CompanyController extends GetxController {
  var companyList = <Company>[].obs;
  var searchQuery = ''.obs;
  var appliedJobs = <int>{}.obs;
  var showSearchBar = false.obs;

  void toggleSearchBar() {
    showSearchBar.value = !showSearchBar.value;
  }

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }

  void fetchCompanies() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      companyList.value = data.map((e) => Company.fromJson(e)).toList();
    }
  }

  void applyJob(int companyId) {
    appliedJobs.add(companyId);
    update();
  }

  List<Company> get filteredCompanyList {
    return companyList
        .where((company) => company.name
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void showSuccessSnackbar() {
    Get.snackbar(
      'Success',
      'Job Applied Successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
