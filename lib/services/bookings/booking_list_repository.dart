import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/models/booking_list_item.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_query_params.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BookingListRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  Future<BookingListPageResult> getAllBookingsV2({
    required int page,
    required BookingListQueryParams params,
  }) async {
    final uri = Uri.parse('$baseUrl/v1/bookings/getAllBookingV2').replace(
      queryParameters: <String, String>{
        'page': '$page',
        'viewBookingPermisision': params.viewBookingPermission,
        'companyId': params.companyId,
        'userRole': params.userRole,
        'userName': params.userName,
      },
    );

    log('getAllBookingsV2 → sending GET $uri');
    final response = await http.get(uri);

    log(
      'getAllBookingsV2 ← status=${response.statusCode} len=${response.body.length}',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load bookings (${response.statusCode})');
    }

    final dynamic decoded = json.decode(response.body);

    if (decoded is Map) {
      final root = Map<String, dynamic>.from(decoded);
      final parsed = _parseAllBookingDetailsResponse(root);
      if (parsed.items.isNotEmpty) {
        return parsed;
      }
    }

    return _parseLegacyFallback(decoded);
  }

  /// Resolves `allBookingDetails` from root or nested `data` / `result` (API wrappers).
  static List<dynamic>? _allBookingDetailsList(Map<String, dynamic> root) {
    dynamic list = root['allBookingDetails'];
    if (list is List) return list;

    for (final key in const ['data', 'result', 'payload', 'body']) {
      final nested = root[key];
      if (nested is Map) {
        final m = Map<String, dynamic>.from(nested);
        list = m['allBookingDetails'];
        if (list is List) return list;
      }
    }
    return null;
  }

  /// Primary parser for Drivado `allBookingDetails` + `paginatedResults`.
  static BookingListPageResult _parseAllBookingDetailsResponse(
    Map<String, dynamic> root,
  ) {
    final items = <BookingListItem>[];
    int? totalFromApi;

    final allDetails = _allBookingDetailsList(root);
    if (allDetails is List) {
      for (final block in allDetails) {
        if (block is! Map) continue;
        final m = Map<String, dynamic>.from(block);

        dynamic pr = m['paginatedResults'];
        if (pr is String) {
          try {
            pr = json.decode(pr);
          } catch (_) {
            pr = null;
          }
        }
        if (pr is List) {
          for (final e in pr) {
            if (e is Map) {
              try {
                items.add(
                  BookingListItem.fromJson(Map<String, dynamic>.from(e)),
                );
              } catch (err, st) {
                log('getAllBookingsV2 skip row: $err', stackTrace: st);
              }
            }
          }
        }

        final tbc = m['totalBookingCount'];
        if (tbc is List && tbc.isNotEmpty) {
          final first = tbc.first;
          if (first is Map && first['total'] != null) {
            final t = first['total'];
            if (t is int) {
              totalFromApi = t;
            } else if (t is num) {
              totalFromApi = t.toInt();
            }
          }
        }
      }
    }

    final totalCount = totalFromApi ?? items.length;

    return BookingListPageResult(
      items: items,
      totalCount: totalCount,
      rawSuccess: root['success'] as bool? ?? true,
      message: root['message']?.toString(),
    );
  }

  /// Fallback if response is wrapped differently (e.g. `data` list).
  static BookingListPageResult _parseLegacyFallback(dynamic decoded) {
    final items = <BookingListItem>[];
    int? total;

    void addFromList(List<dynamic>? list) {
      if (list == null) return;
      for (final e in list) {
        if (e is Map<String, dynamic>) {
          items.add(BookingListItem.fromJson(e));
        } else if (e is Map) {
          items.add(BookingListItem.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }

    if (decoded is List) {
      addFromList(decoded);
    } else if (decoded is Map) {
      final root = Map<String, dynamic>.from(decoded);
      total = root['totalCount'] as int? ?? (root['total'] as num?)?.toInt();
      final data = root['data'];
      if (data is List) {
        addFromList(data);
      } else if (data is Map) {
        final dm = Map<String, dynamic>.from(data);
        final inner = dm['bookings'] ?? dm['list'];
        if (inner is List) addFromList(inner);
      }
    }

    return BookingListPageResult(
      items: items,
      totalCount: total ?? items.length,
      rawSuccess: decoded is Map ? (decoded['success'] as bool? ?? true) : true,
      message: decoded is Map ? decoded['message']?.toString() : null,
    );
  }
}

class BookingListPageResult {
  final List<BookingListItem> items;
  final int totalCount;
  final bool rawSuccess;
  final String? message;

  const BookingListPageResult({
    required this.items,
    required this.totalCount,
    required this.rawSuccess,
    this.message,
  });
}
