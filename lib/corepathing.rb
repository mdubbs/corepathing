require "corepathing/version"
require 'csv'

module Corepathing
  # Class for Student object
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
      education_path_string = @path.map{|p| p.map{|k,v| "#{k}.#{v}"} }.join(',')
      return "#{@name},#{education_path_string}"
    end
  end

  class Pathing
    # Creates a new learning path object from the given domain_ordering and
    # student_tests CSV files
    def initialize(student_tests, domain_order)
      # load up the CSV files and parse
      @STUDENT_TEST_SCORE_FILE = CSV.read(student_tests, headers: true)
      @DOMAIN_ORDER_FILE = CSV.read(domain_order, headers: false)
    end

    def path_students(limit = nil)
      # generate each student's learning path and return an array of
      # student objects
      return_array = []

      #default limit to 5
      if limit.nil?
        limit = 5
      end
      # iterate through the students
      @STUDENT_TEST_SCORE_FILE.each do |x|
        return_array.push(get_path(x, limit))
      end
      return_array
    end

    def get_path(student_test_score_row, limit = nil)
      # calculate the path for a given student, and return the number of steps
      # desired.
      current_student_name = student_test_score_row[0]

      student_max_grade_levels = {}
      student_path = []
      students = []

      # default limit to 5
      if limit.nil?
        limit = 5
      end

      # iterate through the students excluding the header row
      student_test_score_row.to_a[1..-1].each do |domain, grade_level|
        # set the max levels for each domain
        student_max_grade_levels[domain] = grade_level
      end

      # iterate through the domain ordering file
      @DOMAIN_ORDER_FILE.each do |domain_row|
        path_obj = {}

        # get the current row's level (grade) we are on
        domain_row_grade_level = domain_row[0]

        # iterate through the level's ordering (Right -> Left)
        domain_row[1..-1].each do |commone_core_domain|

          # grab the max grade level for the given cc domain (RF, RI, etc)
          max_domain_grade_level = student_max_grade_levels[commone_core_domain]

          #if the current level is K and max isn't, ignore it
          if domain_row_grade_level == "K" && max_domain_grade_level != "K"
            #don't add it
          elsif domain_row_grade_level == max_domain_grade_level
            #if the levels match add it
            student_path.push({domain_row_grade_level => commone_core_domain })
          else
            if max_domain_grade_level < domain_row_grade_level
              student_path.push({domain_row_grade_level => commone_core_domain })
            elsif max_domain_grade_level == "K"
              student_path.push({domain_row_grade_level => commone_core_domain })
            end
          end
        end

      end
      student = Student.new(current_student_name, student_max_grade_levels, student_path[0...limit])

      return student
    end
  end
end