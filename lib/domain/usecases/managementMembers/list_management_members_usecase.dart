import 'package:nivaas/data/models/managementMembers/security/list_security_model.dart';
import 'package:nivaas/data/repository-impl/managementMembers/list_management_members_repositoryimpl.dart';

class ListManagementMembersUsecase {
  final ListManagementMembersRepositoryimpl repository;

  ListManagementMembersUsecase({required this.repository});

  Future<ListSecurityModel> callSecuritiesList(int apartmentID){
    return repository.fetchSecuritiesList(apartmentID);
  }
}