require 'spec_helper'
require 'csv'

describe Corepathing do

  it 'has a version number' do
    expect(Corepathing::VERSION).not_to be nil
  end

  context "pathing class" do
    before :all do
      @expected_results = CSV.read("spec/data/sol.csv", headers: false)
      @cc_obj = Corepathing::Pathing.new("spec/data/stu.csv", "spec/data/ord.csv")
      @students = @cc_obj.path_students(5)
    end

    it 'should return an array of student objects' do
      expect(@students.class).to eq(Array)
      expect(@students[0].class).to eq(Corepathing::Student)
    end

    it 'should calculate pathing of student based on scores/domain ordering' do
      cnt = 0
      @students.each do |student|
        expect(student.to_s).to eq(@expected_results[cnt].join(","))
        cnt += 1
      end
    end

    it 'should return a student object with pathing limit provided' do
      students = CSV.read("spec/data/stu.csv", headers: true)
      puts @cc_obj.get_path(students[0]).inspect
    end

    it 'should return a student object with default pathing limit (5)' do
      @students = @cc_obj.path_students()
      expect(@students[0].path.length).to eq(5)
    end
  end

  context "student class" do
    before :all do
      @expected_results = CSV.read("spec/data/sol.csv", headers: false)
      @cc_obj = Corepathing::Pathing.new("spec/data/stu.csv", "spec/data/ord.csv")
      @students = @cc_obj.path_students(5)
    end

    it 'should return a string representation of the student\'s pathing' do
      expect(@students[0].to_s).to eq(@expected_results[0].join(","))
    end
  end
end
