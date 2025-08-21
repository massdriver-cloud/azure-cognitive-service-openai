resource "massdriver_artifact" "endpoint" {
  field    = "endpoint"
  name     = "Azure Cognitive Service OpenAI ${module.cognitive_services.account_name}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          ari      = module.cognitive_services.account_id
          endpoint = module.cognitive_services.endpoint
        }
        security = {
          iam = {
            "read" = {
              role  = "Cognitive Services OpenAI User"
              scope = module.cognitive_services.account_id
            }
            "read_write" = {
              role  = "Cognitive Services OpenAI Contributor"
              scope = module.cognitive_services.account_id
            }
          }
        }
      }
      specs = {
        azure = {
          region = module.cognitive_services.account_location
        }
      }
    }
  )
}
