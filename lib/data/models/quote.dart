/// quote_id : 9
/// quote : "Funyuns are awesome."
/// author : "Jesse Pinkman"
/// series : "Breaking Bad"

class Quote {
  int? _quoteId;
  String? _quote;

  int? get quoteId => _quoteId;

  String? get quote => _quote;

  Quote({
    int? quoteId,
    String? quote,
  }) {
    _quoteId = quoteId;
    _quote = quote;
  }

  Quote.fromJson(dynamic json) {
    _quoteId = json['quote_id'];
    _quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quote_id'] = _quoteId;
    map['quote'] = _quote;
    return map;
  }
}
