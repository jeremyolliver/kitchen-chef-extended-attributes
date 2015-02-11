require 'minitest/spec'

describe_recipe 'extended_attributes_test::kitchenoverride' do
  it 'should not contain attributes from kitchen.yml' do
    file('/tmp/kitchen/dna.json').wont_match 'shouldnevershowup'
  end

  it 'should include attributes from dna JSON file' do
    file('/tmp/kitchen/dna.json').must_match 'valuefromdna'
  end
end
