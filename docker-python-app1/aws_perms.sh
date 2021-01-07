echo "Get a new token ../get_aws_token.sh <mfa_code>"

#aws iam create-role --role-name lambda-exec --assume-role-policy-document '{ 
#"Version": "2012-10-17", 
#"Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, 
#    "Action": "sts:AssumeRole"}] 
#}' --profile ajay


# Create a role with S3 and Lambda exec access
ROLE_NAME=lambda-s3-exec-role
aws iam create-role --role-name $ROLE_NAME \
--assume-role-policy-document \
'{"Version":"2012-10-17",
"Statement":{"Effect":"Allow",
"Principal":{"Service":"lambda.amazonaws.com"},
"Action":"sts:AssumeRole"}}' --profile ajay
aws iam attach-role-policy \
--policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
--role-name $ROLE_NAME --profile ajay
aws iam attach-role-policy \
--policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole \
--role-name $ROLE_NAME --profile ajay
