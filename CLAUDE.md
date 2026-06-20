# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an **Academic Events Management System** (Sistema de Gerenciamento de Eventos Acadêmicos) for the Programming Language Paradigms course (PLP).

- **Stack**: Elixir + Phoenix Framework + PostgreSQL + Nginx
- **Group project**: Groups of 5 students

## Technology Stack

| Layer | Technology |
|-------|------------|
| Backend | Elixir + Phoenix Framework (high concurrency, fault-tolerant) |
| Database | PostgreSQL (complex transactions support) |
| Web Server/Reverse Proxy | Nginx (static files, load balancing) |
| Frontend | Phoenix LiveView or JavaScript (optional) |

## Project Initialization (if starting fresh)

```bash
# Install dependencies (if needed)
mix local.hex --force
mix archive.install hex phx_new --force

# Create new Phoenix project
mix phx.new event_manager --database postgres

# Setup database
cd event_manager
mix ecto.setup
```

## Common Development Commands

```bash
# Install dependencies
mix deps.get

# Run the Phoenix server (with hot reload)
mix phx.server

# Or run in interactive mode
iex -S mix phx.server

# Run tests
mix test

# Run a specific test file
mix test test/path/to/file_test.exs

# Run a specific test
mix test test/path/to/file_test.exs:line_number

# Setup database (create + migrate + seed)
mix ecto.setup

# Reset database
mix ecto.reset

# Create new migration
mix ecto.gen.migration migration_name

# Generate a new context
mix phx.gen.context ContextName SchemaName table_name field:type

# Generate authentication (if using mix phx.gen.auth)
mix phx.gen.auth Accounts User users

# Format code
mix format

# Check for compilation warnings
mix compile --warnings-as-errors
```

## Required Features

### 1. Authentication & Authorization
- User registration/login with different roles: student, speaker, admin
- Role-based access control (only admin can create events)

### 2. Event Management
- Create events with date, location, limited seats, and speaker
- Registration system with seat control (prevent overbooking)
- Automatic PDF certificate generation for participants

### 3. Real-time Features (Phoenix Channels)
- Live chat during events for Q&A with speakers
- Real-time notifications about event capacity or reminders

### 4. Reports & Dashboards
- Graphical visualization of event occupancy
- Participation reports by course/department
- Data export in CSV/PDF

### 5. Nginx Integration
- Correct configuration as reverse proxy for Phoenix
- Serve static files (event image uploads) optimized

### 6. Complex PostgreSQL Queries
- Queries with joins, aggregations, subqueries
- Full-text search implementation in events

## Project Architecture (Typical Phoenix Structure)

```
lib/
├── event_manager/                    # Business logic (contexts)
│   ├── accounts/                     # User management context
│   │   ├── user.ex                   # User schema
│   │   └── ...
│   ├── events/                       # Event management context
│   │   ├── event.ex                  # Event schema
│   │   ├── registration.ex           # Registration schema
│   │   └── ...
│   ├── certificates/                 # Certificate generation context
│   └── reports/                      # Reports & dashboards context
├── event_manager_web/                # Web layer
│   ├── channels/                     # WebSocket channels for chat
│   ├── components/                   # Reusable UI components
│   ├── controllers/                  # HTTP controllers
│   ├── live/                         # LiveView modules (if using)
│   ├── routers/                      # Route definitions
│   └── templates/                    # HTML templates
config/
├── config.exs                        # General configuration
├── dev.exs                           # Development config
├── prod.exs                          # Production config
├── runtime.exs                       # Runtime configuration
└── test.exs                          # Test config
priv/
├── repo/migrations/                  # Database migrations
├── static/                           # Static assets
└── nginx/                            # Nginx configuration files
```

## Database Schema Considerations

Key entities to model:
- `users` (id, email, password_hash, role, name, course/department)
- `events` (id, title, description, date, location, max_seats, speaker_id, status)
- `registrations` (id, user_id, event_id, registered_at, attended)
- `certificates` (id, user_id, event_id, generated_at, certificate_data)
- `chat_messages` (id, event_id, user_id, message, sent_at)

## Grading Criteria

- **40%** - Implemented features and code quality
- **30%** - Adequate use of stack (Elixir/Phoenix + PostgreSQL + Nginx)
- **20%** - Teamwork (git flow, task division)
- **10%** - Documentation and presentation

## Delivery Requirements

- GitHub repository with detailed README
- Architecture and design decisions documentation
- 15-minute group presentation demonstrating the system
- Individual report describing each student's contribution

## Useful Resources

- Phoenix Guides: https://hexdocs.pm/phoenix/overview.html
- Ecto Documentation: https://hexdocs.pm/ecto/Ecto.html
- Phoenix LiveView: https://hexdocs.pm/phoenix_live_view/welcome.html
- PostgreSQL Full-text Search in Ecto
