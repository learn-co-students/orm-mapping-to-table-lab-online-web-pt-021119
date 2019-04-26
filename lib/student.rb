class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade)
    @id = id
    @name = name
    @grade = grade

  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql =  <<-SQL
      DROP TABLE students;
        SQL
    DB[:conn].execute(sql)
  end

  def save
      sql = <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.grade)
      student = DB[:conn].execute("SELECT * FROM students WHERE name = ?", self.name)
      @id = student.flatten[0]

    end

  def self.create (name:, grade:)
    #takes in a hash of attributes and uses metaprogramming to create a new student object.
    #Then it uses the #save method to save that student to the database.
    #then it returns the new object that it instantiated



    student = Student.new(name, grade)
    student.save
    student


  end

end
