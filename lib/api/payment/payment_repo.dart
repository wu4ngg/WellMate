import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/model/totalmoney_admin.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class PaymentRepo {
  API api = API();

  Future<int?> payment(
      id_address, id_user, total_price, listDrugCart, token, id_paypal) async {
    for (var element in listDrugCart) {
      log(element["id_app_detail"].toString());
    }
    Map<String, dynamic> body = {
      'id_address': id_address,
      'id_user': id_user,
      'total_price': total_price,
      'listDrugCart': listDrugCart,
      'id_paypal': id_paypal,
    };
    log(body.toString());
    Response res = await api.sendRequest.post('/payment/addPayment',
        options: Options(headers: header(token)), data: body);
    log(res.data["metadata"][["id_invoice"]].toString());
    return res.statusCode == 200 ? res.data["metadata"]["id_invoice"] : -1;
  }

  Future<List<HistoryStransactionModel>> getAllInvoices(
      {DateTime? date}) async {
    try {
      String token = await SecureStorage.getToken();
      int idUser = await SecureStorage.getUserId();

      final String baseUrl = '/payment/getAllInvoice/$idUser';
      final String url = date != null
          ? '$baseUrl?date=${DateFormat('yyyy-MM-dd').format(date)}'
          : baseUrl;

      Response res = await api.sendRequest.get(
        url,
        options: Options(headers: header(token)),
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = res.data;
        log('Response data: $responseData');

        if (responseData['metadata'] == null) {
          throw Exception('No data found');
        }

        List<dynamic> data = responseData['metadata'];
        List<HistoryStransactionModel> invoices = data
            .map((json) => HistoryStransactionModel.fromJson(json))
            .toList();

        if (date != null) {
          invoices = invoices.where((invoice) {
            DateTime invoiceDate = DateTime.parse(invoice.createDate as String);
            return invoiceDate.year == date.year &&
                invoiceDate.month == date.month &&
                invoiceDate.day == date.day;
          }).toList();
        }

        return invoices;
      } else {
        throw Exception('Failed to load Invoice');
      }
    } catch (ex) {
      print('Error: $ex');
      rethrow;
    }
  }

  Future<List<TotalMoneyModel>> getTotalMoneyAllMonthOfYear(int year) async {
    try {
      final String token = await SecureStorage.getToken();
      final String adminToken =
          "FBZwFdSI9KOxUGkN4IKaOwwUMnTgX4i2dTcWCgo3wxSTXvKs162";

      final Map<String, dynamic> body = {
        'year': year,
      };

      // Gửi request đến endpoint
      final Response res = await api.sendRequest.get(
        '/user/getTotalMoneyAllMonthOfYear',
        options: Options(headers: adminHeader(token, adminToken)),
        data: body,
      );

      log('Response Data: ${res.data}');

      if (res.statusCode == 200) {
        final List<dynamic>? metadata = res.data['metadata'];
        if (metadata == null) {
          throw Exception('No data found');
        }

        final List<TotalMoneyModel> result = metadata.map((item) {
          if (item is Map<String, dynamic>) {
            return TotalMoneyModel.fromJson(item);
          } else {
            throw Exception('Data format is incorrect for item: $item');
          }
        }).toList();

        return result;
      } else {
        throw Exception(
            'Failed to load total money. Status code: ${res.statusCode}');
      }
    } catch (e) {
      log('Error fetching total money: $e');
      rethrow;
    }
  }
}
