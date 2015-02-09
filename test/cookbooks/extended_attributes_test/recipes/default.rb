require 'minitest/spec'

describe_recipe 'extended_attributes_test::default' do
  it 'should include attributes from the dna' do
    file('/tmp/kitchen/dna.json').must match_content 'valuefromdna'
  end
end
