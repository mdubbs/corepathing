require "corepathing/version"
require 'csv'

module Corepathing
  class Pathing
    require 'Student'
    ##
    # Creates a new learning path object from the given domain_ordering and
    # student_tests CSV files
    #
    def initialize(student_tests, domain_order)
      # load up the CSV files and parse
      @STUDENT_TESTS = CSV.read(student_tests, headers: true)
      @DOMAIN_ORDER = CSV.read(domain_order, headers: false)
    end

    def path_students(limit = nil)
      # generate each student's learning path and return an array of the
      # students found in the student csv.
      ret = []
      if limit.nil?
        limit = 5
      end
      # iterate through the students
      @STUDENT_TESTS.each do |x|
        ret.push(get_path(x, limit))
      end
      ret
    end

    def get_path(student_test_score_row, limit = nil)
      # calculate the path for a given student, and return the number of steps
      # desired.

      # grab the students name
      current_student_name = student_test_score_row[0]
      # init some data structures
      student_max_grade_levels = {}
      student_path = []
      students = []

      if limit.nil?
        limit = 5
      end

      # iterate through the students excluding the header row
      student_test_score_row.to_a[1..-1].each do |domain, grade_level|
        # set the max levels for each domain
        student_max_grade_levels[domain] = grade_level
      end

      # iterate through the domain ordering file
      @DOMAIN_ORDER.each do |domain_row|

        path_obj = {}
        # get the current row's level (grade) we are on

        domain_row_grade_level = domain_row[0]
        # iterate through the level's ordering (Right -> Left)

        domain_row[1..-1].each do |commone_core_domain|

          # grab the max grade level for the given cc domain (RF, RI, etc)
          student_max_domain_grade_level = student_max_grade_levels[commone_core_domain]

          #if the current level is K and max isn't, ignore it
          if domain_row_grade_level == "K" && student_max_domain_grade_level != "K"
            #don't add it
          elsif domain_row_grade_level == student_max_domain_grade_level
            #if the levels match add it
            student_path.push({domain_row_grade_level => commone_core_domain })
          else
            if student_max_domain_grade_level < domain_row_grade_level
              student_path.push({domain_row_grade_level => commone_core_domain })
            elsif student_max_domain_grade_level == "K"
              student_path.push({domain_row_grade_level => commone_core_domain })
            end
          end
        end

      end
      student = Student.new(current_student_name, student_max_grade_levels, student_path[0...limit])

      # return formatted string based on passed limit
      return student
    end
  end
end