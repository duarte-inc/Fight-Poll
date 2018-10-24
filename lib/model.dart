class FightPoll {
  final int id;
  final String title, pic;
  final DateTime postedDate;
  final int drawNum, name1Num, name2Num, canceledNum;
  final String name1Name, name2Name;
  final bool status;

  FightPoll({
    this.id,
    this.title,
    this.pic,
    this.postedDate,
    this.drawNum,
    this.name1Num,
    this.name2Num,
    this.name1Name,
    this.name2Name,
    this.canceledNum,
    this.status,
  });
}
