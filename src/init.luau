local HttpService = game:GetService("HttpService")

local clothing_upload = {}

-- Change this to your own Threads API instance URL
local BASE_URL = "https://threads.example.com"
-- Name of the secret in the Secrets Store (Creator Dashboard -> Secrets).
local API_KEY_SECRET_NAME = "THREADS_API_KEY"

local API_KEY = HttpService:GetSecret(API_KEY_SECRET_NAME)

-- Sends a reupload request to the Threads API for the given asset ID. Returns the new asset ID, or -1 on failure.
function clothing_upload.create(id: number): number
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
			print(`[ClothingUploadClient] Successfully reuploaded asset {id} -> {newAssetId}`)
			return newAssetId
		else
			warn(`[ClothingUploadClient] Reupload failed for asset {id}: Response missing 'uploaded' field`)
		end
	else
		local errorMsg = if response then response.StatusMessage else "Unknown Error"
		warn(`[ClothingUploadClient] API request failed for asset {id}: {errorMsg}`)
	end
	return -1
end

return clothing_upload
