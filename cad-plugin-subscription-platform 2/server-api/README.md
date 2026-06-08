# Server API Placeholder

This folder is reserved for the future licensing and update API.

Recommended first endpoints:

```text
POST /api/licenses/activate
POST /api/licenses/validate
POST /api/licenses/deactivate-device
GET  /api/tools/latest-manifest
GET  /api/tools/download/{toolVersionId}
POST /api/admin/tools
```

For production licensing, do not trust plain AutoLISP files for security. Use a signed license response from the server and a compiled local loader or helper service for stronger device locking.
