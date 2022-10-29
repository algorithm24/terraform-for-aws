#! /bin/bash
YOUR_ACCESS_KEY_ID=${aws_access_key_id}
YOUR_SECRET_ACCESS_KEY=${aws_secret_access_key}
aws configure set aws_access_key_id \$YOUR_ACCESS_KEY_ID; aws configure set aws_secret_access_key \$YOUR_SECRET_ACCESS_KEY; aws configure set default.region us-east-1