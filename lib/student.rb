class Student
  attr_accessor :id, :name, :grade
  #has an id, name, grade

  def self.new_from_db(row)
  new_student = self.new  # self.new is the same as running students.new
  new_student.id = row[0]
  new_student.name =  row[1]
  new_student.grade = row[2]
  new_student  # return the newly created instance
end
#creates an instance with corresponding attribute values
  # create a new Student object given a row from the database

  def self.all # returns all student instances from the db
    sql = <<-SQL
      SELECT *
      FROM students
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row) # iterate over each row and use the
                            #.....self.new_from_db method to create a
                            #....new Ruby object for each row
  end
end
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class


  def self.find_by_name(name)
    sql = <<-SQL
     SELECT *
     FROM students
     WHERE name = ?
     LIMIT 1
   SQL

   DB[:conn].execute(sql, name).map do |row|
     self.new_from_db(row)
   end.first
    # find the student in the database given a name
    # returns an instance of student that matches the name from the DB
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  #saves an instance of the Student class to the database

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end
  #creates a student table

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  #drops the student table

  def self.all_students_in_grade_9
    sql = <<-SQL
    SELECT *
    FROM students
    WHERE grade = 9
    LIMIT 1;

    SQL

      DB[:conn].execute(sql)
  end
  #returns an array of all students in grades 9

  def self.students_below_12th_grade
    sql = <<-SQL
    SELECT *
    FROM students
    WHERE grade < 12;

    SQL
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
  end
end
# ' < ' below, ' > ' above
#returns an array of all students in grades 11 or below

  def self.first_X_students_in_grade_10(name)
    sql = <<-SQL
    SELECT *
    FROM students
    WHERE grade = 10
    LIMIT 2;
    SQL

    DB[:conn].execute(sql)
  end
  #returns an array of the first X students in grade 10

  def self.first_student_in_grade_10
    sql = <<-SQL
    SELECT *
    FROM students
    WHERE grade = 10
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
  end.first
  end
  #  returns the first student in grade 10

  def self.all_students_in_grade_X(name)
    sql = <<-SQL
    SELECT *
    FROM students
    WHERE grade
    LIMIT 3;

    SQL

    DB[:conn].execute(sql)
  end
#returns an array of all students in a given grade X

end
