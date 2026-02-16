# threads-luau

A Roblox server-side client for the [Threads](https://github.com/filoxen/threads) service. Handles reuploading clothing assets through your Threads instance.

## Installation

Add to your `wally.toml` dependencies:

```toml
[server-dependencies]
ThreadsClient = "secret-rare/threads-luau@0.3.0"
```

Then run:

```bash
wally install
```

## Setup

1. Host your own [Threads](https://github.com/filoxen/threads) instance.

2. Add your API key to the **Secrets Store** in the Creator Dashboard with the name `THREADS_API_KEY` (or a custom name).

## Usage

```luau
local ThreadsClient = require(path.to.ThreadsClient)

ThreadsClient.configure({
    baseUrl = "https://your-threads-instance.com",
    apiKeySecretName = "THREADS_API_KEY", -- optional, this is the default
})

local newAssetId = ThreadsClient.create(assetId)

if newAssetId ~= -1 then
    print("Reuploaded to:", newAssetId)
end
```
