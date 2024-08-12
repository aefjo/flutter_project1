import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_list_controller.dart';

class TransactionListPage extends StatelessWidget {
  final TransactionListController transactionListController = Get.put(TransactionListController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction List'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search transactions...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    String labNo = searchController.text.trim();
                    transactionListController.searchTransactions(labNo);
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (transactionListController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (transactionListController.transactions.isEmpty) {
          return Center(child: Text('No transactions found.'));
        }

        return ListView.builder(
          itemCount: transactionListController.transactions.length,
          itemBuilder: (context, index) {
            var transaction = transactionListController.transactions[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  String labNo = transaction['Lab_No'];
                  Get.toNamed('/transaction-detail', arguments: labNo);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${transaction['name'] ?? 'N/A'}'),
                      Text('Unit No: ${transaction['UNIT_NO'] ?? 'N/A'} - Model: ${transaction['MODEL'] ?? 'N/A'}'),
                      Text('Component: ${transaction['COMPONENT'] ?? 'N/A'}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Sample date: ${transaction['SAMPL_DT1'] ?? 'N/A'}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Report date: ${transaction['RPT_DT1'] ?? 'N/A'}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.blue),
                onPressed: () {
                  Get.toNamed('/dashboard');
                },
              ),
              IconButton(
                icon: Icon(Icons.explore, color: Colors.blue),
                onPressed: () {
                  Get.toNamed('/transaction-list');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
