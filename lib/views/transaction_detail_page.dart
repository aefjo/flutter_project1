import 'package:coba_test/controllers/report_pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_detail_controller.dart';

class TransactionDetailPage extends StatelessWidget {
  final TransactionDetailController transactionDetailController = Get.put(TransactionDetailController());
  final ReportPdfController reportPdfController = Get.put(ReportPdfController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction Detail')),
      body: Obx(() {
        if (transactionDetailController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // ignore: invalid_use_of_protected_member
        var transaction = transactionDetailController.transactionDetail.value;
        print(transaction);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer Name: ${transaction['name'] ?? 'N/A'}'),
              Text('Unit Location: ${transaction['address'] ?? 'N/A'}'),
              Text('Unit Model: ${transaction['model'] ?? 'N/A'}'),
              Text('Serial Number: ${transaction['unit']['serialno'] ?? 'N/A'}'),
              Text('Unit Number: ${transaction['unit_no'] ?? 'N/A'}'),
              Text('Component: ${transaction['component'] ?? 'N/A'}'),
              Text('Component Matrix: ${transaction['oil_matrix'] ?? 'N/A'}'),
              Text('Recommendation 1: ${transaction['recomm1'] ?? 'N/A'}'),
              Text('Recommendation 2: ${transaction['recomm2'] ?? 'N/A'}'),
              ElevatedButton(onPressed: () {
                reportPdfController.exportPdf(transaction['token']);
              }, child: Text('Export pdf'))
            ],
          ),
        );
      }),
    );
  }
}
