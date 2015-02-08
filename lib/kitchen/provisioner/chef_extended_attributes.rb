require 'kitchen/provisioner/chef_solo'
require 'json'

module Kitchen
  module Provisioner

    # Define a new test-kitchen provisioner, based on the chef-solo provisioner
    # with an additional load step to insert our pre-defined / generated
    # dna.json file before the chef run begins
    class ChefExtendedAttributes < Kitchen::Provisioner::ChefSolo

      default_config :merge_attributes, true

      # At the time of this hook being run, `sandbox_path` has been created,
      # populated, but not yet copied across to the destination environment
      def create_sandbox
        super
        debug('hooking create_sandbox')
        backup_original_dna_json
        if config[:merge_attributes]
          prepare_merged_json
        else
          prepare_overridden_json
        end
        debug('finished hooks')
      end

      private

      def prepare_merged_json
        info("merging #{instance.suite.name}.json and kitchen attributes")

        custom_json = JSON.parse(File.read(source_file))
        merged_json = custom_json.merge(config[:attributes])
        merged_json['run_list'] += (config[:run_list] || [])

        File.open(destination_file, "wb") do |file|
          file.write(merged_json.to_json)
        end
        debug('merged dna.json written')
      end

      def prepare_overridden_json
        info("copying #{instance.suite.name}.json to dna.json")

        `cp -f #{source_file} #{destination_file}`
      end

      def backup_original_dna_json
        `cp #{sandbox_path}/dna.json #{sandbox_path}/original-dna.json`
      end

      def source_file
        "#{config[:nodes_path]}/#{instance.suite.name}.json"
      end

      def destination_file
        File.join(sandbox_path, 'dna.json')
      end

      def info(msg)
        super("chef_solo_with_attributes: #{msg}")
      end

      def debug(msg)
        super("chef_solo_with_attributes: #{msg}")
      end

    end

  end
end
