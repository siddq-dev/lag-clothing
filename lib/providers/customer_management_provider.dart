import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import '../models/customer_admin_model.dart';
import '../repositories/customer_management_repository.dart';

class CustomerManagementProvider extends ChangeNotifier {
  //----------------------------------------------------------
  // Customer List
  //----------------------------------------------------------

  List<CustomerAdminModel> _customers = [];

  List<CustomerAdminModel> get customers => _customers;

  //----------------------------------------------------------
  // Selected Customer
  //----------------------------------------------------------

  CustomerAdminModel? _selectedCustomer;

  CustomerAdminModel? get selectedCustomer =>
      _selectedCustomer;

  //----------------------------------------------------------
  // Orders
  //----------------------------------------------------------

  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  //----------------------------------------------------------
  // Current Order
  //----------------------------------------------------------

  OrderModel? _currentOrder;

  OrderModel? get currentOrder =>
      _currentOrder;

  //----------------------------------------------------------
  // Loading
  //----------------------------------------------------------

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //----------------------------------------------------------
  // Error
  //----------------------------------------------------------

  String? _error;

  String? get error => _error;

  //----------------------------------------------------------
  // Listen Customers
  //----------------------------------------------------------

  void listenCustomers() {
    _isLoading = true;

    notifyListeners();

    CustomerManagementRepository
        .streamCustomers()
        .listen(
      (customers) {
        _customers = customers;

        _isLoading = false;

        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();

        _isLoading = false;

        notifyListeners();
      },
    );
  }

  //----------------------------------------------------------
  // Load Customer Details
  //----------------------------------------------------------

  Future<void> loadCustomer(
    CustomerAdminModel customer,
  ) async {
    _selectedCustomer = customer;

    _isLoading = true;

    notifyListeners();

    try {
      _orders =
          await CustomerManagementRepository
              .getCustomerOrders(
        customer.uid,
      );

      _currentOrder =
          await CustomerManagementRepository
              .getCurrentOrder(
        customer.uid,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }

  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  Future<void> refreshCustomer() async {
    if (_selectedCustomer == null) return;

    await loadCustomer(_selectedCustomer!);
  }

  //----------------------------------------------------------
  // Search Customers
  //----------------------------------------------------------

  List<CustomerAdminModel> searchCustomers(
    String keyword,
  ) {
    if (keyword.isEmpty) {
      return _customers;
    }

    final lower = keyword.toLowerCase();

    return _customers.where((customer) {
      return customer.fullName
              .toLowerCase()
              .contains(lower) ||
          customer.email
              .toLowerCase()
              .contains(lower) ||
          customer.phone.contains(lower);
    }).toList();


    
  }
//----------------------------------------------------------
// Statistics
//----------------------------------------------------------

double get totalSpend =>
    _selectedCustomer?.totalSpent ?? 0;

double get averageOrderValue {
  if (_orders.isEmpty) return 0;

  return totalSpend / _orders.length;
}

DateTime? get lastOrder {
  if (_orders.isEmpty) return null;

  return _orders.first.createdAt?.toDate();
}

}