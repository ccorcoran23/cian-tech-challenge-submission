# Auth 
As this project is making use of our existing sandbox AWS account and we already have an existing ConsoleCowboys permission set linked to this AWS account with full admin access, we will make use of AWS SSO profile to authenticate to the account. Please add the following to your local in ~/.aws/config:
[profile <profile_name>]
sso_start_url = https://d-93675802b1.awsapps.com/start/#/?tab=accounts
sso_region = eu-west-1
sso_account_id = 214911257442
sso_role_name = ConsoleCowboys
region = eu-west-1
output = json

You can initiate your SSO session using the following command: aws sso login --profile <profile_name>
And export this profile so you don't need to specify the profile each time you use aws cli: export AWS_PROFILE=<profile_name>
