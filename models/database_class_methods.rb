require "active_support"
require "active_support/inflector"

# This module will be **extended** in all of my classes. It contains methods
# that will become **class** methods for the class.

module DatabaseClassMethods  
  
  # Adds a new record to the database.
  #
  #
  # Return an Integer of ID of inserted row.
  def add_to_database(options={})
    table_name = self.to_s.pluralize.underscore

    column_names = options.keys
    column_names_for_sql = column_names.join(", ")

    values = options.values
    individual_values_for_sql = []

    values.each do |value|
      if value.is_a?(String)
        individual_values_for_sql << "'#{value}'"
      else
        individual_values_for_sql << value
      end
    end
    values_for_sql = individual_values_for_sql.join(", ")
    CONNECTION.execute("INSERT INTO #{table_name} (#{column_names_for_sql}) VALUES (#{values_for_sql});")
    CONNECTION.last_insert_row_id
  end
  
  

  # def add(arguments={})
  #   columns_array = arguments.keys
  #   values_array = arguments.values
  #   columns_for_sql = columns_array.join(", ")
  #   ind_values_for_sql = []
  #
  #   values_array.each do |item|
  #     if item.is_a?(String)
  #       ind_values_for_sql << "'#{item}'"
  #     else
  #       ind_values_for_sql << item
  #     end
  #   end
  #
  #   values_for_sql = ind_values_for_sql.join(", ")
  #   CONNECTION.execute("INSERT INTO #{get_table_name} (#{columns_for_sql}) VALUES (#{values_for_sql});")
  #   arguments["id"] = CONNECTION.last_insert_row_id
  #   self.new(arguments)
  # end
  
  
  # Get a single row.
  #
  # record_id - The record's Integer ID.
  #
  # Returns an Array containing the Hash of the row.
  def find(record_id)    
    # Figure out the table's name from the class we're calling the method on.
    table_name = self.to_s.pluralize.underscore
    results = CONNECTION.execute("SELECT * FROM #{table_name} WHERE id = #{record_id}").first
    self.new(results)
  end
  
  
  
  # Get all of the rows for a table.
  #
  # Returns an Array containing objects for each row.
  def all
    # Figure out the table's name from the class we're calling the method on.
    table_name = self.to_s.pluralize.underscore
    
    results = CONNECTION.execute("SELECT * FROM #{table_name}")
    # TODO put these lines back in and create another method to turn results_as_objects array of 
    #      objects in to array of hashes!!!!!!!
    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << self.new(result_hash)
    end
    return results_as_objects
  end

  
  
end










