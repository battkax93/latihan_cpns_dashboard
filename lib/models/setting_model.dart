class SettingModels {
  String id;
  String isMaintenance;
  String isContainAds;
  String isApproveAdd;

  SettingModels({this.id, this.isMaintenance, this.isContainAds, this.isApproveAdd});

  SettingModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMaintenance = json['is_maintenance'];
    isContainAds = json['is_contain_ads'];
    isApproveAdd = json['is_approve_add'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_maintenance'] = this.isMaintenance;
    data['is_contain_ads'] = this.isContainAds;
    data['is_approve_add'] = this.isApproveAdd;
    return data;
  }
}
