import 'package:nivaas/data/models/managementMembers/security/list_security_model.dart';

abstract class ListManagementMembersRepository {
  Future<ListSecurityModel> fetchSecuritiesList(int apartmentID);
}