class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name:, grade:, id: nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    <<-SQL
    "CREATE TABLE IF NOT EXIST students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
    "
    SQL
  end

  def self.drop_table
  end

  def save
    <<-SQL
    "INSERT INTO students (name, grade) VALUES (?,?), self.name, self.grade
    "
    SQL
  end

  def self.create(name:, grade:)
    student = Student.new(name: name, grade: grade)
    student.save
    student
  end

end
