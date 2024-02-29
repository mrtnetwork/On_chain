class MinContextSlot {
  const MinContextSlot({required this.slot});
  final int slot;
  Map<String, dynamic> toJson() {
    return {"minContextSlot": slot};
  }
}
