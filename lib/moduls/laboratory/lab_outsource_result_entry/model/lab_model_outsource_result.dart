class ModelOutSourceResult {
  String? resultId;
  String? mrId;
  String? sampleId;
  String? testId;
  String? delta;
  String? html;
  String? pdf;

  ModelOutSourceResult(
      {this.resultId,
      this.mrId,
      this.sampleId,
      this.testId,
      this.delta,
      this.html,
      this.pdf});

  ModelOutSourceResult.fromJson(Map<String, dynamic> json) {
    resultId = json['result_id'];
    mrId = json['mr_id'];
    sampleId = json['sample_id'];
    testId = json['test_id'];
    delta = json['delta'];
    html = json['html'];
    pdf = json['pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result_id'] = this.resultId;
    data['mr_id'] = this.mrId;
    data['sample_id'] = this.sampleId;
    data['test_id'] = this.testId;
    data['delta'] = this.delta;
    data['html'] = this.html;
    data['pdf'] = this.pdf;
    return data;
  }
}
