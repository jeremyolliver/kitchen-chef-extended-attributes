require 'minitest/spec'

describe_recipe 'extended_attributes_test::kitchenmerged' do
  it 'should give higher precendence to attributes in kitchen.yml' do
    merged_json_data = JSON.parse(File.read('/tmp/kitchen/dna.json'))
    merged_json_data['valuefromdna'].must_equal 'overridden'
  end

  it 'should include run_list items from dna JSON file' do
    node.run_list.must_include('recipe[git]')
    package('git').must_be_installed
  end
end
