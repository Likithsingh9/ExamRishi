{
    "version": 2,
    "builds": [
      {
        "src": "client",
        "use": "@vercel/static-build",
        "config": {
          "distDir": "dist"  // Vite's default output directory
        }
      },
      {
        "src": "server/server.js",
        "use": "@vercel/node",
        "config": {
          "includeFiles": ["dist/**"]
        }
      }
    ],
    "routes": [
      {
        "src": "/api/(.*)",  // All /api/* requests
        "dest": "server/server.js" // Route them to the server
      },
      {
        "src": "/(.*)",       // All other requests
        "dest": "client/dist/$1"  // Serve static files from client's dist dir
      }
    ]
  }