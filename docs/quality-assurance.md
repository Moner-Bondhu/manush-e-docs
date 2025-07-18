# Quality Assurance (QA) Process for Manush-E

This document outlines the open source quality assurance process followed by the Manush-E project, in compliance with open source best practices.

---

## Overview

Manush-E is developed as two separate repositories:

- **Frontend**: Vue.js with Vite + Ionic
- **Backend**: Laravel (PHP)

We follow a multi-level QA strategy combining:

- Unit and integration testing
- Manual functional testing
- Test coverage tracking
- Continuous Integration workflows

---

## Tools and Frameworks Used

| Layer    | Framework/Tool                                | Purpose                          |
| -------- | --------------------------------------------- | -------------------------------- |
| Frontend | [Vitest](https://vitest.dev) + Vue Test Utils | Unit and component testing       |
| Backend  | [PHPUnit](https://phpunit.de)                 | Unit and API testing             |
| CI/CD    | GitHub Actions                                | Run tests and linting on push    |
| Coverage | v8 (frontend) / phpunit-coverage              | Measure and report test coverage |

---

## Testing Strategy

All pull requests are reviewed and must pass automated test checks before merging.

### Frontend (Vue)

- Unit tests for components (e.g., buttons, forms)
- Integration tests for features (e.g., login flow)
- Mocking of API responses where needed

### Backend (Laravel)

- Unit tests for models, services
- Feature/API tests using Laravel’s HTTP testing
- Seperate testing database used

### Manual Testing

For features difficult to automate (e.g., interactive games, animations):

- Manual testing checklists are maintained in issues or Notion
- Common flows (e.g., onboarding, game completion) are manually tested before each release

---

## Test Coverage

### Frontend

- Run using `npm run coverage`
- Generates HTML and CLI coverage reports
- Located in `coverage/` folder

### Backend

- Run using `php artisan test --coverage`
- Coverage reports visible via terminal or `tests/coverage`

> **Coverage targets:**  
> Frontend: ≥ 80%  
> Backend: ≥ 80%

---

## Continuous Integration

We use **GitHub Actions** to:

- Run frontend and backend tests
- Lint codebase
- Prevent merge if tests fail

Workflow files:

- `.github/workflows/frontend.yml`
- `.github/workflows/backend.yml`

---

## Where to Find Tests

### Frontend

- Location: `tests/`
- Command: `npm run test`

### Backend

- Location: `tests/Feature/`, `tests/Unit/`
- Command: `php artisan test`

---

## Contribution QA Guidelines

- All new features must include relevant test cases.
- Bug fixes must include a regression test.
- Open a PR with clear testing instructions.

---
