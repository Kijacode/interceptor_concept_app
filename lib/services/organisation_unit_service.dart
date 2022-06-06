import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:interceptor_concept_app/models/organisation_unit_model.dart';
import 'package:interceptor_concept_app/services/http_service.dart';

class OrganisationUnitService {
  final int pageSize = 20;

  Future<List<Dhis2OrganisationUnit>> discoveringOrganisationUnit(
  ) async {
    List<Dhis2OrganisationUnit> organisationUnits = [];
    try {
      HttpService http = HttpService();
      var url = 'api/organisationUnits.json';
      var pageResponse = await http.httpGetPagination(url, {});
      List<Map<String, String>> pagefilters = getPaginationFilters(
        response: pageResponse,
        pageSize: pageSize,
      );
      for (Map<String, String> pagefilter in pagefilters) {
        var queryParameters = {
          'fields':
              'id,name',
        };
        queryParameters.addAll(pagefilter);
        var response = await http.httpGet(
          url,
          queryParameters: queryParameters,
        );
        if (response.statusCode == 200) {
          Map body = json.decode(response.data);
          for (dynamic json in body['organisationUnits'] ?? []) {
            print(Dhis2OrganisationUnit.fromJson(json));
            organisationUnits.add(Dhis2OrganisationUnit.fromJson(json));
          }
        }
      }
    } catch (e) {
      //
    }
    return organisationUnits;
  }

   static List<Map<String, String>> getPaginationFilters({
    required Response response,
    int pageSize = 50,
  }) {
    List<Map<String, String>> pageFilters = [];
    if (response.statusCode == 200) {
      Map body = json.decode(response.data);
      Map pager = body['pager'] ?? {};
      int total = pager['total'] ?? pageSize;
      for (int page = 1; page <= (total / pageSize).ceil(); page++) {
        pageFilters.add({'page': '$page', 'pageSize': '$pageSize'});
      }
    }
    return pageFilters;
  }

}