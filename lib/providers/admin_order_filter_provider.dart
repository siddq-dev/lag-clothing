import 'package:flutter/material.dart';

import '../models/order_model.dart';

class AdminOrderFilterProvider extends ChangeNotifier {
  // ==========================================
  // Search
  // ==========================================

  String _search = "";

  String get search => _search;

  void updateSearch(String value) {
    _search = value;
    notifyListeners();
  }

  void clearSearch() {
    _search = "";
    notifyListeners();
  }

  // ==========================================
  // Order Status
  // ==========================================

  OrderStatus? _status;

  OrderStatus? get status => _status;

  void updateStatus(OrderStatus? value) {
    _status = value;
    notifyListeners();
  }

  // ==========================================
  // Payment Status
  // ==========================================

  PaymentStatus? _paymentStatus;

  PaymentStatus? get paymentStatus => _paymentStatus;

  void updatePaymentStatus(PaymentStatus? value) {
    _paymentStatus = value;
    notifyListeners();
  }

  // ==========================================
  // Payment Method
  // ==========================================

  String? _paymentMethod;

  String? get paymentMethod => _paymentMethod;

  void updatePaymentMethod(String? value) {
    _paymentMethod = value;
    notifyListeners();
  }

  // ==========================================
  // Sorting
  // ==========================================

  String _sortBy = "Newest";

  String get sortBy => _sortBy;

  void updateSort(String value) {
    _sortBy = value;
    notifyListeners();
  }

  // ==========================================
  // Clear All Filters
  // ==========================================

  void clearAll() {
    _search = "";
    _status = null;
    _paymentStatus = null;
    _paymentMethod = null;
    _sortBy = "Newest";

    notifyListeners();
  }

  // ==========================================
  // Apply Filters
  // ==========================================

  List<OrderModel> apply(List<OrderModel> orders) {
    List<OrderModel> list = List.from(orders);

    //--------------------------------------------------
    // Search
    //--------------------------------------------------

    if (_search.isNotEmpty) {
      final query = _search.toLowerCase();

      list = list.where((order) {
        return order.orderNumber.toLowerCase().contains(query) ||
            order.shippingAddress.fullName.toLowerCase().contains(query) ||
            order.trackingId.toLowerCase().contains(query);
      }).toList();
    }

    //--------------------------------------------------
    // Order Status
    //--------------------------------------------------

    if (_status != null) {
      list = list.where((order) => order.orderStatus == _status).toList();
    }

    //--------------------------------------------------
    // Payment Status
    //--------------------------------------------------

    if (_paymentStatus != null) {
      list = list
          .where((order) => order.paymentStatus == _paymentStatus)
          .toList();
    }

    //--------------------------------------------------
    // Payment Method
    //--------------------------------------------------

    if (_paymentMethod != null && _paymentMethod!.isNotEmpty) {
      list = list
          .where((order) => order.paymentMethod == _paymentMethod)
          .toList();
    }

    //--------------------------------------------------
    // Sorting
    //--------------------------------------------------

    switch (_sortBy) {
      case "Newest":
        list.sort((a, b) {
          final aTime =
              a.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

          final bTime =
              b.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

          return bTime.compareTo(aTime);
        });
        break;

      case "Oldest":
        list.sort((a, b) {
          final aTime =
              a.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

          final bTime =
              b.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

          return aTime.compareTo(bTime);
        });
        break;

      case "Highest Amount":
        list.sort((a, b) => b.total.compareTo(a.total));
        break;

      case "Lowest Amount":
        list.sort((a, b) => a.total.compareTo(b.total));
        break;

      case "Pending First":
        list.sort((a, b) {
          if (a.orderStatus == OrderStatus.placed &&
              b.orderStatus != OrderStatus.placed) {
            return -1;
          }

          if (b.orderStatus == OrderStatus.placed &&
              a.orderStatus != OrderStatus.placed) {
            return 1;
          }

          return 0;
        });
        break;

      case "Delivered First":
        list.sort((a, b) {
          if (a.orderStatus == OrderStatus.delivered &&
              b.orderStatus != OrderStatus.delivered) {
            return -1;
          }

          if (b.orderStatus == OrderStatus.delivered &&
              a.orderStatus != OrderStatus.delivered) {
            return 1;
          }

          return 0;
        });
        break;
    }

    return list;
  }
}
