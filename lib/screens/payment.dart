// import 'package:flutter/material.dart';
// import 'package:upi_india/upi_india.dart';

// class PaymentPage extends StatefulWidget {
//   final double totalPrice;

//   const PaymentPage({Key? key, required this.totalPrice}) : super(key: key);

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   UpiIndia _upiIndia = UpiIndia();
//   Future<UpiResponse>? _transaction;

//   String _upiId = '2002shalin@okhdfcbank';
//   String _name = 'Nidhi Ravat';
//   String _transactionNote = 'Payment for your order';

//   List<UpiApp>? _upiApps;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUpiApps();
//   }

//   void _fetchUpiApps() async {
//     _upiApps = await _upiIndia.getAllUpiApps(mandatoryTransactionId: false);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Make a Payment'),
//         backgroundColor: Colors.green, // Adjust to your app's theme color
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Pay to $_name',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green, // Adjust to your app's theme color
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'UPI ID: $_upiId',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Total Amount: ₹${widget.totalPrice.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 30),
//             _upiApps != null && _upiApps!.isNotEmpty
//                 ? GridView.builder(
//                     shrinkWrap: true,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 8.0,
//                       crossAxisSpacing: 8.0,
//                     ),
//                     itemCount: _upiApps!.length,
//                     itemBuilder: (context, index) {
//                       UpiApp app = _upiApps![index];
//                       return ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               Colors.green, // Adjust to your app's theme color
//                           foregroundColor: Colors.white,
//                         ),
//                         onPressed: () {
//                           _transaction = _initiateTransaction(app);
//                           setState(() {});
//                         },
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Image.memory(
//                               app.icon,
//                               height: 50,
//                               width: 50,
//                             ),
//                             SizedBox(height: 5),
//                             Text(app.name),
//                           ],
//                         ),
//                       );
//                     },
//                   )
//                 : Center(child: CircularProgressIndicator()),
//             SizedBox(height: 20),
//             if (_transaction != null)
//               FutureBuilder<UpiResponse>(
//                 future: _transaction,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('An error occurred: ${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     return _buildTransactionStatus(snapshot.data!);
//                   } else {
//                     return Text('Something went wrong');
//                   }
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<UpiResponse> _initiateTransaction(UpiApp app) async {
//     return _upiIndia.startTransaction(
//       app: app,
//       receiverUpiId: _upiId,
//       receiverName: _name,
//       transactionRefId: 'TxnId${DateTime.now().millisecondsSinceEpoch}',
//       transactionNote: _transactionNote,
//       amount: widget.totalPrice,
//     );
//   }

//   Widget _buildTransactionStatus(UpiResponse response) {
//     String status = response.status ?? 'Unknown';
//     switch (status) {
//       case UpiPaymentStatus.SUCCESS:
//         return Text(
//           'Transaction Successful!',
//           style: TextStyle(
//             color: Colors.green,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         );
//       case UpiPaymentStatus.FAILURE:
//         return Text(
//           'Transaction Failed. Please try again.',
//           style: TextStyle(
//             color: Colors.red,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         );
//       case UpiPaymentStatus.SUBMITTED:
//         return Text(
//           'Transaction Pending. Please check your bank statement later.',
//           style: TextStyle(
//             color: Colors.orange,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         );
//       default:
//         return Text(
//           'Transaction Status: $status',
//           style: TextStyle(fontSize: 16),
//         );
//     }
//   }
// }
