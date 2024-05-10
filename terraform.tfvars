name       = "foo-web-host"
project_id = "project-id"
zone       = "zone"
region     = "region"
ip_range   = "range/##"

state-bucket = "terraform-foo"

min-replica-count = "1"
max-replica-count = "2"
cpu-target        = "0.8"
machine_type      = "e2-micro"

cloud_armor_allowed_ips = ["ip1","ip2"]#...

email_addresses     = ["user@foobar.com"]
master_ip_range     = "range/##" #/28
subnet_pod_ip_range = "range/##" #/23
subnet_svc_ip_range = "range/##" #/24
