class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name,grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table

    create_table_sql = "
    CREATE TABLE students (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT,
      grade TEXT
      );"
    DB[:conn].execute(create_table_sql)
  end 

  def self.drop_table
    drop_table_sql = "DROP TABLE students;"
    DB[:conn].execute(drop_table_sql)
  end

  def save
    save_student_sql = "INSERT INTO students (name, grade) VALUES (?,?)"
    DB[:conn].execute(save_student_sql, self.name, self.grade)
    id_lookup_sql = "SELECT id FROM students WHERE name = ? AND grade = ?"
    @id = DB[:conn].execute(id_lookup_sql, self.name, self.grade).flatten[0]
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end

end
