class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
   @id = id
   @name = name
   @grade = grade
 end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create(student_hash)
    student_hash.each do |s|
      binding.pry
      Student.new(name: s.name, grade: s.grade)
      student.save
    end
  end

end
