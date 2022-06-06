import 'dart:convert';

import 'package:interceptor_concept_app/models/organisation_unit_model.dart';
import 'package:interceptor_concept_app/services/http_service.dart';

class OrganisationUnitService {
  final int pageSize = 20;

  Future<List<Dhis2OrganisationUnit>> discoveringOrganisationUnit(
  ) async {
    List<Dhis2OrganisationUnit> organisationUnits = [];
    try {
      HttpService http = HttpService();
      var url = '/api/organisationUnits.json';
       var queryParameters = {
          'fields':
              'id,name',
        };
        var response = await http.httpGet(
          url,
          queryParameters: queryParameters,
        );
       
        if (response.statusCode == 200) {
          for (dynamic json in response.data['organisationUnits'] ?? []) {
            organisationUnits.add(Dhis2OrganisationUnit.fromJson(json));
          }
        }
    } catch (e) {
      //
    }
    return organisationUnits;
  }



}