# kitchen-chef-extended-attributes

## Use Case

If you use chef-solo for your main workflow, then you will have dna.json files defining the attributes and run_list etc for each of your roles. This test-kitchen extension allows you to use test-kitchen as your main entry point for a chef repo level test-kitchen setup - loading the pre-existing dna.json for your nodes so that your .kitchen.yml doesn't drift from the actual setup. Additionally adding extra run list items or attributes within the .kitchen.yml file will override the json file for example adding test handler cookbooks or vagrant user sudo permissions.

## Example

Given a chef repository layout similar to

    chef_repo
    |-- .kitchen.yml
    |-- Berksfile
    |-- Berksfile.lock
    |-- roles
    |   |-- app.rb
    |   `-- db.rb
    `-- nodes
        |-- app.json
        `-- db.json

Use the provisioner `chef_extended_attributes` in your .kitchen.yml and ensure `nodes_path` is set appropriately

    # .kitchen.yml
    ---
    driver:
      name: vagrant

    provisioner:
      name: chef_extended_attributes
      merge_attributes: true # the default
      role_path: 'roles'
      nodes_path: 'nodes'

    platforms:
      - name: ubuntu-14.04
        attributes:
          authorization:
            sudo:
              users: ['vagrant']

    # Suites will have node data loaded from nodes_path (nodes/<SUITENAME>.json)
    suites:
      - name: app
        run_list:
          - "recipe[minitest-handler]" # this is merged with the run_list definition in nodes
        attributes:
          mysql:
            password: test-password

This will result in `kitchen converge app-ubuntu-1404` running in chef-solo mode with a dna.json generated that uses the json file with the same name as the suite (e.g. nodes/app.json) your defined nodes/*.json files (where the suite name - e.g. `app`, and merges the overriden attributes given in the test kitchen definition.
