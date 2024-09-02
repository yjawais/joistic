import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic/controllers/company_controller.dart';
import 'package:joistic/controllers/login_controller.dart';
import 'package:joistic/models/company_model.dart';
import 'package:joistic/widgets/company_bottom_sheet.dart';
import 'package:joistic/widgets/company_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CompanyController companyController = Get.put(CompanyController());
    final LoginController loginController = Get.put(LoginController());

  void _showCompanyDetails(BuildContext context, Company company) {
    Get.bottomSheet(
      CompanyBottomSheet(
        company: company,
        isApplied: companyController.appliedJobs.contains(company.id),
        onApplyTap: () {
          companyController.applyJob(company.id);

          companyController.showSuccessSnackbar();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTitle(),
          _buildCompanyList(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu_rounded, color: Colors.grey[900]),
      ),
      actions: [
        Obx(() => _buildSearchButton()),
        _buildlogoutButton(),
      ],
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: companyController.showSearchBar.value
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.transparent,
              blurRadius: 10,
            ),
          ],
        ),
        child: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: companyController.showSearchBar.value
                ? Colors.blue[600]
                : Colors.transparent,
          ),
          onPressed: () => companyController.toggleSearchBar(),
          icon: Icon(
            Icons.search_rounded,
            color: companyController.showSearchBar.value
                ? Colors.white
                : Colors.grey[900],
          ),
        ),
      ),
    );
  }

  Widget _buildlogoutButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: IconButton(
        onPressed: () => loginController.logout(),
        icon: Icon(
          Icons.logout_rounded,
          color: Colors.grey[900],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Obx(() => companyController.showSearchBar.value
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[900]),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) => companyController.searchQuery.value = value,
            ),
          )
        : const SizedBox());
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Text(
        "Find Your Dream Job Today",
        style: TextStyle(
          color: Colors.grey[900],
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCompanyList() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          physics: const BouncingScrollPhysics(),
          itemCount: companyController.filteredCompanyList.length,
          itemBuilder: (context, index) {
            final company = companyController.filteredCompanyList[index];
            return Obx(() {
              final isApplied =
                  companyController.appliedJobs.contains(company.id);
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 26,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CompanyTileWidget(
                  company: company,
                  isApplied: isApplied,
                  onTileTap: () => _showCompanyDetails(context, company),
                ),
              );
            });
          },
        );
      }),
    );
  }
}
