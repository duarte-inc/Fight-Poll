class FightInfo {
  final int id, pollId;
  final String title, pic, name1Name, name2Name;
  final DateTime postedDate;
  final bool status;

  FightInfo({
    this.id,
    this.pollId,
    this.title,
    this.pic,
    this.postedDate,
    this.name1Name,
    this.name2Name,
    this.status,
  });
}

class FightPoll {
  final int id;
  final int drawNum, name1Num, name2Num, canceledNum;

  FightPoll({
    this.id,
    this.drawNum,
    this.name2Num,
    this.name1Num,
    this.canceledNum,
  });
}
