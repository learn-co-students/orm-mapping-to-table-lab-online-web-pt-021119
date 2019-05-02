class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES
    (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)

    isql = <<-SQL
    SELECT id from students where name = ? and grade = ?;
    SQL
    @id = DB[:conn].execute(isql, self.name, self.grade).flatten.first
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
