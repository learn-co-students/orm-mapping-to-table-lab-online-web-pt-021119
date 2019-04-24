class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    #creates student table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        grade TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    #drops table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    #saves to the database
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM students").flatten[0]
  end

  def self.create (name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end
