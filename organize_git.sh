#!/bin/bash

# Initialize git
git init

# 1. Base Project Setup
git add .gitignore mix.exs mix.lock config/ assets/ test/ README.md .formatter.exs
git add lib/event_manager.ex lib/event_manager/application.ex lib/event_manager/repo.ex lib/event_manager/mailer.ex
git add lib/event_manager_web.ex lib/event_manager_web/endpoint.ex lib/event_manager_web/telemetry.ex lib/event_manager_web/gettext.ex
git add priv/static/ priv/gettext/
git commit -m "chore: setup phoenix project structure and dependencies"

# 2. Database & Schemas
git add priv/repo/migrations/
git add lib/event_manager/schemas/
git commit -m "feat: implement database schemas and migrations"

# 3. Core Contexts & Logic
git add lib/event_manager/core.ex
git add lib/event_manager/services.ex
git add lib/event_manager/user_notifier.ex
git commit -m "feat: implement business logic and consolidated contexts"

# 4. Authentication
git add lib/event_manager_web/user_auth.ex
git commit -m "feat: user authentication logic"

# 5. Core Views & Components
git add lib/event_manager_web/components/
git add lib/event_manager_web/controllers/
git add lib/event_manager_web/router.ex
git commit -m "feat: web UI, controllers and routing"

# 6. LiveViews (Chat & Dashboard)
git add lib/event_manager_web/live/
git commit -m "feat: real-time features (Chat and Dashboard LiveViews)"

# 7. Documentation & Catch-all for any remaining files
git add GEMINI.md
git commit -m "docs: add architectural guidelines (GEMINI.md)"

git add .
git commit -m "chore: finalize remaining project files"
