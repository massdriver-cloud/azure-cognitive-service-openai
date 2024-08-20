## Azure Cognitive Service OpenAI

Azure Cognitive Service OpenAI enables users to integrate advanced language understanding and machine learning capabilities into their applications. This service provides access to powerful models for natural language processing, including capabilities for text generation, sentiment analysis, and language translation. 

### Design Decisions

- **Service Naming**: The module requires a naming prefix (`name_prefix`) for resource identification.
- **Location**: You must specify the geographical region (`location`) where the service will be deployed.
- **Kind**: This module is specifically designed for OpenAI (`kind = "OpenAI"`).
- **SKU Tier**: The SKU tier (`sku_name`) defaults to `S0`, which balances cost and performance.
- **Tags**: Resource tags (`default_tags`) are mandatory for organizational purposes and tracking.

### Runbook

#### Issue: Endpoint Not Responding

If the OpenAI endpoint is not responding, you can check its status with the following Azure CLI command:

```sh
az cognitiveservices account show --name <YOUR-SERVICE-NAME> --resource-group <YOUR-RESOURCE-GROUP>
```

Replace `<YOUR-SERVICE-NAME>` and `<YOUR-RESOURCE-GROUP>` with your actual service name and resource group. This command retrieves the current status of the cognitive service account.

#### Issue: Authentication Errors

If you receive authentication errors, verify that the service principal credentials are correctly configured. Run:

```sh
az ad sp show --id <YOUR-SERVICE-PRINCIPAL-ID>
```

Make sure the client ID, tenant ID, and client secret correspond to the values specified in your configuration.

#### Issue: Insufficient Role Permissions

If you suspect there are permission issues, check the assigned roles:

```sh
az role assignment list --assignee <YOUR-SERVICE-PRINCIPAL-ID>
```

This command lists all role assignments for the specified service principal. Ensure that the necessary roles (`Cognitive Services OpenAI User` and `Cognitive Services OpenAI Contributor`) are assigned.

#### Issue: Network Connectivity

For network-related issues, use the following command to verify service endpoint connectivity:

```sh
curl -v <OPENAI-API-ENDPOINT>
```

Replace `<OPENAI-API-ENDPOINT>` with the actual API endpoint of your OpenAI service. This will help diagnose any possible network issues, such as DNS resolution or firewall rules.

#### Issue: Model Performance

If the models are not performing as expected, you can run diagnostic queries directly:

```python
import openai

openai.api_key = '<YOUR-API-KEY>'

response = openai.Completion.create(
    engine="text-davinci-003",
    prompt="Translate the following English text to French: 'Hello, how are you?'",
    max_tokens=60
)

print(response)
```

Ensure you enter your API key and validate the output. This Python snippet checks if the model responds correctly to provided inputs.

#### Issue: API Rate Limits

To check API rate limits and avoid throttling, use:

```sh
curl -H "Authorization: Bearer <YOUR-API-KEY>" <OPENAI-API-ENDPOINT>/usage
```

Replace `<YOUR-API-KEY>` with your actual API key and `<OPENAI-API-ENDPOINT>` with the correct endpoint. This command helps you monitor your usage and avoid hitting rate limits.

