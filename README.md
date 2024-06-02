# biohack.me forum archive

This application serves as a way to view a read-only archive of the biohack.me forums, formerly run on [Vanilla](https://open.vanillaforums.com/) from January 2011 to June 2024.

Once we decided to decommission these forums, it was agreed that an archive should be kept. However, keeping a copy of Vanilla running with posting disabled would still necessitate maintaining and upgrading Vanilla, which is overkill for an archive. And, making a flat HTML dump of the forum would make it so search would only work with external search engines.

So, I (@tekniklr), decided to roll up a quick rails app to connect to the existing Vanilla database via a read-only connection.


## Care and feeding

Patreon badges and shoutouts are handled via a [cron task](https://github.com/biohack-me/Patreon-patron-sync) that talks directly to the database - no Vanilla install required. These can continue operating despite the forum being a read-only archive.

If a forum user wants to have their data removed this can be done directly in the database (e.g., with [phpMyAdmin](https://www.phpmyadmin.net/)). There are two ways to do it - delete the user and everything they've posted, or delete the user and anonymize their content (it will show as being authored by `[Deleted User]``).

Obviously, if other users mention a deleted user by name or quote their content in their own comments, this will remain.


### Delete user and all their data

TODO


### Delete user and anonymize their data

TODO


## To-do

- Documentation
  - Add SQL for deleting users and anonymizing user data


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
Add database connection info to the credentials file this opens, with a password you will use in the MySQL setup below:
```
database:
  development:
    password: '<password>'
  test:
    password: '<password>'
```

Then, set up a development database:
```bash
mysql -u root -p
```
and in the MySQL console, using the password from the `credentials.yml.enc` file, above:
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


## Contributing

1. Fork this repository
2. Clone your forked repository
3. Commit your changes
4. Open a pull request