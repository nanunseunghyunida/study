class GlobalUtil {
  // 스크롤 하단인지
  bool bottomScrollCheck(double maxPosition, double currentPosition, double difference) {
    return !(maxPosition == 0.0 && currentPosition <= 0.0) && (maxPosition - currentPosition <= difference);
  }

  // 스크롤 상단인지
  bool topScrollCheck(double maxPosition, double currentPosition) {
    return maxPosition == 0.0 && currentPosition <= 0.0;
  }
}
