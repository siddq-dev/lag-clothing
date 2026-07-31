import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../repositories/order_repository.dart';


class OrderProvider extends ChangeNotifier {


  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;



  OrderModel? _selectedOrder;

  OrderModel? get selectedOrder =>
      _selectedOrder;



  bool _isLoading = false;

  bool get isLoading =>
      _isLoading;



  String? _error;

  String? get error =>
      _error;



  // ==========================================
  // Get User Orders
  // ==========================================

  Future<void> fetchOrders() async {

    try {

      _setLoading(true);


      _orders =
          await OrderRepository.getOrders();


      _error = null;


    } catch (e) {


      _error = e.toString();


    } finally {


      _setLoading(false);


    }

  }



  // ==========================================
// Admin - Get All Orders
// ==========================================

Future<void> fetchAllOrders() async {
  try {
    _setLoading(true);

    _orders = await OrderRepository.getAllOrders();

    _error = null;
  } catch (e) {
    _error = e.toString();
  } finally {
    _setLoading(false);
  }
}



  // ==========================================
  // Listen Orders Real Time
  // ==========================================

  void listenOrders() {


    OrderRepository
        .streamOrders()
        .listen(

      (data) {


        _orders = data;


        notifyListeners();


      },

      onError: (error) {


        _error = error.toString();


        notifyListeners();


      },

    );


  }



  // ==========================================
// Admin Listen Orders
// ==========================================

void listenAllOrders() {
  OrderRepository.streamAllOrders().listen(
    (data) {
      _orders = data;
      notifyListeners();
    },
    onError: (error) {
      _error = error.toString();
      notifyListeners();
    },
  );
}



  // ==========================================
  // Create Order
  // ==========================================

  Future<void> createOrder(
    OrderModel order,
  ) async {


    try {


      _setLoading(true);


      await OrderRepository
          .createOrder(order);


      _error = null;


    } catch(e){


      _error = e.toString();


    } finally {


      _setLoading(false);


    }


  }



  // ==========================================
  // Get Single Order
  // ==========================================

  Future<void> fetchOrder(
    String orderId,
  ) async {


    try {


      _setLoading(true);



      _selectedOrder =
          await OrderRepository.getOrder(
            orderId,
          );


      _error = null;


    }catch(e){


      _error = e.toString();


    }finally{


      _setLoading(false);


    }


  }



  // ==========================================
  // Update Order Status
  // ==========================================

  Future<void> updateOrderStatus(
    String orderId,
    OrderStatus status,
  ) async {


    try {


      await OrderRepository
          .updateOrderStatus(
            orderId,
            status,
          );



      await fetchOrders();



    }catch(e){


      _error = e.toString();


      notifyListeners();


    }


  }



  // ==========================================
// Update Payment Status
// ==========================================

Future<void> updatePaymentStatus(
  String orderId,
  PaymentStatus status,
) async {
  try {
    await OrderRepository.updatePaymentStatus(
      orderId,
      status,
    );

    await fetchAllOrders();

  } catch (e) {
    _error = e.toString();
    notifyListeners();
  }
}



  // ==========================================
  // Cancel Order
  // ==========================================

  Future<void> cancelOrder(
    String orderId,
  ) async {


    try {


      await OrderRepository
          .cancelOrder(
            orderId,
          );


      await fetchOrders();



    }catch(e){


      _error = e.toString();


      notifyListeners();


    }


  }



  // ==========================================
  // Return Order
  // ==========================================

  Future<void> returnOrder(
    String orderId,
  ) async {


    try {


      await OrderRepository
          .returnOrder(
            orderId,
          );


      await fetchOrders();



    }catch(e){


      _error = e.toString();


      notifyListeners();


    }


  }



  // ==========================================
  // Delete Order
  // ==========================================

  Future<void> deleteOrder(
    String orderId,
  ) async {


    try {


      await OrderRepository
          .deleteOrder(
            orderId,
          );


      _orders.removeWhere(
        (order) =>
            order.id == orderId,
      );


      notifyListeners();



    }catch(e){


      _error = e.toString();


      notifyListeners();


    }


  }



Future<void> updateAdminNotes(
  String orderId,
  String notes,
) async {
  try {
    _setLoading(true);

    await OrderRepository.updateAdminNotes(
      orderId,
      notes,
    );

    await fetchAllOrders();

    _error = null;
  } catch (e) {
    _error = e.toString();
  } finally {
    _setLoading(false);
  }
}


  // ==========================================
  // Clear Provider
  // ==========================================

  void clear(){

    _orders = [];

    _selectedOrder = null;

    _error = null;


    notifyListeners();

  }



  // ==========================================
  // Loading Helper
  // ==========================================

  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }


}