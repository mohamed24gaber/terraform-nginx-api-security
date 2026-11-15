# Bonus: Secure Secret Management with AWS Systems Manager

## Overview

The project uses AWS Systems Manager Parameter Store to securely store and retrieve the internal authorization token.

The token is stored as an encrypted SecureString parameter instead of being hardcoded in the main NGINX configuration.

## Parameter Configuration

- Parameter name: `/nginx-api-security/internal-token`
- Parameter type: `SecureString`
- Terraform resource: `aws_ssm_parameter.internal_token`
- Terraform uses the write-only `value_wo` attribute and an ephemeral input variable.

## IAM Security

The EC2 instance uses an attached IAM Role to access the required SSM parameter.

The permissions used for provisioning include:

- `ssm:GetParameter`
- `ssm:PutParameter`
- `ssm:AddTagsToResource`

At runtime, the retrieval script requires `ssm:GetParameter`.

## Secure Retrieval Flow

1. EC2 obtains AWS credentials through its attached IAM Role.
2. A root-owned script retrieves the SecureString parameter using AWS CLI with decryption enabled.
3. The script writes the value into `/etc/nginx/secure/internal-token.conf`.
4. The directory permissions are restricted to `700`.
5. The generated configuration file permissions are restricted to `600`.
6. NGINX includes this protected file and injects the `X-Internal-Token` header into forwarded requests.

## Validation

The following checks were completed successfully:

- SSM SecureString parameter created.
- EC2 retrieved the parameter using its IAM Role.
- NGINX configuration test passed.
- NGINX reload succeeded.
- API request through NGINX returned HTTP 200.

## Security Considerations

- The actual token is not included in GitHub documentation.
- The main NGINX configuration does not hardcode the token.
- IAM access is scoped to the required parameter.
- The local configuration file is protected using filesystem permissions.
- The token remains in the protected local file because NGINX needs it to construct the upstream request header.
- Automatic token rotation is not implemented. The retrieval script can be executed again when the parameter value changes.

## Conclusion

This bonus improves the architecture by centralizing the internal token in AWS Systems Manager Parameter Store and retrieving it through IAM-based access.
