//-----------------Account--------------
class AccountModel {
  final int id;
  final String name;
  final String email;
  final String username;
  final String password;
  final String createdDate;
  final String profileInfo;
  final String profileImage;
  final bool error;
  final String errorMessage;

  AccountModel(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.password,
      this.createdDate,
      this.profileInfo,
      this.profileImage,
      this.error,
      this.errorMessage});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['account_id'],
      name: json['account_name'],
      email: json['account_email'],
      username: json['account_username'],
      password: json['account_password'],
      createdDate: json['account_created_date'],
      profileInfo: json['account_profile_info'],
      profileImage: json['account_profile_image'],
    );
  }
}

//----------------Check----------------
class CheckModel {
  final String id;
  final int voterId;
  final int pollId;
  final int checked;

  CheckModel({
    this.id,
    this.voterId,
    this.pollId,
    this.checked,
  });

  factory CheckModel.fromJson(Map<String, dynamic> json) {
    return CheckModel(
      id: json['checked_id'],
      voterId: json['voter_account_id'],
      pollId: json['poll_id'],
      checked: json['checked'],
    );
  }
}

//-----------------Poll-----------------
class PollModel {
  final String id;
  final int creatorId;
  final List<int> votersIds;
  final String title;
  final String createdDate;
  final String fighter1;
  final String fighter2;
  final String image;
  final bool status;
  final int votesForFighter1;
  final int votesForFighter2;
  final int votesForDraw;
  final int votesForCanceled;
  final int view;

  PollModel({
    this.id,
    this.creatorId,
    this.votersIds,
    this.title,
    this.createdDate,
    this.fighter1,
    this.fighter2,
    this.image,
    this.status,
    this.votesForFighter1,
    this.votesForFighter2,
    this.votesForDraw,
    this.votesForCanceled,
    this.view,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['poll_id'],
      creatorId: json['poll_creator_id'],
      votersIds: json['poll_voters_ids'],
      title: json['poll_title'],
      createdDate: json['poll_created_date'],
      fighter1: json['poll_fighter1'],
      fighter2: json['poll_fighter2'],
      image: json['poll_image'],
      status: json['poll_status'],
      votesForFighter1: json['poll_votes_for_fighter1'],
      votesForFighter2: json['poll_votes_for_fighter2'],
      votesForDraw: json['poll_votes_for_draw'],
      votesForCanceled: json['poll_votes_for_canceled'],
      view: json['view'],
    );
  }
}
//-----------------Comment--------------

class CommentModel {
  final String id;
  final int parentCommentId;
  final int replyId;
  final int creatorId;
  final String createdDate;
  final String info;
  final int likes;

  CommentModel({
    this.id,
    this.parentCommentId,
    this.replyId,
    this.creatorId,
    this.createdDate,
    this.info,
    this.likes,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['comment_id'],
      parentCommentId: json['parent_comment_id'],
      replyId: json['reply_id'],
      creatorId: json['comment_creator_account_id'],
      createdDate: json['comment_created_date'],
      info: json['comment_info'],
      likes: json['comment_likes'],
    );
  }
}

//--------------Notification----------

class NotificationModel {
  final int id;
  final int toUserId;
  final int fromUserId;
  final String message;
  final String createdDate;
  final bool isRead;
  final bool isComment;
  final bool error;
  final String errorMessage;

  NotificationModel({
    this.id,
    this.toUserId,
    this.fromUserId,
    this.message,
    this.createdDate,
    this.isRead,
    this.isComment,
    this.error,
    this.errorMessage,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['notification_id'],
      toUserId: json['notification_to_user_id'],
      fromUserId: json['notification_from_id'],
      message: json['notification_message'],
      createdDate: json['notification_created_date'],
      isRead: json['notification_read'],
      isComment: json['notification_comment'],
    );
  }
}
