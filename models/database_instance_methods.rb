require "active_support"
require "active_support/inflector"

# This module will be **included** in all of my classes. It contains methods
# that will become **instance** methods in the class.

module DatabaseInstanceMethods
  
  # Get the value of a field for a given row.
  #
  # field - String of the column name.
  #
  # Returns the String value of the cell in the table.
  def get(id)
    # Figure out the table's name from the object we're calling the method on.
    table_name = self.class.to_s.pluralize.underscore
    
    # Get the first/only row as a Hash.
    result = CONNECTION.execute("SELECT * FROM #{table_name} WHERE id = #{@id}").first
    
    # Return only the value for the key of the field we're seeking.
    result[field]
  end 
  

  
  # deletes a record from the db
  def delete
    table_name = self.class.to_s.pluralize.underscore
    CONNECTION.execute("DELETE FROM #{table_name} WHERE id = #{@id};")    
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