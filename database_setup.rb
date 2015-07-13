# Load/create our database for this program.
# This is the tunnel to the db
CONNECTION = SQLite3::Database.new("assignments.db")

# Make the tables, if they don't already exist.
CONNECTION.execute("CREATE TABLE IF NOT EXISTS assignments (id INTEGER PRIMARY KEY, title TEXT, description TEXT, github_link TEXT, completed BOOLEAN);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS resources (id INTEGER PRIMARY KEY, title TEXT, resource_link TEXT, type TEXT, assignment_id INTEGER, FOREIGN KEY (assignment_id) REFERENCES assignments(id));")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS collaborators (id INTEGER PRIMARY KEY, name TEXT, assignment_id INTEGER, FOREIGN KEY (assignment_id) REFERENCES assignments(id));")

# Get results as an Array of Hashes.
CONNECTION.results_as_hash = true
