require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class Resource  
  attr_reader :id
  attr_accessor :resource_link, :title, :assignment_id, :type

  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  # Initializes a new User object
  #
  # options - hash contianing
  #   - id          - int (primary key)
  #   - user_name   - string
  #
  # Example:
  #   Movie.new({"id" => 4, "user_name" => "David Gardetti"})
  #
  # Returns a User object
  def initialize(options = {})
    @id = options["id"]
    @resource_link = options["resource_link"]
    @title = options["title"]
    @assignment_id = options["assignment_id"]
    @type = options["type"]
  end    
  

  # Adds a *new* row to the "users" table, using this object's attribute values.
  #
  # Calls 'add_to_database' in class Module to do database work
  # Returns the Integer ID that the database sends back.
  def self.add(options={})
    if options["title"].blank? 
      return false
    else
      self.add_to_database(options)
    end
  end
  
  
  # Updates the database with all values for the user.
  #
  # Returns an empty Array. TODO - This should return something better.
  def save
    if self.valid?
      return false
    else
      CONNECTION.execute("UPDATE assignments SET description = '#{@description}', title = '#{@title}', github_link = '#{@github_link}', completed = '#{@completed}' WHERE id = #{@id};")
    end
  end
  
  def valid?
    self.title.blank?
    self.description.blank?
  end
    
  
  
end