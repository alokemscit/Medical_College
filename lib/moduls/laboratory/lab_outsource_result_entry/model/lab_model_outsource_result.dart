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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result_id'] = resultId;
    data['mr_id'] = mrId;
    data['sample_id'] = sampleId;
    data['test_id'] = testId;
    data['delta'] = delta;
    data['html'] = html;
    data['pdf'] = pdf;
    return data;
  }
}
