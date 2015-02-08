require 'kitchen/provisioner/chef_solo'
require 'json'

module Kitchen
  module Provisioner

    class ChefExtendedAttributes < Kitchen::Provisioner::ChefSolo

      default_config :merge_attributes, true

      # At the time of this hook being run, `sandbox_path` has been created, populated,
      # but not yet copied across to the destination environment
      def create_sandbox
        super
        debug('chef_extended_attributes hooking create_sandbox')
        backup_original_dna_json
        if config[:merge_attributes]
          prepare_merged_json
        else
          prepare_overridden_json
        end
        debug('chef_solo_with_attributes finished hooks')
      end

      def backup_original_dna_json
        `cp #{sandbox_path}/dna.json #{sandbox_path}/original-dna.json`
      end

      def prepare_merged_json
        info("chef_solo_with_attributes merging #{instance.suite.name}.json and kitchen attributes to dna.json")
        source_file = "#{config[:nodes_path]}/#{instance.suite.name}.json"
        destination_file = File.join(sandbox_path, 'dna.json')

        custom_json = JSON.parse(File.read(source_file))
        merged_json = custom_json.merge(config[:attributes])
        merged_json['run_list'] += (config[:run_list] || [])

        File.open(destination_file, "wb") do |file|
          file.write(merged_json.to_json)
        end
        debug('chef_solo_with_attributes merged.json written')
      end

      def prepare_overridden_json
        info("chef_solo_with_attributes copying #{instance.suite.name}.json to dna.json")
        source_file = "#{config[:nodes_path]}/#{instance.suite.name}.json"
        destination_file = File.join(sandbox_path, 'dna.json')

        `cp -f #{source_file} #{destination_file}`
      end

    end

  end
end
