local HttpService = game:GetService("HttpService")

local clothing_upload = {}

local BASE_URL: string? = nil
local API_KEY: Secret? = nil

export type Config = {
	baseUrl: string,
	apiKeySecretName: string?,
}

function clothing_upload.configure(config: Config)
	BASE_URL = config.baseUrl
	local secretName = config.apiKeySecretName or "THREADS_API_KEY"
	API_KEY = HttpService:GetSecret(secretName)
end

-- Sends a reupload request to the Threads API for the given asset ID. Returns the new asset ID, or -1 on failure.
function clothing_upload.create(id: number): number
	assert(BASE_URL and API_KEY, "[ThreadsClient] Must call .configure() before using .create()")

	local create_url = `{BASE_URL}/create/?asset_id={id}`

	local request_data = {
		Url = create_url,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			["x-api-key"] = API_KEY
		}
	}

	local success, response = pcall(function()
		return HttpService:RequestAsync(request_data)
	end)

	if success and response.Success then
		local response_data = HttpService:JSONDecode(response.Body)
		if response_data["uploaded"] then
			local newAssetId = tonumber(response_data["uploaded"]["asset_id"]) :: number
			print(`[ThreadsClient] Successfully reuploaded asset {id} -> {newAssetId}`)
			return newAssetId
		else
			warn(`[ThreadsClient] Reupload failed for asset {id}: Response missing 'uploaded' field`)
		end
	else
		local errorMsg = if response then response.StatusMessage else "Unknown Error"
		warn(`[ThreadsClient] API request failed for asset {id}: {errorMsg}`)
	end
	return -1
end

return clothing_upload
