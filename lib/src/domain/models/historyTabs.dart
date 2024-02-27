class HistoryTab {
  final int id;
  final String type;

  HistoryTab(this.id, this.type);
}

List<HistoryTab> historyTabs = [
  HistoryTab(1, "All"),
  HistoryTab(2, "Approved"),
  HistoryTab(3, "Pending"),
  HistoryTab(4, "Rejected"),
];
