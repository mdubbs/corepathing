class Student
  attr_accessor :name
  attr_accessor :max_domain_levels
  attr_accessor :path

  def initialize(name, max_domain_grade_levels, education_path)
    @name = name
    @max_domain_levels = max_domain_grade_levels
    @path = education_path
  end

  def to_s
    z = @path.map{|p| p.map{|k,v| "#{k}.#{v}"} }.join(',')
    return "#{@name},#{z}"
  end
end