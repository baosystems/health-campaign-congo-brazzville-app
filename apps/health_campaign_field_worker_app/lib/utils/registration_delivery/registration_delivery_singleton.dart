import 'package:digit_data_model/data_model.dart'
    show ProjectModel, ProjectTypeModel, BoundaryModel;
import 'package:digit_data_model/models/entities/beneficiary_type.dart'
    show BeneficiaryType;

class RegistrationDeliverySingleton {
  RegistrationDeliverySingleton._();
  static final RegistrationDeliverySingleton _i =
      RegistrationDeliverySingleton._();
  factory RegistrationDeliverySingleton() => _i;

  // already have
  List<String> userRoles = const [];
  Set<String> _allowedUnableRoles = {'TEAM_SUPERVISOR'};

  String? tenantId;
  String? projectId;
  String? loggedInUserUuid;

  /// NEW: full project & type snapshot (optional)
  ProjectModel? selectedProject;
  ProjectTypeModel? projectType;

  BeneficiaryType? beneficiaryType;
  BoundaryModel? boundary;

  // roles (unchanged)
  void hydrateRoles(List<String> roles) {
    userRoles = roles.map((e) => e.trim().toUpperCase()).toList();
  }

  void setAllowedUnableRoles(Set<String> roles) {
    _allowedUnableRoles = roles.map((e) => e.trim().toUpperCase()).toSet();
  }

  bool get canSeeUnableToDeliver =>
      userRoles.toSet().intersection(_allowedUnableRoles).isNotEmpty;

  // auth priming (unchanged)
  void primeFromAuth({
    required String tenantId,
    required String loggedInUserUuid,
    String? projectId,
  }) {
    this.tenantId = tenantId;
    this.loggedInUserUuid = loggedInUserUuid;
    this.projectId = projectId ?? this.projectId;
  }

  /// NEW: one place to set project snapshot after any fetch
  void setSelectedProject(ProjectModel p) {
    selectedProject = p;
    projectId = p.id ?? projectId;
    projectType = p.additionalDetails?.additionalProjectType ?? projectType;
  }

  String get projectKey => selectedProject?.projectType ?? 'SMC';

  bool get hasProject => projectId != null;
  bool get isFullyInitialized =>
      projectId != null && beneficiaryType != null && loggedInUserUuid != null;
  void reset() {
    userRoles = const [];
    tenantId = null;
    projectId = null;
    loggedInUserUuid = null;
    selectedProject = null;
    projectType = null;
    beneficiaryType = null;
    boundary = null;
  }
}
