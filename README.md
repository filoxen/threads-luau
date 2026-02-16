# threads-client

A Roblox server-side client for the [Threads](https://github.com/filoxen/threads) service. Handles reuploading clothing assets through your Threads instance.

## Installation

Add to your `wally.toml` dependencies:

```toml
[server-dependencies]
ThreadsClient = "secret-rare/threads-client@0.1.0"
```

Then run:

```bash
wally install
```

## Setup

1. Add your API key to the **Secrets Store** in the Creator Dashboard with the name `THREADS_API_KEY` (or your own custom secret name).

2. Update `BASE_URL` in the module to point to your Threads API instance.

## Usage

```luau
local ThreadsClient = require(path.to.ThreadsClient)

local newAssetId = ThreadsClient.create(assetId)

if newAssetId ~= -1 then
    print("Reuploaded to:", newAssetId)
end
```
