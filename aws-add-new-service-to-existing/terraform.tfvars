# locals varible settings
business_division = "wenorg"
environment       = "dev" ## options are "dev", "stg", "prd"
public_ec2_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgS5WqlNu2AojxJE/9c8BmhlZIc8EXz0qszhp6kzsaVVkkGK3Gl6o1DtQrrlyoolkc3Zrgw1jPI91n/wz69p4Yz6ND8HCGdz/VCdhCJfv6cW330B2IiWc8emQJ3We6gZhjzZAegAQh2DsLWGJlXGFySk6Y3LFxsdovrFwHlWK6jZ5kYOETSq5wugDKQVf4RSbVhh2/rnmKO/ur+lo31+Crqx2d8oV0KQcItLG8iR1aX0NJTWxGGBHxVSxQIVz9WXWUlclz3Og7oAXjzKTs70geyqYsowGHLWL+ruIrT4tIqVyTDySl+Aaas6hdx7+rGs2qKZgQoS1dZqXRKw/smALSAeUoYqcg98ZfSP48LLDa+IZaCGzqvwq+xJg9OUEivrwsikfxMP/ZjCLrFuspNH5v1XEcyGQXDpQkfrQRoGLiVvsymGiXcOHcMrML/fRtLXzy7lk+bf6a6eC+wiLKDikYcvVipszFCFYzN3PqOdcRVY18u6c4IvNG+Vy0wjmHR70= b1@waptop22"
region            = "us-west-1"
service           = "ecs"
vpc_cidr          = "10.0.0.0/16"

#### Existing ECS Cluster
ecs_cluster_name = "dev-ecs-webpage-ecs-cluster"
igw_id           = "igw-0cb55dd32de62ce5e"
# load_balancer_DNS_name = "dev-ecs-webpage-cluster-alb-1746160448.us-west-1.elb.amazonaws.com"
load_balancer_name = "dev-ecs-webpage-cluster-alb"
route_table_id     = "rtb-0accc60609d0bd4ea"
security_groups    = ["sg-00fef1f80040be27e"]
subnets = [
  "subnet-0a84fbee681fc739b",
  "subnet-055b03ddfc4d0bce6",
]
vpc_id = "vpc-01138f8d20d65d8ec"

### Application deployment settings
app_port  = "80"
app_image = "nginx"
