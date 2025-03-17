# locals varible settings
business_division = "wenorg"
environment       = "dev" ## options are "dev", "stg", "prd"
public_ec2_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgS5WqlNu2AojxJE/9c8BmhlZIc8EXz0qszhp6kzsaVVkkGK3Gl6o1DtQrrlyoolkc3Zrgw1jPI91n/wz69p4Yz6ND8HCGdz/VCdhCJfv6cW330B2IiWc8emQJ3We6gZhjzZAegAQh2DsLWGJlXGFySk6Y3LFxsdovrFwHlWK6jZ5kYOETSq5wugDKQVf4RSbVhh2/rnmKO/ur+lo31+Crqx2d8oV0KQcItLG8iR1aX0NJTWxGGBHxVSxQIVz9WXWUlclz3Og7oAXjzKTs70geyqYsowGHLWL+ruIrT4tIqVyTDySl+Aaas6hdx7+rGs2qKZgQoS1dZqXRKw/smALSAeUoYqcg98ZfSP48LLDa+IZaCGzqvwq+xJg9OUEivrwsikfxMP/ZjCLrFuspNH5v1XEcyGQXDpQkfrQRoGLiVvsymGiXcOHcMrML/fRtLXzy7lk+bf6a6eC+wiLKDikYcvVipszFCFYzN3PqOdcRVY18u6c4IvNG+Vy0wjmHR70= rsa-key-20210907"
region            = "us-west-2"
service           = "base"
vpc_cidr          = "10.0.0.0/16"

### Application deployment settings
app_port  = 80 ### 80 for httpd and nginx, Tomcat default port 8080, other services may have different default ports
app_image = "nginx"
# app_image = "497140136649.dkr.ecr.us-east-1.amazonaws.com/dev/bbtest:test" ### Image repository URL
# app_image = "497140136649.dkr.ecr.us-west-2.amazonaws.com/dev/bbtest:test" ### Image repository URL