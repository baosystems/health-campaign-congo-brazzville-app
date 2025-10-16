import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/auth/auth_model.dart';
import '../../../models/role_actions/role_actions_model.dart';
import '../../../utils/constants.dart';

class LocalSecureStore {
  static const accessTokenKey = 'accessTokenKey';
  static const refreshTokenKey = 'refreshTokenKey';
  static const userObjectKey = 'userObject';
  static const selectedProjectKey = 'selectedProject';
  static const selectedIndividualKey = 'selectedIndividual';
  static const hasAppRunBeforeKey = 'hasAppRunBefore';
  static const backgroundServiceKey = 'backgroundServiceKey';
  static const boundaryRefetchInKey = 'boundaryRefetchInKey';
  static const actionsListkey = 'actionsListkey';
  static const isAppInActiveKey = 'isAppInActiveKey';
  static const manualSyncKey = 'manualSyncKey';
  static const selectedProjectTypeKey = 'selectedProjectType';

  final storage = const FlutterSecureStorage();

  static LocalSecureStore get instance => _instance;
  static final LocalSecureStore _instance = LocalSecureStore._();

  LocalSecureStore._();

  Future<String?> get accessToken {
    return storage.read(key: accessTokenKey);
  }

  Future<String?> get refreshToken {
    return storage.read(key: refreshTokenKey);
  }

  Future<bool> get isBackgroundSerivceRunning async {
    final hasRun = await storage.read(key: backgroundServiceKey);

    switch (hasRun) {
      case 'true':
        return true;
      default:
        return false;
    }
  }

  Future<UserRequestModel?> get userRequestModel async {
    final userBody = await storage.read(key: userObjectKey);
    if (userBody == null) return null;

    try {
      final user = UserRequestModel.fromJson(json.decode(userBody));

      return user;
    } catch (_) {
      return null;
    }
  }

  Future<String?> get userIndividualId async {
    final individualId = await storage.read(key: selectedIndividualKey);
    if (individualId == null) return null;

    try {
      final user = individualId;

      return user;
    } catch (_) {
      return null;
    }
  }

  Future<ProjectModel?> get selectedProject async {
    final projectString = await storage.read(key: selectedProjectKey);
    if (projectString == null) return null;

    try {
      final project = ProjectModelMapper.fromMap(json.decode(projectString));

      return project;
    } catch (_) {
      return null;
    }
  }

  Future<ProjectType?> get selectedProjectType async {
    final projectBody = await storage.read(key: selectedProjectTypeKey);
    if (projectBody == null) return null;

    try {
      final projectType = ProjectType.fromJson(json.decode(projectBody));

      return projectType;
    } catch (_) {
      return null;
    }
  }

  Future<bool> get isAppInActive async {
    final hasRun = await storage.read(key: isAppInActiveKey);

    switch (hasRun) {
      case 'true':
        return true;
      default:
        return false;
    }
  }

  Future<bool> get isManualSyncRunning async {
    final hasRun = await storage.read(key: manualSyncKey);

    switch (hasRun) {
      case 'true':
        return true;
      default:
        return false;
    }
  }

  Future<RoleActionsWrapperModel?> get savedActions async {
    final actionsListString = await storage.read(key: actionsListkey);
    if (actionsListString == null) return null;

    try {
      final actions =
          RoleActionsWrapperModel.fromJson(json.decode(actionsListString));

      return actions;
    } catch (_) {
      return null;
    }
  }

  Future<bool> get boundaryRefetched async {
    final isboundaryRefetchRequired =
        await storage.read(key: boundaryRefetchInKey);

    switch (isboundaryRefetchRequired) {
      case 'true':
        return false;
      default:
        return true;
    }
  }

  Future<Map<String, int>> getAllProductSKUCounts() async {
    final userBody = await storage.read(key: userObjectKey);
    if (userBody == null) return {};
    final localStorageStringMap =
        await storage.read(key: Constants.productSKUCounts);
    if (localStorageStringMap == null) return {};
    try {
      final user = UserRequestModel.fromJson(json.decode(userBody));
      final userUUID = user.uuid;
      final localStorageMap =
          json.decode(localStorageStringMap) as Map<String, dynamic>;
      if (localStorageMap[userUUID] != null) {
        Map<String, int> productCountMap = {};
        for (var element in localStorageMap[userUUID].entries) {
          productCountMap[element.key.toString()] =
              int.parse(element.value.toString());
        }
        return productCountMap;
      }
    } catch (_) {}
    return {};
  }

  Future<void> setProductSKUCounts(Map<String, int> productCounts) async {
    final userBody = await storage.read(key: userObjectKey);
    if (userBody == null) return;

    try {
      final user = UserRequestModel.fromJson(json.decode(userBody));
      final userUUID = user.uuid;

      Map<String, int> skuCounts = {};

      for (final entry in productCounts.entries) {
        final productCountKey = entry.key;
        final productCount = entry.value;

        skuCounts[productCountKey] = productCount;
      }

      Map<String, dynamic> skuCountsWithUUID = {userUUID: skuCounts};

      await storage.write(
        key: Constants.productSKUCounts,
        value: json.encode(skuCountsWithUUID),
      );
    } catch (_) {
      return;
    }
  }

  Future<void> setSelectedProject(ProjectModel projectModel) async {
    await storage.write(
      key: selectedProjectKey,
      value: projectModel.toJson(),
    );
  }

  Future<void> setSelectedProjectType(ProjectType? projectType) async {
    await storage.write(
      key: selectedProjectTypeKey,
      value: json.encode(projectType),
    );
  }

  Future<void> setSelectedIndividual(String? individualId) async {
    await storage.write(
      key: selectedIndividualKey,
      value: individualId,
    );
  }

  // Note TO the app  as Trigger Manual Sync or Not
  Future<void> setManualSyncTrigger(bool isManualSync) async {
    await storage.write(
      key: manualSyncKey,
      value: isManualSync.toString(),
    );
  }

  Future<void> setAuthCredentials(AuthModel model) async {
    await storage.write(key: accessTokenKey, value: model.accessToken);
    await storage.write(key: refreshTokenKey, value: model.refreshToken);
    await storage.write(
      key: userObjectKey,
      value: json.encode(model.userRequestModel),
    );
  }

  Future<void> setBoundaryRefetch(bool isboundaryRefetch) async {
    await storage.write(
      key: boundaryRefetchInKey,
      value: isboundaryRefetch.toString(),
    );
  }

  Future<void> setRoleActions(RoleActionsWrapperModel actions) async {
    await storage.write(
      key: actionsListkey,
      value: json.encode(actions),
    );
  }

  Future<void> setBackgroundService(bool isRunning) async {
    await storage.write(key: backgroundServiceKey, value: isRunning.toString());
  }

  Future<void> setHasAppRunBefore(bool hasRunBefore) async {
    await storage.write(key: hasAppRunBeforeKey, value: '$hasRunBefore');
  }

  // Note TO the app is in closed state or not
  Future<void> setAppInActive(bool isRunning) async {
    await storage.write(key: isAppInActiveKey, value: isRunning.toString());
  }

  Future<bool> get hasAppRunBefore async {
    final hasRun = await storage.read(key: hasAppRunBeforeKey);

    switch (hasRun) {
      case 'true':
        return true;
      default:
        return false;
    }
  }

  Future<void> deleteAll() async {
    // await storage.deleteAll();

    Map<String, String> allValues = await storage.readAll();
    List<String> allKeys = allValues.keys.toList();

    List<String> keysToDelete =
        allKeys.whereNot((key) => key == Constants.productSKUCounts).toList();

    for (String key in keysToDelete) {
      await storage.delete(key: key);
    }
  }

  /*Sets the bool value of project setup as true once project data is downloaded*/
  Future<void> setProjectSetUpComplete(String key, bool value) async {
    await storage.write(
      key: key,
      value: value.toString(),
    );
  }

  /*Checks for project data loaded or not*/
  Future<bool> isProjectSetUpComplete(String projectId) async {
    final isProjectSetUpComplete = await storage.read(key: projectId);

    switch (isProjectSetUpComplete) {
      case 'true':
        return true;
      default:
        return false;
    }
  }
}
