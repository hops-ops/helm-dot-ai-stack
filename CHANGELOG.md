### What's changed in v0.1.0

* feat: helm chart xrd (by @patrickleet)

* fix: standardize GitHub workflows (by @patrickleet)

* chore: trigger CI (by @patrickleet)

* chore: trigger CI (by @patrickleet)

* fix: add ClusterRoleBinding for Helm provider in E2E tests (by @patrickleet)

* fix: skip e2e tests and improve Helm release template (by @patrickleet)

  dot-ai-stack requires API keys (Anthropic, OpenAI) and external services
  to become healthy. The chart cannot pass e2e tests in a kind cluster.

  Changes:
  - Remove e2e job from workflows (similar to crossplane, kiali, kubeflow)
  - Improve Helm release template with inline defaults per helm-xrd-pattern
  - Disable resourceSync and capabilityScan hooks that cause CRD timing issues
  - Update workflow version to v1.21.0

  Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>


