namespace :archive do

  # inspired by https://stackoverflow.com/a/44820356/433189
  desc "Generate a fresh db/seeds.rb file using selected data dumped from the vanilla database and some data spoofed entirely"
  task :generate_seeds => :environment do
    STDOUT.sync = true
    start_time = Time.now.clone
    seedfile = File.open('db/seeds.rb', 'w')
    require 'faker'

    # Users - only needed fields, anonymized
    puts "\nUsers..."
    usercount = 0
    seedfile.write "\n\n\n###### Users...\n"
    attributes = ['UserID', 'DateInserted', 'CountBadges', 'CountVisits', 'DateLastActive', 'Points', 'ShowEmail'] # copied verbatum; anonymized data individually set, below
    users = User.all
    users.each do |u|
      usercount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = u[attr].to_s
      end
      create_attributes['Name']     = Faker::Name.unique.name
      create_attributes['About']    = Faker::Lorem.sentence(word_count: 6)
      create_attributes['Password'] = SecureRandom.hex(8)
      create_attributes['Email']    = "#{SecureRandom.hex(3)}@biohack.me"
      seedfile.write "User.create(#{create_attributes})\n"
    end
    puts "\n dumped #{usercount} anonymized users"

    # UserMeta
    puts "\nUserMeta..."
    metacount = 0
    seedfile.write "\n\n\n###### UserMeta...\n"
    attributes = ['UserID']  # copied verbatum; anonymized data individually set, below
    user_ids = User.all.collect(&:UserID)
    user_ids.each do |id|
      metacount += 1
      print '.'
      create_attributes = {}
      create_attributes['UserID'] = id
      create_attributes['Name'] = 'Profile.Pronouns'
      create_attributes['Value'] = ['he him his', 'she her hers', 'they them theirs', 'it it its'].sample
      seedfile.write "UserMeta.create(#{create_attributes})\n"
    end
    puts "\n dumped #{metacount} user metadata"

    # Roles
    puts "\nRoles..."
    rolecount = 0
    seedfile.write "\n\n\n###### Badges...\n"
    attributes = ['RoleID', 'Name', 'Description']
    roles = Role.all
    roles.each do |r|
      rolecount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = r[attr].to_s
      end
      seedfile.write "Role.create(#{create_attributes})\n"
    end
    puts "\n dumped #{rolecount} roles"

    # UserRoles
    puts "\nUserRoles..."
    userrolecount = 0
    seedfile.write "\n\n\n###### UserRoles...\n"
    attributes = ['UserID', 'RoleID']
    urs = UserRole.all
    urs.each do |ur|
      userrolecount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = ur[attr].to_s
      end
      seedfile.write "UserRole.create(#{create_attributes})\n"
    end
    puts "\n dumped #{userrolecount} userroles"

    # Badges
    puts "\nBadges..."
    badgecount = 0
    seedfile.write "\n\n\n###### Badges...\n"
    attributes = ['BadgeID', 'Name', 'RuleClass', 'Description', 'Photo']
    badges = Badge.all
    badges.each do |b|
      badgecount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = b[attr].to_s
      end
      seedfile.write "Badge.create(#{create_attributes})\n"
    end
    puts "\n dumped #{badgecount} badges"

    # UserBadges
    puts "\nUserBadges..."
    userbadgecount = 0
    seedfile.write "\n\n\n###### UserBadges...\n"
    attributes = ['BadgeAwardID', 'BadgeID', 'UserID', 'DateInserted']
    ubs = UserBadge.all
    ubs.each do |ub|
      userbadgecount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = ub[attr].to_s
      end
      seedfile.write "UserBadge.create(#{create_attributes})\n"
    end
    puts "\n dumped #{userbadgecount} userbadges"

    # Categories
    puts "\nCategories..."
    catcount = 0
    seedfile.write "\n\n\n###### Categories...\n"
    attributes = ['CategoryID', 'ParentCategoryID', 'InsertUserID', 'DateInserted', 'DateUpdated', 'CountAllDiscussions', 'CountComments', 'Name', 'Description', 'Depth', 'Sort'] # copied verbatum; anonymized data individualized, below
    categories = Category.all
    categories.each do |c|
      catcount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = c[attr].to_s
      end
      seedfile.write "Category.create(#{create_attributes})\n"
    end
    puts "\n dumped #{catcount} categories"

    # Discussions
    puts "\nDiscussions..."
    disscount = 0
    seedfile.write "\n\n\n###### Discussions...\n"
    attributes = ['DiscussionID', 'CategoryID', 'InsertUserID', 'DateInserted', 'DateUpdated', 'Announce', 'Closed', 'CountViews', 'CountComments', 'DateLastComment', 'LastCommentUserID', 'Tags'] # copied verbatum; anonymized data individualized, below
    discussions = Discussion.all
    discussions.each do |d|
      disscount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = d[attr].to_s
      end
      create_attributes['Name']   = Faker::Lorem.sentence(word_count: 4)
      create_attributes['Body']   = Faker::Lorem.paragraph(sentence_count: 6)
      create_attributes['Format'] = 'TextEx'
      seedfile.write "Discussion.create(#{create_attributes})\n"
    end
    puts "\n dumped #{disscount} anonymized discussions"

    # Comments
    puts "\nComments..."
    commcount = 0
    seedfile.write "\n\n\n###### Comments...\n"
    attributes = ['CommentID', 'DiscussionID', 'InsertUserID', 'DateInserted', 'DateUpdated'] # copied verbatum; anonymized data individualized, below
    comments = Comment.all
    comments.each do |c|
      commcount += 1
      print '.'
      create_attributes = {}
      attributes.each do |attr|
        create_attributes[attr] = c[attr].to_s
      end
      create_attributes['Body']   = Faker::Lorem.paragraph(sentence_count: 8)
      create_attributes['Format'] = 'TextEx'
      seedfile.write "Comment.create(#{create_attributes})\n"
    end
    puts "\n dumped #{commcount} anonymized comments"

    seedfile.close
    puts "\nFinished writing #{seedfile.path}"
    end_time = Time.now.clone
    elapsed_seconds = (end_time-start_time).to_i
    elapsed_minutes = (elapsed_seconds/60).to_i
    elapsed_hours   = (elapsed_minutes/60).to_i
    puts "\nTime elapsed: #{elapsed_hours} hours, #{elapsed_minutes % 60} minutes, #{elapsed_seconds % 60} seconds"
  end

end