require "corepathing/version"
require 'csv'
module Corepathing
  class Pathing
    ##
    # Creates a new learning path object from the given domain_ordering and
    # student_tests CSV files
    #
    def initialize(student_tests, domain_order)
      # load up the CSV files and parse
      @STUDENT_TESTS = CSV.read(student_tests, headers: true)
      @DOMAIN_ORDER = CSV.read(domain_order, headers: false)
    end

    def path_students(limit)
      # generate each student's learning path and return an array of the
      # students found in the student csv.
      ret = []
      # iterate through the students
      @STUDENT_TESTS.each do |x|
        ret.push(get_path(x, limit))
      end
      ret
    end

    def get_path(student_row, limit)
      # calculate the path for a given student, and return the number of steps
      # desired.

      # grab the students name
      name = student_row[0]
      # init some data structures
      current_levels = {}
      path = []

      # iterate through the students excluding the header row
      student_row.to_a[1..-1].each do |domain, level|
        # set the max levels for each domain
        current_levels[domain] = level
      end

      # iterate through the domain ordering file
      @DOMAIN_ORDER.each do |r|
        # get the current row's level (grade) we are on
        r_level = r[0]
        # iterate through the level's ordering (R -> L)
        r[1..-1].each do |r_domain|
          # grab the max level for the given domain (RF, RI, etc)
          max_level = current_levels[r_domain]

          if r_level == "K" && max_level != "K" #if the current level is K and max isn't, ignore it
          elsif r_level == max_level
            #if the levels match add it
            path.push("#{r_level}.#{r_domain}")
          else
            if max_level < r_level
              path.push("#{r_level}.#{r_domain}")
            elsif max_level == "K"
              path.push("#{r_level}.#{r_domain}")
            end
          end
        end
      end
      # return formatted pathing string based on passed limit
      return "#{name},#{path[0, limit].join(",")}"
    end
  end
end