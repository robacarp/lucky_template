# Lucky Template

This is a project template for projects using:

- [Lucky](https://luckyframework.org) v0.29
- [Tailwind CSS](https://tailwindcss.com/) v3.0
- [Mosquito Jobs](https://mosquito-cr.github.io/) v1.0

## Features

- User registration/logins/forgot passwords.
- Admin portal.
- Admin "sudo" mode, to view or act as a user.

## Setting up your project

1. Clone this template
1. Install dependencies: `shards install` and then `yarn install`
1. Find and replace all of "my_lucky_app" with your name:
  - `ag my_lucky_app` to find them in file contents.
  - `find ./ -type f -exec sed -i -e 's/my_lucky_app/real_app_name/g' {} \;` if you're willing.
  - Don't forget about renaming the app_root: `find . -iname 'my_lucky_app*'`.
1. Migrate the database: `lucky db.setup`
1. Run `lucky dev` to start the app.
1. Visit [http://localhost:3001](http://localhost:3001)
