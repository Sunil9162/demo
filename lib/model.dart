class Meta {
  String? startupId;
  String? startupName;
  String? startupSectors;
  String? startupLogo;
  String? startupLocation;
  String? startupFounderDetails;
  String? startupWebsite;
  String? startupPunchedBy;
  String? startupEmployeeId;
  String? startupPunchedDate;

  Meta(
      {this.startupId,
      this.startupName,
      this.startupSectors,
      this.startupLogo,
      this.startupLocation,
      this.startupFounderDetails,
      this.startupWebsite,
      this.startupPunchedBy,
      this.startupEmployeeId,
      this.startupPunchedDate});

  Meta.fromJson(Map<String, dynamic> json) {
    startupId = json['Startup_id'];
    startupName = json['Startup_Name'];
    startupSectors = json['Startup_Sectors'];
    startupLogo = json['Startup_Logo'];
    startupLocation = json['Startup_Location'];
    startupFounderDetails = json['Startup_FounderDetails'];
    startupWebsite = json['Startup_Website'];
    startupPunchedBy = json['Startup_PunchedBy'];
    startupEmployeeId = json['Startup_EmployeeId'];
    startupPunchedDate = json['Startup_PunchedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Startup_id'] = startupId;
    data['Startup_Name'] = startupName;
    data['Startup_Sectors'] = startupSectors;
    data['Startup_Logo'] = startupLogo;
    data['Startup_Location'] = startupLocation;
    data['Startup_FounderDetails'] = startupFounderDetails;
    data['Startup_Website'] = startupWebsite;
    data['Startup_PunchedBy'] = startupPunchedBy;
    data['Startup_EmployeeId'] = startupEmployeeId;
    data['Startup_PunchedDate'] = startupPunchedDate;
    return data;
  }
}
