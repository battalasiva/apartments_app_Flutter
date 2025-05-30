import 'package:nivaas/data/models/managementMembers/security/list_security_model.dart';
import 'package:nivaas/data/provider/network/api/managementMembers/list_management_members_datasource.dart';
import 'package:nivaas/domain/repositories/managementMembers/list_management_members_repository.dart';

class ListManagementMembersRepositoryimpl implements ListManagementMembersRepository{
  final ListManagementMembersDatasource datasource;

  ListManagementMembersRepositoryimpl({required this.datasource});
  @override
  Future<ListSecurityModel> fetchSecuritiesList(int apartmentID) {
    return datasource.fetchSecuritiesList(apartmentID);
  }
  
}