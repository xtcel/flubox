class ArgumentsKeys {
  /// 运单号
  static String transportNo = "transportNo";

  /// 模型
  static String model = "model";

  /// id
  static String id = "id";

  /// 是否过期
  static String isBeOverdue = "isBeOverdue";

  ///
  static String ownerType = "ownerType";

  /// 我的信息
  static String mineInfo = "mineInfo";

  /// 审核状态
  static String auditStatus = "auditStatus";

  /// 标题
  static String title = "title";

  /// 车牌号
  static String carNumber = "carNumber";

  /// 重新上传
  static const String reUpload = 'reUpload';

  /// 平台类型
  static const String platformType = 'platformType';

  /// datas 用于传递map类型数据
  static const String datas = 'datas';

  ///船运-是否禁止显示协议
  static const String shippingProhibitContract = 'shipping_prohibit_contract';

  static const String states = "states"; //运单状态筛选
  static const String auths = "auths"; //车辆审核状态筛选
  static const String overdues = "overdues"; //证件过期筛选
  static const String papersTypes = "papersTypes"; //证件类型筛选
  /// 一体化-是否剩料签收
  static const String isSurplusConfirm = 'isSurplusConfirm';

  /// 发货单号
  static const String sendCarsNo = 'sendCarsNo';

  /// 发货方量
  static const String planSquare = 'planSquare';

  /// 剩料方量
  static const String backSquare = 'backSquare';

  /// 签收方量
  static const String deliverSquare = 'deliverSquare';

  /// 称重算法状态
  static const String weightingAlgStatus = 'weightingAlgStatus';

  /// url
  static const String url = 'url';
}

class RouterKeys {
  static const String title = 'title'; //标题
  static const String carNumber = 'carNumber'; //车牌号
  static const String carGps = 'carGps'; //车辆gps
  static const String siteLocation = 'siteLocation'; // 工地坐标（string类型）
  static const String siteClosure = 'siteClosure'; // 工地围栏
  static const String robotInfoList = 'robotInfoList'; //一体化机器人信息List
  static const String projectName = 'projectName';
  static const String feeStatus = 'feeStatus';
  static const String screenModel = 'screenModel';
  static const String carId = 'carId';
  static const String driverId = 'driverId';
  static const String states = 'states';
  static const String isChangeFleet = 'isChangeFleet';
  static const String sendCarsNo = 'sendCarsNo';
  static const String userId = 'userId';
  static const String fromType = 'fromType';
  static const String isRebinding = 'isRebinding';
  static const String dockName = "dockName"; //卸货码头名称
  static const String tenantName = "tenantName"; //搅拌站名称
  static const String dockId = "dockId"; //卸货码头id
  static const String cargoId = "cargoId"; //上次选择的货物id
  static const String transportNo = "transportNo";
  static const String unloadDockId = "unloadDockId";
  static const String loadDockId = "loadDockId";
  static const String shipId = "shipId";
  static const String purchaseOrderNo = "purchaseOrderNo";
}

/// 路由返回结果类型
class RouterResultType {
  // 获取数据失败
  static const int fail = 0;
  // 默认返回成功
  static const int success = 1;
  // 需要刷新数据
  static const int update = 2;
}
