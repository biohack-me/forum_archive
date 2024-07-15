# biohack.me forum archive

[This application](https://forum.biohack.me) serves as a way to view a read-only archive of the biohack.me forums, formerly run on [Vanilla](https://open.vanillaforums.com/) from January 2011 to July 2024.

Once we decided to decommission these forums, it was agreed that an archive should be kept. However, keeping a copy of Vanilla running with posting disabled would still necessitate maintaining and upgrading Vanilla, which is overkill for an archive. And, making a flat HTML dump of the forum would make it so search would only work with external search engines.

So, I ([@tekniklr](https://github.com/tekniklr/)), decided to roll up a quick rails app to connect to the existing Vanilla database via a read-only connection.

If you had an account on the forums and are in the archive and wish to have either your posts anonymized or removed entirely, [email us and let us know](mailto:websiteadmins@biohack.me).


## Care and feeding

Patreon badges and shoutouts are handled via a [cron task](https://github.com/biohack-me/Patreon-patron-sync) that talks directly to the database - no Vanilla install required. These can continue operating despite the forum being a read-only archive.

When former forum users want their data updated, this may be possible directly in the database (e.g., with [phpMyAdmin](https://www.phpmyadmin.net/)).

If they previously had their email visible on their profile and want it hidden, this can be done with:
```mysql
update GDN_User set ShowEmail=1 where UserID=<id>;
```
Their email, in addition to potentially being shown on their profile, is also used to pull [gravatar](https://gravatar.com/) avatars so should not be nullified for a non-deleted user.

If they want to have their content removed they have two options:
1. Keep user content - Invalidate/anonymize the user account and anonymize their content (it will show as being authored by `[Deleted User]`).
```mysql
delete from GDN_UserAuthentication where UserID=<id>;
delete from GDN_UserRole where UserID=<id>;
delete from GDN_Invitation where InsertUserID=<id> or AcceptedUserID=<id>;
delete from GDN_Activity where InsertUserID=<id>;
delete from GDN_Log where RecordUserID=<id> and Operation='Pending';
delete from GDN_UserCategory where UserID=<id>;
delete from GDN_BadgeAward where UserID=<id>;
delete from GDN_UserPoints where UserID=<id>;
delete from GDN_Draft where InsertUserID=<id>;
update GDN_User set Name='[Deleted User]', Photo='', About='', Title='', Location='', Password=SUBSTRING(MD5(RAND()) FROM 1 FOR 16), HashMethod='Random', About='', Email=concat('user_',UserId,'@deleted.invalid'), ShowEmail='0', Gender='u', CountVisits=0, CountInvitations=0, CountNotifications=0, InviteUserID=null, DiscoveryText='', Preferences=null, Permissions=null, Attributes=null, DateSetInvitations=null, DateOfBirth=null, DateFirstVisit=null, DateLastActive=null, DateUpdated=SYSDATE(), InsertIPAddress=null, LastIPAddress=null, HourOffset='0', Score=null, Admin=0, Points=0, Deleted=1 where UserID=<id>;
```
2. Blank user content - Invalidate/anonymize the user account and negate their content with a message stating the user has been deleted (In addition to changing the content author to `[Deleted User]`, their discussion and comment content will be replaced with `The user and all related content has been deleted.`). This gives a visual cue that there is missing information.
```mysql
delete from GDN_UserAuthentication where UserID=<id>;
delete from GDN_UserRole where UserID=<id>;
delete from GDN_Invitation where InsertUserID=<id> or AcceptedUserID=<id>;
delete from GDN_Activity where InsertUserID=<id>;
delete from GDN_Log where RecordUserID=<id> and Operation='Pending';
delete from GDN_UserCategory where UserID=<id>;
delete from GDN_BadgeAward where UserID=<id>;
delete from GDN_UserPoints where UserID=<id>;
delete from GDN_Draft where InsertUserID=<id>;
delete from GDN_UserDiscussion where UserID=<id>;
update GDN_User set Name='[Deleted User]', Photo='', About='', Title='', Location='', Password=SUBSTRING(MD5(RAND()) FROM 1 FOR 16), HashMethod='Random', About='', Email=concat('user_',UserId,'@deleted.invalid'), ShowEmail='0', Gender='u', CountVisits=0, CountInvitations=0, CountNotifications=0, InviteUserID=null, DiscoveryText='', Preferences=null, Permissions=null, Attributes=null, DateSetInvitations=null, DateOfBirth=null, DateFirstVisit=null, DateLastActive=null, DateUpdated=SYSDATE(), InsertIPAddress=null, LastIPAddress=null, HourOffset='0', Score=null, Admin=0, Points=0, Deleted=1, CountDiscussions=0, CountUnreadDiscussions=0, CountComments=0, CountDrafts=0, CountBookmarks=0 where UserID=<id>;
update GDN_Discussion set Body="The user and all related content has been deleted.", Format="Deleted" where InsertUserID=<id>;
update GDN_Comment set Body="The user and all related content has been deleted.", Format="Deleted" where InsertUserID=<id>;
```
**DO NOT** simply delete user data from the `GDN_User` table as this does not actually remove very much of their data or content, and may cause unexpected behavior in the archive.

Obviously, if other users mention a deleted user by name or quote their content in their own comments, this will remain.

See the Vanilla source code([1](https://github.com/vanilla/vanilla/blob/2a966a61d9acd6dfdfc78510b4f2387b36756649/applications/dashboard/models/class.usermodel.php#L5325-L5464),[2](https://github.com/vanilla/vanilla/blob/2a966a61d9acd6dfdfc78510b4f2387b36756649/applications/vanilla/settings/class.hooks.php#L128-L256)) for more details on how vanilla handled deleting users, which is what the SQL above is based on.


## Development

You will need ruby and MySQL set up on your local development machine.

After cloning this repository, run:
```bash
gem install bundler
bundle install
```

Create new `config/master.key` and `config/credentials.yml.enc` files:
```bash
bundle exec rails secret | cut -c-32 > config/master.key
EDITOR=vim rails credentials:edit
```

Copy the provided `config/database.yml.example` file to `config/database.yml` and set a database password you will use in the MySQL setup below.

Then, set up a development database:
```bash
mysql -u root -p
```
and in the MySQL console, using the password you set in `config/database.yml`, above:
```mysql
create database biohackme_vanilla;
create database biohackme_vanilla_test;
create user 'biohackme' identified by '<password>';
grant all privileges on biohackme_vanilla.* to 'biohackme';
grant all privileges on biohackme_vanilla_test.* to 'biohackme';
```
(local development will need all database privileges to set up the database; in production only `select` is needed)

If you have access to a `.sql` dump of the production forum database (e.g., you have access to our backups), you can now populate your development database (it will prompt you for the password you set up above):
```bash
mysql -u biohackme -p biohackme_vanilla < vanilla.sql
```
Otherwise, you can now set it up with the provided schema and seed data:
```bash
rails db:schema:load
rails db:seed
```

If all went well, you can run our (minimal) tests with:
```bash
rails db:test:prepare
rails test
```
And start up a local server with:
```bash
rails s
```
The development site should now be available at http://localhost:3000.


## Deploying

If you are part of the team that has access to deploy this to the web, you will have to set up github to accept changes from your computer by [adding a public SSH key](https://github.com/settings/keys).

You should also SSH to the server and add your public SSH key to the `.ssh/authorized_keys` file.

Then, after pushing your changes to github, all you have to do is run:
```bash
cap production deploy
```
from your local machine.


## Contributing

1. Fork this repository
2. Clone your forked repository
3. Commit your changes
4. Open a pull request


## Credits

When no uploaded user avatar or gravatar was available, user avatars are generated using [DiceBear's Bottts](https://www.dicebear.com/styles/bottts/), which is licensed free for personal and commercial use.