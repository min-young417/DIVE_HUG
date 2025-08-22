class RiskResponse {
  final double riskScore;
  final String aiExplanation;

  RiskResponse({required this.riskScore, required this.aiExplanation});

  factory RiskResponse.fromJson(Map<String, dynamic> json) {
    return RiskResponse(
      riskScore: (json['risk_score'] as num).toDouble(),
      aiExplanation: json['ai_explanation'] as String,
    );
  }
}