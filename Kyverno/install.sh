# Add the Kyverno Helm repository
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update

# Install Kyverno into its own namespace
helm install kyverno kyverno/kyverno -n kyverno --create-namespace

# Create a new file named require-labels-policy.yaml. This policy will block any new Deployment that doesn't have a team-owner label.
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-team-owner-label
spec:
  # This makes the rule block deployments instead of just auditing them
  validationFailureAction: Enforce
  rules:
  - name: check-for-team-owner-label
    match:
      any:
      - resources:
          # This rule applies to all Deployments
          kinds:
          - Deployment
    validate:
      message: "The label 'team-owner' is required for all deployments."
      # This is the actual rule: the 'team-owner' label must exist
      pattern:
        metadata:
          labels:
            team-owner: "?*" # "?*" is a wildcard that just means the key must exist
