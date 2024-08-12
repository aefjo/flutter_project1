import 'package:coba_test/controllers/auth_controller.dart';
import 'package:coba_test/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    // dashboardController.fetchDashboardData(authController.username.value);
    dashboardController.fetchDashboardData('RMLTRK');

    return Scaffold(
      appBar: AppBar(title: Obx(() => Text('Welcome ${authController.username.value}'))),
      body: Center(
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Normal : ${dashboardController.totalNormal.value}"),
              Text("Caution : ${dashboardController.totalCaution.value}"),
              Text("Critical : ${dashboardController.totalCritical.value}"),
              Text("Severe : ${dashboardController.totalSevere.value}"),
            ],
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.blue),
                onPressed: () {
                  Get.toNamed('/dashboard'); // Sesuaikan dengan routing aplikasi Anda
                },
              ),
              IconButton(
                icon: Icon(Icons.explore, color: Colors.blue),
                onPressed: () {
                  Get.toNamed('/transaction-list'); // Sesuaikan dengan routing aplikasi Anda
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
