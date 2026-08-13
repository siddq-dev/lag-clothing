import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../repositories/order_repository.dart';

class OrderProvider extends ChangeNotifier {
  // ============================================================
  // ORDERS
  // ============================================================

  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  // ============================================================
  // SELECTED ORDER
  // ============================================================

  OrderModel? _selectedOrder;

  OrderModel? get selectedOrder => _selectedOrder;

  // ============================================================
  // LOADING
  // ============================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // ============================================================
  // ERROR
  // ============================================================

  String? _error;

  String? get error => _error;

  // ============================================================
  // CUSTOMER - GET ORDERS
  // ============================================================

  Future<void> fetchOrders() async {
    try {
      _setLoading(true);

      _error = null;

      final orders = await OrderRepository.getOrders();

      _orders = orders;
    } catch (e) {
      _error = _cleanError(e);
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // ADMIN - GET ALL ORDERS
  // ============================================================

  Future<void> fetchAllOrders() async {
    try {
      _setLoading(true);

      _error = null;

      final orders = await OrderRepository.getAllOrders();

      _orders = orders;
    } catch (e) {
      _error = _cleanError(e);
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // CUSTOMER - REAL-TIME ORDERS
  // ============================================================

  void listenOrders() {
    OrderRepository.streamOrders().listen(
      (data) {
        _orders = data;
        _error = null;

        notifyListeners();
      },
      onError: (error) {
        _error = _cleanError(error);

        notifyListeners();
      },
    );
  }

  // ============================================================
  // ADMIN - REAL-TIME ORDERS
  // ============================================================

  void listenAllOrders() {
    OrderRepository.streamAllOrders().listen(
      (data) {
        _orders = data;
        _error = null;

        notifyListeners();
      },
      onError: (error) {
        _error = _cleanError(error);

        notifyListeners();
      },
    );
  }

  // ============================================================
  // CREATE ORDER
  // ============================================================

  Future<void> createOrder(OrderModel order) async {
    try {
      _setLoading(true);

      _error = null;

      await OrderRepository.createOrder(order);
    } catch (e) {
      _error = _cleanError(e);
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // GET SINGLE ORDER
  // ============================================================

  Future<void> fetchOrder(String orderId) async {
    try {
      _setLoading(true);

      _error = null;

      _selectedOrder = await OrderRepository.getOrder(orderId);
    } catch (e) {
      _error = _cleanError(e);
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // UPDATE ORDER STATUS
  // ============================================================

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      _setLoading(true);

      _error = null;

      await OrderRepository.updateOrderStatus(orderId, status);

      // --------------------------------------------------------
      // Refresh the current list.
      //
      // This is useful for admin and customer views when the
      // provider is not currently listening to a stream.
      // --------------------------------------------------------

      await fetchOrders();
    } catch (e) {
      _error = _cleanError(e);

      notifyListeners();

      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // UPDATE PAYMENT STATUS
  // ============================================================

  Future<void> updatePaymentStatus(String orderId, PaymentStatus status) async {
    try {
      _setLoading(true);

      _error = null;

      await OrderRepository.updatePaymentStatus(orderId, status);

      await fetchAllOrders();
    } catch (e) {
      _error = _cleanError(e);

      notifyListeners();

      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // CANCEL ORDER
  // ============================================================

  Future<void> cancelOrder(String orderId) async {
    try {
      _setLoading(true);

      _error = null;

      await OrderRepository.cancelOrder(orderId);

      await fetchOrders();
    } catch (e) {
      _error = _cleanError(e);

      notifyListeners();

      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // RETURN ORDER
  // ============================================================

  Future<void> returnOrder(String orderId) async {
    try {
      _setLoading(true);

      _error = null;

      await OrderRepository.returnOrder(orderId);

      await fetchOrders();
    } catch (e) {
      _error = _cleanError(e);

      notifyListeners();

      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // DELETE ORDER
  // ============================================================

  Future<void> deleteOrder(String orderId) async {
    try {
      _setLoading(true);

      _error = null;

      await OrderRepository.deleteOrder(orderId);

      _orders.removeWhere((order) => order.id == orderId);

      if (_selectedOrder?.id == orderId) {
        _selectedOrder = null;
      }

      notifyListeners();
    } catch (e) {
      _error = _cleanError(e);

      notifyListeners();

      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // UPDATE ADMIN NOTES
  // ============================================================

  Future<void> updateAdminNotes(String orderId, String notes) async {
    try {
      _setLoading(true);

      _error = null;

      await OrderRepository.updateAdminNotes(orderId, notes);

      await fetchAllOrders();
    } catch (e) {
      _error = _cleanError(e);

      notifyListeners();

      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================
  // CLEAR PROVIDER
  // ============================================================

  void clear() {
    _orders = [];

    _selectedOrder = null;

    _error = null;

    notifyListeners();
  }

  // ============================================================
  // LOADING HELPER
  // ============================================================

  void _setLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }

  // ============================================================
  // ERROR HELPER
  // ============================================================

  String _cleanError(Object error) {
    final message = error.toString();

    if (message.startsWith('Exception: ')) {
      return message.substring('Exception: '.length);
    }

    return message;
  }
}
