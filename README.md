# TooDone

TooDone is a CLI based to-do-list app I built at The Iron Yard Academy. 

It uses Thor gem as the main mechanism for interacting through the CLI.

## Objectives

### Learning Objectives

* Understand basic database modeling and associations
* Understand how to create, delete, and query models
* Understand how to write migrations to update the schema
* Understand how to use models in a larger application

### Performance Objectives

* Use `belongs_to` and `has_many` associations competently
* Use ActiveRecord to manage the database schema and models
* Use modules to avoid polluting ruby's global namespace

## Functionality

Migrations, models, and associations for:

   * Users
   * Todo Lists
   * Tasks

Features:

1. You can show completed todo items.
2. You can sort to show overdue todo items or reverse chronological order.
3. When lists are deleted, all todo items should also be deleted.
4. When accounts are deleted, their lists and items should be deleted.

## Usage

You can run the app with `bundle exec ruby lib/too_dead.rb SUBCOMMAND ARGS` but since that is so verbose, you might want to add a shell alias to make your life easier.

Shell aliases are just shorthand for longer commands. Writing

`alias tasks="bundle exec ruby lib/too_done.rb"`

would allow you to run the app with tasks SUBCOMMAND ARGS which is much more convenient.

### Available Subcommands

```
  too_done.rb add 'TASK'             # Add a TASK to a todo list.
  too_done.rb delete [LIST OR USER]  # Delete a todo list or a user.
  too_done.rb done                   # Mark a task as completed.
  too_done.rb edit                   # Edit a task from a todo list.
  too_done.rb help [COMMAND]         # Describe available commands or one specific command
  too_done.rb show                   # Show the tasks on a todo list in reverse order.
  too_done.rb switch USER            # Switch session to manage USER's todo lists.
```
