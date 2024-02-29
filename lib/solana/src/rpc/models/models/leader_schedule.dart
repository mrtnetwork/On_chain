/// Leader schedule
class LeaderSchedule {
  final Map<String, List<int>> values;
  const LeaderSchedule({required this.values});
  factory LeaderSchedule.fromJson(Map<String, dynamic> json) {
    return LeaderSchedule(values: {
      for (final i in json.entries) i.key: (i.value as List).cast()
    });
  }
}
