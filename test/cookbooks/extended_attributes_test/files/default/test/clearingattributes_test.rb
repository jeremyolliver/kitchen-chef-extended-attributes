require 'minitest/spec'

describe_recipe 'extended_attributes_test::clearingattributes' do
  it 'should not have the license key present' do
    file('/tmp/kitchen/dna.json').wont_match 'defaultkey'
    merged_json_data = JSON.parse(File.read('/tmp/kitchen/dna.json'))
    merged_json_data.keys.sort.must_equal ['run_list', 'service']
    merged_json_data['service'].must_equal({'license_key' => nil})
  end
end
