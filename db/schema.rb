# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 0) do
  create_table "GDN_AccessToken", primary_key: "AccessTokenID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Token", limit: 100, null: false
    t.integer "UserID", null: false
    t.string "Type", limit: 20, null: false
    t.text "Scope"
    t.timestamp "DateInserted", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "InsertUserID"
    t.binary "InsertIPAddress", limit: 16, null: false
    t.timestamp "DateExpires", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "Attributes"
    t.index ["DateExpires"], name: "IX_AccessToken_DateExpires"
    t.index ["Token"], name: "UX_AccessToken", unique: true
    t.index ["Type"], name: "IX_AccessToken_Type"
    t.index ["UserID"], name: "IX_AccessToken_UserID"
  end

  create_table "GDN_Action", primary_key: "ActionID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Name", limit: 140, null: false
    t.string "Description", null: false
    t.string "Tooltip", null: false
    t.string "CssClass", null: false
    t.integer "AwardValue", default: 1, null: false
    t.string "Permission", default: "Yaga.Reactions.Add", null: false
    t.integer "Sort"
  end

  create_table "GDN_Activity", primary_key: "ActivityID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "CommentActivityID"
    t.integer "ActivityTypeID", null: false
    t.integer "NotifyUserID", default: 0, null: false
    t.integer "ActivityUserID"
    t.integer "RegardingUserID"
    t.string "Photo"
    t.string "HeadlineFormat"
    t.text "Story"
    t.string "Format", limit: 10
    t.string "Route"
    t.string "RecordType", limit: 20
    t.integer "RecordID"
    t.integer "CountComments", default: 0, null: false
    t.integer "InsertUserID"
    t.datetime "DateInserted", precision: nil, null: false
    t.binary "InsertIPAddress", limit: 16
    t.datetime "DateUpdated", precision: nil, null: false
    t.integer "Notified", limit: 1, default: 0, null: false
    t.integer "Emailed", limit: 1, default: 0, null: false
    t.text "Data"
    t.index ["CommentActivityID"], name: "FK_Activity_CommentActivityID"
    t.index ["DateUpdated"], name: "IX_Activity_DateUpdated"
    t.index ["InsertUserID"], name: "FK_Activity_InsertUserID"
    t.index ["NotifyUserID", "ActivityUserID", "DateUpdated"], name: "IX_Activity_Feed"
    t.index ["NotifyUserID", "DateUpdated"], name: "IX_Activity_Recent"
    t.index ["NotifyUserID", "Notified"], name: "IX_Activity_Notify"
  end

  create_table "GDN_ActivityComment", primary_key: "ActivityCommentID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "ActivityID", null: false
    t.text "Body", null: false
    t.string "Format", limit: 20, null: false
    t.integer "InsertUserID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.binary "InsertIPAddress", limit: 16
    t.index ["ActivityID"], name: "FK_ActivityComment_ActivityID"
  end

  create_table "GDN_ActivityType", primary_key: "ActivityTypeID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Name", limit: 20, null: false
    t.integer "AllowComments", limit: 1, default: 0, null: false
    t.integer "ShowIcon", limit: 1, default: 0, null: false
    t.string "ProfileHeadline"
    t.string "FullHeadline"
    t.string "RouteCode"
    t.integer "Notify", limit: 1, default: 0, null: false
    t.integer "Public", limit: 1, default: 1, null: false
  end

  create_table "GDN_AnalyticsLocal", id: false, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "TimeSlot", limit: 8, null: false
    t.integer "Views"
    t.integer "EmbedViews"
    t.index ["TimeSlot"], name: "UX_AnalyticsLocal", unique: true
  end

  create_table "GDN_Attachment", primary_key: "AttachmentID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Type", limit: 64, null: false
    t.string "ForeignID", limit: 50, null: false
    t.integer "ForeignUserID", null: false
    t.string "Source", limit: 64, null: false
    t.string "SourceID", limit: 32, null: false
    t.string "SourceURL", null: false
    t.text "Attributes"
    t.datetime "DateInserted", precision: nil, null: false
    t.integer "InsertUserID", null: false
    t.binary "InsertIPAddress", limit: 16, null: false
    t.datetime "DateUpdated", precision: nil
    t.integer "UpdateUserID"
    t.binary "UpdateIPAddress", limit: 16
    t.index ["ForeignID"], name: "IX_Attachment_ForeignID"
    t.index ["ForeignUserID"], name: "FK_Attachment_ForeignUserID"
    t.index ["InsertUserID"], name: "FK_Attachment_InsertUserID"
  end

  create_table "GDN_Badge", primary_key: "BadgeID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Name", limit: 140, null: false
    t.string "Description"
    t.string "Photo"
    t.string "RuleClass", null: false
    t.text "RuleCriteria"
    t.integer "AwardValue", default: 0, null: false
    t.integer "Enabled", limit: 1, default: 1, null: false
    t.integer "Sort"
  end

  create_table "GDN_BadgeAward", primary_key: "BadgeAwardID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "BadgeID", null: false
    t.integer "UserID", null: false
    t.integer "InsertUserID"
    t.text "Reason"
    t.datetime "DateInserted", precision: nil, null: false
  end

  create_table "GDN_Ban", primary_key: "BanID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.column "BanType", "enum('IPAddress','Name','Email')", null: false
    t.string "BanValue", limit: 50, null: false
    t.string "Notes"
    t.integer "CountUsers", default: 0, null: false, unsigned: true
    t.integer "CountBlockedRegistrations", default: 0, null: false, unsigned: true
    t.integer "InsertUserID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.binary "InsertIPAddress", limit: 16
    t.integer "UpdateUserID"
    t.datetime "DateUpdated", precision: nil
    t.binary "UpdateIPAddress", limit: 16
    t.index ["BanType", "BanValue"], name: "UX_Ban", unique: true
  end

  create_table "GDN_Category", primary_key: "CategoryID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "ParentCategoryID"
    t.integer "TreeLeft"
    t.integer "TreeRight"
    t.integer "Depth", default: 0, null: false
    t.integer "CountCategories", default: 0, null: false
    t.integer "CountDiscussions", default: 0, null: false
    t.integer "CountAllDiscussions", default: 0, null: false
    t.integer "CountComments", default: 0, null: false
    t.integer "CountAllComments", default: 0, null: false
    t.integer "LastCategoryID", default: 0, null: false
    t.datetime "DateMarkedRead", precision: nil
    t.integer "AllowDiscussions", limit: 1, default: 1, null: false
    t.integer "Archived", limit: 1, default: 0, null: false
    t.integer "CanDelete", limit: 1, default: 1, null: false
    t.string "Name", null: false
    t.string "UrlCode"
    t.string "Description", limit: 500
    t.integer "Sort"
    t.string "CssClass", limit: 50
    t.string "Photo"
    t.string "BannerImage"
    t.integer "PermissionCategoryID", default: -1, null: false
    t.integer "PointsCategoryID", default: 0, null: false
    t.integer "HideAllDiscussions", limit: 1, default: 0, null: false
    t.column "DisplayAs", "enum('Categories','Discussions','Flat','Heading','Default')", default: "Discussions", null: false
    t.integer "InsertUserID", null: false
    t.integer "UpdateUserID"
    t.datetime "DateInserted", precision: nil, null: false
    t.datetime "DateUpdated", precision: nil, null: false
    t.integer "LastCommentID"
    t.integer "LastDiscussionID"
    t.datetime "LastDateInserted", precision: nil
    t.string "AllowedDiscussionTypes"
    t.string "DefaultDiscussionType", limit: 10
    t.integer "Featured", limit: 1, default: 0, null: false
    t.integer "SortFeatured", default: 0, null: false
    t.integer "AllowFileUploads", limit: 1, default: 1, null: false
    t.index ["InsertUserID"], name: "FK_Category_InsertUserID"
    t.index ["ParentCategoryID"], name: "FK_Category_ParentCategoryID"
    t.index ["SortFeatured"], name: "IX_Category_SortFeatured"
  end

  create_table "GDN_Comment", primary_key: "CommentID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "DiscussionID", null: false
    t.integer "InsertUserID"
    t.integer "UpdateUserID"
    t.integer "DeleteUserID"
    t.text "Body", null: false
    t.string "Format", limit: 20
    t.datetime "DateInserted", precision: nil
    t.datetime "DateDeleted", precision: nil
    t.datetime "DateUpdated", precision: nil
    t.binary "InsertIPAddress", limit: 16
    t.binary "UpdateIPAddress", limit: 16
    t.integer "Flag", limit: 1, default: 0, null: false
    t.float "Score"
    t.text "Attributes"
    t.index ["Body"], name: "TX_Comment", type: :fulltext
    t.index ["DateInserted"], name: "IX_Comment_DateInserted"
    t.index ["DiscussionID", "DateInserted"], name: "IX_Comment_1"
    t.index ["InsertUserID", "DiscussionID"], name: "IX_Comment_InsertUserID_DiscussionID"
    t.index ["InsertUserID"], name: "FK_Comment_InsertUserID"
    t.index ["Score"], name: "IX_Comment_Score"
  end

  create_table "GDN_Conversation", primary_key: "ConversationID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Type", limit: 10
    t.string "ForeignID", limit: 40
    t.string "Subject"
    t.string "Contributors"
    t.integer "FirstMessageID"
    t.integer "InsertUserID", null: false
    t.datetime "DateInserted", precision: nil
    t.binary "InsertIPAddress", limit: 16
    t.integer "UpdateUserID", null: false
    t.datetime "DateUpdated", precision: nil, null: false
    t.binary "UpdateIPAddress", limit: 16
    t.integer "CountMessages", default: 0, null: false
    t.integer "CountParticipants", default: 0, null: false
    t.integer "LastMessageID"
    t.integer "RegardingID"
    t.index ["DateInserted"], name: "FK_Conversation_DateInserted"
    t.index ["FirstMessageID"], name: "FK_Conversation_FirstMessageID"
    t.index ["InsertUserID"], name: "FK_Conversation_InsertUserID"
    t.index ["RegardingID"], name: "IX_Conversation_RegardingID"
    t.index ["Type"], name: "IX_Conversation_Type"
    t.index ["UpdateUserID"], name: "FK_Conversation_UpdateUserID"
  end

  create_table "GDN_ConversationMessage", primary_key: "MessageID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "ConversationID", null: false
    t.text "Body", null: false
    t.string "Format", limit: 20
    t.integer "InsertUserID"
    t.datetime "DateInserted", precision: nil, null: false
    t.binary "InsertIPAddress", limit: 16
    t.index ["ConversationID"], name: "FK_ConversationMessage_ConversationID"
    t.index ["InsertUserID"], name: "FK_ConversationMessage_InsertUserID"
  end

  create_table "GDN_Discussion", primary_key: "DiscussionID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Type", limit: 10
    t.string "ForeignID", limit: 32
    t.integer "CategoryID", null: false
    t.integer "InsertUserID", null: false
    t.integer "UpdateUserID"
    t.integer "FirstCommentID"
    t.integer "LastCommentID"
    t.string "Name", limit: 100, null: false
    t.text "Body", null: false
    t.string "Format", limit: 20
    t.text "Tags"
    t.integer "CountComments", default: 0, null: false
    t.integer "CountBookmarks"
    t.integer "CountViews", default: 1, null: false
    t.integer "Closed", limit: 1, default: 0, null: false
    t.integer "Announce", limit: 1, default: 0, null: false
    t.integer "Sink", limit: 1, default: 0, null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.datetime "DateUpdated", precision: nil
    t.binary "InsertIPAddress", limit: 16
    t.binary "UpdateIPAddress", limit: 16
    t.datetime "DateLastComment", precision: nil
    t.integer "LastCommentUserID"
    t.float "Score"
    t.text "Attributes"
    t.integer "RegardingID"
    t.integer "hot", default: 0, null: false
    t.index ["Announce"], name: "IX_Discussion_Announce"
    t.index ["CategoryID", "DateInserted"], name: "IX_Discussion_CategoryInserted"
    t.index ["CategoryID", "DateLastComment"], name: "IX_Discussion_CategoryPages"
    t.index ["CategoryID"], name: "FK_Discussion_CategoryID"
    t.index ["DateInserted"], name: "IX_Discussion_DateInserted"
    t.index ["DateLastComment"], name: "IX_Discussion_DateLastComment"
    t.index ["ForeignID"], name: "IX_Discussion_ForeignID"
    t.index ["InsertUserID"], name: "FK_Discussion_InsertUserID"
    t.index ["Name", "Body"], name: "TX_Discussion", type: :fulltext
    t.index ["RegardingID"], name: "IX_Discussion_RegardingID"
    t.index ["Score"], name: "IX_Discussion_Score"
    t.index ["Type"], name: "IX_Discussion_Type"
    t.index ["hot"], name: "IX_Discussion_hot"
  end

  create_table "GDN_Draft", primary_key: "DraftID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "DiscussionID"
    t.integer "CategoryID"
    t.integer "InsertUserID", null: false
    t.integer "UpdateUserID", null: false
    t.string "Name", limit: 100
    t.string "Tags"
    t.integer "Closed", limit: 1, default: 0, null: false
    t.integer "Announce", limit: 1, default: 0, null: false
    t.integer "Sink", limit: 1, default: 0, null: false
    t.text "Body", null: false
    t.string "Format", limit: 20
    t.datetime "DateInserted", precision: nil, null: false
    t.datetime "DateUpdated", precision: nil
    t.index ["CategoryID"], name: "FK_Draft_CategoryID"
    t.index ["DiscussionID"], name: "FK_Draft_DiscussionID"
    t.index ["InsertUserID"], name: "FK_Draft_InsertUserID"
  end

  create_table "GDN_Flag", id: false, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "InsertUserID", null: false
    t.string "InsertName", limit: 64, null: false
    t.integer "AuthorID", null: false
    t.string "AuthorName", limit: 64, null: false
    t.string "ForeignURL", limit: 191, null: false
    t.integer "ForeignID", null: false
    t.string "ForeignType", limit: 32, null: false
    t.text "Comment", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.integer "DiscussionID"
    t.index ["ForeignURL"], name: "FK_Flag_ForeignURL"
    t.index ["InsertUserID"], name: "FK_Flag_InsertUserID"
  end

  create_table "GDN_Invitation", primary_key: "InvitationID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Email", limit: 100, null: false
    t.string "Name", limit: 50
    t.text "RoleIDs"
    t.string "Code", limit: 50, null: false
    t.integer "InsertUserID"
    t.datetime "DateInserted", precision: nil, null: false
    t.integer "AcceptedUserID"
    t.datetime "DateAccepted", precision: nil
    t.datetime "DateExpires", precision: nil
    t.index ["Code"], name: "UX_Invitation_code", unique: true
    t.index ["Email"], name: "IX_Invitation_Email"
    t.index ["InsertUserID", "DateInserted"], name: "IX_Invitation_userdate"
    t.index ["InsertUserID"], name: "FK_Invitation_InsertUserID"
  end

  create_table "GDN_Log", primary_key: "LogID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.column "Operation", "enum('Delete','Edit','Spam','Moderate','Pending','Ban','Error')", null: false
    t.column "RecordType", "enum('Discussion','Comment','User','Registration','Activity','ActivityComment','Configuration','Group','Event')", null: false
    t.integer "TransactionLogID"
    t.integer "RecordID"
    t.integer "RecordUserID"
    t.datetime "RecordDate", precision: nil, null: false
    t.binary "RecordIPAddress", limit: 16
    t.integer "InsertUserID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.binary "InsertIPAddress", limit: 16
    t.string "OtherUserIDs"
    t.datetime "DateUpdated", precision: nil
    t.integer "ParentRecordID"
    t.integer "CategoryID"
    t.text "Data", size: :medium
    t.integer "CountGroup"
    t.index ["CategoryID"], name: "FK_Log_CategoryID"
    t.index ["DateInserted"], name: "IX_Log_DateInserted"
    t.index ["Operation"], name: "IX_Log_Operation"
    t.index ["ParentRecordID"], name: "IX_Log_ParentRecordID"
    t.index ["RecordID"], name: "IX_Log_RecordID"
    t.index ["RecordIPAddress"], name: "IX_Log_RecordIPAddress"
    t.index ["RecordType"], name: "IX_Log_RecordType"
    t.index ["RecordUserID"], name: "IX_Log_RecordUserID"
  end

  create_table "GDN_Media", primary_key: "MediaID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Name", null: false
    t.string "Path", null: false
    t.string "Type", limit: 128, null: false
    t.integer "Size", null: false
    t.integer "Active", limit: 1, default: 1, null: false
    t.integer "InsertUserID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.integer "ForeignID"
    t.string "ForeignTable", limit: 24
    t.integer "ImageWidth", limit: 2, unsigned: true
    t.integer "ImageHeight", limit: 2, unsigned: true
    t.integer "ThumbWidth", limit: 2, unsigned: true
    t.integer "ThumbHeight", limit: 2, unsigned: true
    t.string "ThumbPath"
    t.index ["ForeignID", "ForeignTable"], name: "IX_Media_Foreign"
    t.index ["InsertUserID"], name: "IX_Media_InsertUserID"
  end

  create_table "GDN_Message", primary_key: "MessageID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.text "Content", null: false
    t.string "Format", limit: 20
    t.integer "AllowDismiss", limit: 1, default: 1, null: false
    t.integer "Enabled", limit: 1, default: 1, null: false
    t.string "Application"
    t.string "Controller"
    t.string "Method"
    t.integer "CategoryID"
    t.integer "IncludeSubcategories", limit: 1, default: 0, null: false
    t.string "AssetTarget", limit: 20
    t.string "CssClass", limit: 20
    t.integer "Sort"
  end

  create_table "GDN_Permission", primary_key: "PermissionID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "RoleID", default: 0, null: false
    t.string "JunctionTable", limit: 100
    t.string "JunctionColumn", limit: 100
    t.integer "JunctionID"
    t.integer "Garden.Settings.Manage", limit: 1, default: 0, null: false
    t.integer "Garden.Settings.View", limit: 1, default: 0, null: false
    t.integer "Garden.SignIn.Allow", limit: 1, default: 0, null: false
    t.integer "Garden.Applicants.Manage", limit: 1, default: 0, null: false
    t.integer "Garden.Roles.Manage", limit: 1, default: 0, null: false
    t.integer "Garden.Users.Add", limit: 1, default: 0, null: false
    t.integer "Garden.Users.Edit", limit: 1, default: 0, null: false
    t.integer "Garden.Users.Delete", limit: 1, default: 0, null: false
    t.integer "Garden.Users.Approve", limit: 1, default: 0, null: false
    t.integer "Garden.Activity.Delete", limit: 1, default: 0, null: false
    t.integer "Garden.Activity.View", limit: 1, default: 0, null: false
    t.integer "Garden.Profiles.View", limit: 1, default: 0, null: false
    t.integer "Garden.Profiles.Edit", limit: 1, default: 0, null: false
    t.integer "Garden.Curation.Manage", limit: 1, default: 0, null: false
    t.integer "Garden.Moderation.Manage", limit: 1, default: 0, null: false
    t.integer "Garden.PersonalInfo.View", limit: 1, default: 0, null: false
    t.integer "Garden.AdvancedNotifications.Allow", limit: 1, default: 0, null: false
    t.integer "Garden.Community.Manage", limit: 1, default: 0, null: false
    t.integer "Garden.Tokens.Add", limit: 1, default: 0, null: false
    t.integer "Garden.Uploads.Add", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.View", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.Add", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.Edit", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.Announce", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.Sink", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.Close", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.Delete", limit: 1, default: 0, null: false
    t.integer "Vanilla.Comments.Add", limit: 1, default: 0, null: false
    t.integer "Vanilla.Comments.Edit", limit: 1, default: 0, null: false
    t.integer "Vanilla.Comments.Delete", limit: 1, default: 0, null: false
    t.integer "Garden.Email.View", limit: 1, default: 0, null: false
    t.integer "Conversations.Moderation.Manage", limit: 1, default: 0, null: false
    t.integer "Conversations.Conversations.Add", limit: 1, default: 0, null: false
    t.integer "Vanilla.Approval.Require", limit: 1, default: 0, null: false
    t.integer "Vanilla.Comments.Me", limit: 1, default: 0, null: false
    t.integer "Vanilla.Discussions.CloseOwn", limit: 1, default: 0, null: false
    t.integer "Plugins.Attachments.Upload.Allow", limit: 1, default: 0, null: false
    t.integer "Plugins.Flagging.Notify", limit: 1, default: 0, null: false
    t.integer "Vanilla.Tagging.Add", limit: 1, default: 0, null: false
    t.integer "Plugins.Tagging.Add", limit: 1, default: 0, null: false
    t.integer "Yaga.Reactions.Add", limit: 1, default: 0, null: false
    t.integer "Yaga.Reactions.Manage", limit: 1, default: 0, null: false
    t.integer "Yaga.Reactions.View", limit: 1, default: 0, null: false
    t.integer "Yaga.Reactions.Edit", limit: 1, default: 0, null: false
    t.integer "Yaga.Badges.Add", limit: 1, default: 0, null: false
    t.integer "Yaga.Badges.Manage", limit: 1, default: 0, null: false
    t.integer "Yaga.Badges.View", limit: 1, default: 0, null: false
    t.integer "Yaga.Ranks.Add", limit: 1, default: 0, null: false
    t.integer "Yaga.Ranks.Manage", limit: 1, default: 0, null: false
    t.integer "Yaga.Ranks.View", limit: 1, default: 0, null: false
    t.index ["RoleID"], name: "FK_Permission_RoleID"
  end

  create_table "GDN_Photo", primary_key: "PhotoID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Name", null: false
    t.integer "InsertUserID"
    t.datetime "DateInserted", precision: nil, null: false
    t.index ["InsertUserID"], name: "FK_Photo_InsertUserID"
  end

  create_table "GDN_Rank", primary_key: "RankID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Name", limit: 140, null: false
    t.string "Description"
    t.integer "Sort"
    t.integer "PointReq", default: 0, null: false
    t.integer "PostReq", default: 0, null: false
    t.integer "AgeReq", default: 0, null: false
    t.text "Perks"
    t.integer "Enabled", limit: 1, default: 1, null: false
  end

  create_table "GDN_Reaction", primary_key: "ReactionID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "InsertUserID", null: false
    t.integer "ActionID", null: false
    t.integer "ParentID"
    t.string "ParentType", limit: 100, null: false
    t.integer "ParentAuthorID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.index ["ActionID"], name: "IX_Reaction_ActionID"
    t.index ["InsertUserID"], name: "IX_Reaction_1"
    t.index ["ParentAuthorID"], name: "IX_Reaction_ParentAuthorID"
    t.index ["ParentID", "ParentType"], name: "IX_ParentID_ParentType"
  end

  create_table "GDN_Regarding", primary_key: "RegardingID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Type", limit: 100, null: false
    t.integer "InsertUserID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.string "ForeignType", limit: 32, null: false
    t.integer "ForeignID", null: false
    t.text "OriginalContent"
    t.string "ParentType", limit: 32
    t.integer "ParentID"
    t.string "ForeignURL"
    t.text "Comment", null: false
    t.integer "Reports"
    t.index ["Type"], name: "FK_Regarding_Type"
  end

  create_table "GDN_Role", primary_key: "RoleID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Name", limit: 100, null: false
    t.string "Description", limit: 500
    t.column "Type", "enum('guest','unconfirmed','applicant','member','moderator','administrator')"
    t.string "Sync", limit: 20, default: "", null: false
    t.integer "Sort"
    t.integer "Deletable", limit: 1, default: 1, null: false
    t.integer "CanSession", limit: 1, default: 1, null: false
    t.integer "PersonalInfo", limit: 1, default: 0, null: false
  end

  create_table "GDN_Session", primary_key: "SessionID", id: { type: :string, limit: 32 }, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "UserID", default: 0, null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.datetime "DateUpdated", precision: nil
    t.datetime "DateExpires", precision: nil
    t.text "Attributes"
    t.index ["DateExpires"], name: "IX_Session_DateExpires"
  end

  create_table "GDN_Spammer", primary_key: "UserID", id: :integer, default: nil, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "CountSpam", limit: 2, default: 0, null: false, unsigned: true
    t.integer "CountDeletedSpam", limit: 2, default: 0, null: false, unsigned: true
  end

  create_table "GDN_Tag", primary_key: "TagID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "Name", limit: 100, null: false
    t.string "FullName", limit: 100, null: false
    t.string "Type", limit: 20, default: "", null: false
    t.integer "ParentTagID"
    t.integer "InsertUserID"
    t.datetime "DateInserted", precision: nil, null: false
    t.integer "CategoryID", default: -1, null: false
    t.integer "CountDiscussions", default: 0, null: false
    t.index ["FullName"], name: "IX_Tag_FullName"
    t.index ["InsertUserID"], name: "FK_Tag_InsertUserID"
    t.index ["Name", "CategoryID"], name: "UX_Tag", unique: true
    t.index ["ParentTagID"], name: "FK_Tag_ParentTagID"
    t.index ["Type"], name: "IX_Tag_Type"
  end

  create_table "GDN_TagDiscussion", primary_key: ["TagID", "DiscussionID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "TagID", null: false
    t.integer "DiscussionID", null: false
    t.integer "CategoryID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.index ["CategoryID"], name: "IX_TagDiscussion_CategoryID"
  end

  create_table "GDN_User", primary_key: "UserID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Name", limit: 50, null: false
    t.binary "Password", limit: 100, null: false
    t.string "HashMethod", limit: 10
    t.string "Photo"
    t.string "Title", limit: 100
    t.string "Location", limit: 100
    t.text "About"
    t.string "Email", limit: 100, null: false
    t.integer "ShowEmail", limit: 1, default: 0, null: false
    t.column "Gender", "enum('u','m','f')", default: "u", null: false
    t.integer "CountVisits", default: 0, null: false
    t.integer "CountInvitations", default: 0, null: false
    t.integer "CountNotifications"
    t.integer "InviteUserID"
    t.text "DiscoveryText"
    t.text "Preferences"
    t.text "Permissions"
    t.text "Attributes"
    t.datetime "DateSetInvitations", precision: nil
    t.datetime "DateOfBirth", precision: nil
    t.datetime "DateFirstVisit", precision: nil
    t.datetime "DateLastActive", precision: nil
    t.binary "LastIPAddress", limit: 16
    t.string "AllIPAddresses", limit: 100
    t.datetime "DateInserted", precision: nil, null: false
    t.binary "InsertIPAddress", limit: 16
    t.datetime "DateUpdated", precision: nil
    t.binary "UpdateIPAddress", limit: 16
    t.integer "HourOffset", default: 0, null: false
    t.float "Score"
    t.integer "Admin", limit: 1, default: 0, null: false
    t.integer "Confirmed", limit: 1, default: 1, null: false
    t.integer "Verified", limit: 1, default: 0, null: false
    t.integer "Banned", limit: 1, default: 0, null: false
    t.integer "Deleted", limit: 1, default: 0, null: false
    t.integer "Points", default: 0, null: false
    t.integer "CountUnreadConversations"
    t.integer "CountDiscussions"
    t.integer "CountUnreadDiscussions"
    t.integer "CountComments"
    t.integer "CountDrafts"
    t.integer "CountBookmarks"
    t.datetime "DateAllViewed", precision: nil
    t.integer "CountBadges", default: 0, null: false
    t.integer "RankID"
    t.integer "RankProgression", limit: 1, default: 1, null: false
    t.index ["DateInserted"], name: "IX_User_DateInserted"
    t.index ["DateLastActive"], name: "IX_User_DateLastActive"
    t.index ["Email"], name: "IX_User_Email"
    t.index ["Name"], name: "FK_User_Name"
  end

  create_table "GDN_UserAuthentication", primary_key: ["ForeignUserKey", "ProviderKey"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "ForeignUserKey", limit: 100, null: false
    t.string "ProviderKey", limit: 64, null: false
    t.integer "UserID", null: false
    t.index ["UserID"], name: "FK_UserAuthentication_UserID"
  end

  create_table "GDN_UserAuthenticationNonce", primary_key: "Nonce", id: { type: :string, limit: 100 }, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Token", limit: 128, null: false
    t.timestamp "Timestamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["Timestamp"], name: "IX_UserAuthenticationNonce_Timestamp"
  end

  create_table "GDN_UserAuthenticationProvider", primary_key: "UserAuthenticationProviderID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "AuthenticationKey", limit: 64, null: false
    t.string "AuthenticationSchemeAlias", limit: 32, null: false
    t.string "Name", limit: 50
    t.string "URL"
    t.text "AssociationSecret"
    t.string "AssociationHashMethod", limit: 20
    t.string "AuthenticateUrl"
    t.string "RegisterUrl"
    t.string "SignInUrl"
    t.string "SignOutUrl"
    t.string "PasswordUrl"
    t.string "ProfileUrl"
    t.text "Attributes"
    t.integer "Active", limit: 1, default: 1, null: false
    t.integer "IsDefault", limit: 1, default: 0, null: false
    t.integer "Visible", limit: 1, default: 1, null: false
    t.index ["AuthenticationKey"], name: "UX_UserAuthenticationProvider", unique: true
  end

  create_table "GDN_UserAuthenticationToken", primary_key: ["Token", "ProviderKey"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "Token", limit: 128, null: false
    t.string "ProviderKey", limit: 50, null: false
    t.string "ForeignUserKey", limit: 100
    t.string "TokenSecret", limit: 64, null: false
    t.column "TokenType", "enum('request','access')", null: false
    t.integer "Authorized", limit: 1, null: false
    t.timestamp "Timestamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "Lifetime", null: false
    t.index ["Timestamp"], name: "IX_UserAuthenticationToken_Timestamp"
  end

  create_table "GDN_UserCategory", primary_key: ["UserID", "CategoryID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "UserID", null: false
    t.integer "CategoryID", null: false
    t.datetime "DateMarkedRead", precision: nil
    t.integer "Followed", limit: 1, default: 0, null: false
    t.integer "Unfollow", limit: 1, default: 0, null: false
  end

  create_table "GDN_UserComment", primary_key: ["UserID", "CommentID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "UserID", null: false
    t.integer "CommentID", null: false
    t.float "Score"
    t.datetime "DateLastViewed", precision: nil
  end

  create_table "GDN_UserConversation", primary_key: ["UserID", "ConversationID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "UserID", null: false
    t.integer "ConversationID", null: false
    t.integer "CountReadMessages", default: 0, null: false
    t.integer "LastMessageID"
    t.datetime "DateLastViewed", precision: nil
    t.datetime "DateCleared", precision: nil
    t.integer "Bookmarked", limit: 1, default: 0, null: false
    t.integer "Deleted", limit: 1, default: 0, null: false
    t.datetime "DateConversationUpdated", precision: nil
    t.index ["ConversationID"], name: "FK_UserConversation_ConversationID"
    t.index ["LastMessageID"], name: "FK_UserConversation_LastMessageID"
    t.index ["UserID", "Deleted", "DateConversationUpdated"], name: "IX_UserConversation_Inbox"
  end

  create_table "GDN_UserDiscussion", primary_key: ["UserID", "DiscussionID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "UserID", null: false
    t.integer "DiscussionID", null: false
    t.float "Score"
    t.integer "CountComments", default: 0, null: false
    t.datetime "DateLastViewed", precision: nil
    t.integer "Dismissed", limit: 1, default: 0, null: false
    t.integer "Bookmarked", limit: 1, default: 0, null: false
    t.integer "Participated", limit: 1, default: 0, null: false
    t.index ["DiscussionID"], name: "FK_UserDiscussion_DiscussionID"
    t.index ["UserID", "Bookmarked"], name: "IX_UserDiscussion_UserID_Bookmarked"
  end

  create_table "GDN_UserIP", primary_key: ["UserID", "IPAddress"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "UserID", null: false
    t.binary "IPAddress", limit: 16, null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.datetime "DateUpdated", precision: nil, null: false
  end

  create_table "GDN_UserMerge", primary_key: "MergeID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "OldUserID", null: false
    t.integer "NewUserID", null: false
    t.datetime "DateInserted", precision: nil, null: false
    t.integer "InsertUserID", null: false
    t.datetime "DateUpdated", precision: nil
    t.integer "UpdateUserID"
    t.text "Attributes"
    t.index ["NewUserID"], name: "FK_UserMerge_NewUserID"
    t.index ["OldUserID"], name: "FK_UserMerge_OldUserID"
  end

  create_table "GDN_UserMergeItem", id: false, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "MergeID", null: false
    t.string "Table", limit: 30, null: false
    t.string "Column", limit: 30, null: false
    t.integer "RecordID", null: false
    t.integer "OldUserID", null: false
    t.integer "NewUserID", null: false
    t.index ["MergeID"], name: "FK_UserMergeItem_MergeID"
  end

  create_table "GDN_UserMeta", primary_key: ["UserID", "Name"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "UserID", null: false
    t.string "Name", limit: 100, null: false
    t.text "Value"
    t.index ["Name"], name: "IX_UserMeta_Name"
  end

  create_table "GDN_UserPoints", primary_key: ["SlotType", "TimeSlot", "Source", "CategoryID", "UserID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.column "SlotType", "enum('d','w','m','y','a')", null: false
    t.datetime "TimeSlot", precision: nil, null: false
    t.string "Source", limit: 10, default: "Total", null: false
    t.integer "CategoryID", default: 0, null: false
    t.integer "UserID", null: false
    t.integer "Points", default: 0, null: false
  end

  create_table "GDN_UserRole", primary_key: ["UserID", "RoleID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "UserID", null: false
    t.integer "RoleID", null: false
    t.index ["RoleID"], name: "IX_UserRole_RoleID"
  end

  create_table "GDN_contentDraft", primary_key: "draftID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "recordType", limit: 64, null: false
    t.integer "recordID"
    t.integer "parentRecordID"
    t.text "attributes", size: :medium, null: false
    t.integer "insertUserID", null: false
    t.datetime "dateInserted", precision: nil, null: false
    t.integer "updateUserID", null: false
    t.datetime "dateUpdated", precision: nil, null: false
    t.index ["insertUserID"], name: "IX_contentDraft_insertUserID"
    t.index ["recordType", "parentRecordID"], name: "IX_contentDraft_parentRecord"
    t.index ["recordType", "recordID"], name: "IX_contentDraft_record"
    t.index ["recordType"], name: "IX_contentDraft_recordType"
  end

  create_table "GDN_dirtyRecord", primary_key: ["recordType", "recordID"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "recordType", limit: 50, null: false
    t.integer "recordID", null: false
    t.datetime "dateInserted", precision: nil, null: false
    t.index ["recordType", "dateInserted"], name: "IX_dirtyRecord_recordType"
  end

  create_table "GDN_roleRequest", primary_key: "roleRequestID", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.column "type", "enum('application','invitation')", null: false
    t.integer "roleID", null: false
    t.integer "userID", null: false
    t.column "status", "enum('pending','approved','denied')", null: false
    t.datetime "dateOfStatus", precision: nil, null: false
    t.integer "statusUserID", null: false
    t.binary "statusIPAddress", limit: 16
    t.datetime "dateExpires", precision: nil
    t.json "attributes"
    t.datetime "dateInserted", precision: nil, null: false
    t.integer "insertUserID", null: false
    t.binary "insertIPAddress", limit: 16
    t.datetime "dateUpdated", precision: nil
    t.integer "updateUserID"
    t.binary "updateIPAddress", limit: 16
    t.index ["roleID", "userID"], name: "UX_roleRequest", unique: true
    t.index ["userID"], name: "FK_roleRequest_userID"
  end

  create_table "GDN_roleRequestMeta", primary_key: ["roleID", "type"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "roleID", null: false
    t.column "type", "enum('application','invitation')", null: false
    t.string "name", limit: 150, null: false
    t.text "body", null: false
    t.string "format", limit: 10, null: false
    t.text "attributesSchema", null: false
    t.json "attributes"
    t.datetime "dateInserted", precision: nil, null: false
    t.integer "insertUserID", null: false
    t.binary "insertIPAddress", limit: 16
    t.datetime "dateUpdated", precision: nil
    t.integer "updateUserID"
    t.binary "updateIPAddress", limit: 16
  end

  create_table "GDN_userAttributes", primary_key: ["userID", "key"], charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "userID", null: false
    t.string "key", limit: 100, null: false
    t.json "attributes"
    t.index ["key"], name: "IX_userAttributes_key"
  end

end
