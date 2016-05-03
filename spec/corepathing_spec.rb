require 'spec_helper'
require 'csv'

describe Corepathing do
  it 'has a version number' do
    expect(Corepathing::VERSION).not_to be nil
  end

  it 'calculates student pathing based on domain ordering' do
    expected_results = CSV.read("spec/data/sol.csv", headers: false)
    tmp = Corepathing::Pathing.new("spec/data/stu.csv", "spec/data/ord.csv")
    z = tmp.path_students(5)

    cnt = 0;
    z.each do |y|
      expect(y).to eq(expected_results[cnt].join(","))
      cnt += 1
    end
  end
end
