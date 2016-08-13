cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
encrypted_data_bag_secret File.expand_path("~/.data_bag_keys/spaghettiprogramming_key")
Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
