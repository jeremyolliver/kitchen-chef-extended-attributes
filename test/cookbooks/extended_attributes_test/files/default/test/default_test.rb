require 'minitest/spec'

describe_recipe 'extended_attributes_test::default' do
  it 'should include attributes from the dna' do
    file('/tmp/kitchen/dna.json').must_match 'valuefromdna'
  end

  it 'should include attributes from kitchen.yml' do
    file('/tmp/kitchen/dna.json').must_match 'valuefromkitchen'
  end
end
