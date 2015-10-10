require "too_done/version"
require "too_done/init_db"
require "too_done/user"
require "too_done/session"
require "too_done/list"
require "too_done/item"

require "thor"
require "pry"

module TooDone
  class App < Thor

    desc "add 'TASK'", "Add a TASK to a todo list."
    option :list, :aliases => :l, :default => "*default*",
      :desc => "The todo list which the task will be filed under."
    option :date, :aliases => :d,
      :desc => "A Due Date in YYYY-MM-DD format."
    def add(task)
      user = current_user
      # find or create the right todo list
      list = List.find_or_create_by(name: options[:list], user_id: user.id)
      # create a new item under that list, with optional date
      list.items.create(list_id: list.id, task: task, is_completed: false, due_date: options[:date])
      puts "Task #{task} has been added to #{list.name}."
    end

    desc "edit", "Edit a task from a todo list."
    option :list, :aliases => :l, :default => "*default*",
      :desc => "The todo list whose tasks will be edited."
    def edit
      user = current_user
      # find the right todo list
      list = List.find_by name: options[:list]
      # BAIL if it doesn't exist and have tasks
      if list == nil
        puts "That list does not exist."
      elsif list.items.empty?
        puts "That list has no items."
      # display the tasks and prompt for which one to edit
      else
        puts  "ID - Task - Due Date - Is Completed?"
        list.items.each do |item|
          puts "#{item.id}: #{item.task} - #{item.due_date} - #{item.is_completed}"
        end

        puts "Choose the ID of the task you want to edit."
        id = STDIN.gets.chomp.to_i
        
        until list.items.map(&:id).include?(id)
          puts "Make sure you select one of the IDs above."
          id = STDIN.gets.chomp.to_i
        end    
        item = Item.find(id)
        # allow the user to change the title, due date

        puts "Type a new name instead of #{item.task}: "
        task = STDIN.gets.chomp
        puts "Type a new date for the task: YYYY-MM-DD"
        due_date = STDIN.gets.chomp
        item.update(task: task, due_date: due_date)
        puts "Task item #{item.id} is now called:"
        puts "#{item.task} and is due on #{item.due_date}."
      end

    end

    desc "done", "Mark a task as completed."
    option :list, :aliases => :l, :default => "*default*",
      :desc => "The todo list whose tasks will be completed."
    def done

      # find the right todo list
      list = List.find_by name: options[:list]
      # BAIL if it doesn't exist and have tasks
      
      if list == nil
        puts "That list does not exist."
      elsif list.items.empty?
        puts "That list has no items."
      else
        # display the tasks and prompt for which one(s?) to mark done
        puts "ID - Task - Is Completed?"
        list.items.each do |item|
          puts "#{item.id}: #{item.task} - #{item.due_date}" if !item.is_completed?
        end
        puts "Type the ID of the task to mark completed."
        id = STDIN.gets.chomp.to_i

        until list.items.map{ |i| i.id if !i.is_completed? }.include?(id)
          puts "Make sure to select one of the IDs above."
          id = STDIN.gets.chomp.to_i
        end          
        item = Item.find(id)
        item.update(is_completed: true)
        puts "Task item #{item.id} has been marked as completed. #{item.is_completed}"
      end
    end

    desc "show", "Show the tasks on a todo list in reverse order."
    option :list, :aliases => :l, :default => "*default*",
      :desc => "The todo list whose tasks will be shown."
    option :completed, :aliases => :c, :default => false, :type => :boolean,
      :desc => "Whether or not to show already completed tasks."
    option :sort, :aliases => :s, :enum => ['history', 'overdue'],
      :desc => "Sorting by 'history' (chronological) or 'overdue'.
      \t\t\t\t\tLimits results to those with a due date."
    def show
      # find or create the right todo list
      list = List.find_by name: options[:list]
      # show the tasks ordered as requested, default to reverse order (recently entered first)
      if options[:sort] == "history"
        order = "created_at ASC"
        items = Item.where("due_date NOT ?", nil)
      elsif options[:sort] == "overdue"
        order = "due_date DESC"
        items = Item.where("due_date < ?", Time.now)
      else
        order = "created_at DESC"
        items = Item.where("due_date NOT ? AND list_id = ? AND is_completed = ?", nil, list.id, options[:completed])
      end
      items = items.order(order)
      puts "++ Task ======= Due Date ======== Is Completed === List Name ++"
      items.each do |i|
        puts "#{i.task} - #{i.due_date} - #{i.is_completed} - #{list.name}"
      end
      #list.items.each do 
    end

    desc "delete [LIST OR USER]", "Delete a todo list or a user."
    option :list, :aliases => :l, :default => "*default*",
      :desc => "The todo list which will be deleted (including items)."
    option :user, :aliases => :u,
      :desc => "The user which will be deleted (including lists and items)."
    def delete
      # BAIL if both list and user options are provided
      # BAIL if neither list or user option is provided
      # find the matching user or list
      # BAIL if the user or list couldn't be found
      # delete them (and any dependents)
    end

    desc "switch USER", "Switch session to manage USER's todo lists."
    def switch(username)
      user = User.find_or_create_by(name: username)
      user.sessions.create
    end

    private
    def current_user
      Session.last.user
    end
  end
end

#binding.pry
TooDone::App.start(ARGV)
