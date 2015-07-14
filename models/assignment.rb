require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class Assignment  
  attr_reader :id
  attr_accessor :description, :title, :github_link, :completed

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
    @description = options["description"]
    @title = options["title"]
    @github_link = options["github_link"]
    @completed = options["completed"]
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
  
  def self.get_resources(id)
    results = CONNECTION.execute("SELECT * FROM resources WHERE assignment_id = #{id};")
    return results
  end 
  
  def make_hash
    variables = self.instance_variables
    attr_hash = {}
    
    variables.each do |var|
      attr_hash["#{var.slice(1..-1)}"] = self.send("#{var.slice(1..-1)}")
    end
    
    attr_hash
  end
  
end