helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update

# Install Kyverno
helm install kyverno kyverno/kyverno -n kyverno --create-namespace


# You'll need the cosign public key content --- copy that
# And create a cluster policy
apiVersion: kyverno.io/v1
kind: ClusterPolicy   # A rule for your whole cluster
metadata:
  name: check-image-signatures
spec:
  validationFailureAction: Enforce # This will BLOCK non-compliant deployments
  background: false
  rules:
  # Not create the pod, if image is not signed or verified
  - name: verify-image-signature
    match:
      any:
      - resources:
          # This rule applies whenever someone tries to create a Pod
          kinds:
          - Pod
    verifyImages:  #  The action to perform is to verify container images
    - imageReferences:
      - "dakshsawhneyy/demo-service-*" # Apply this rule to all your demo images
      attestors:    # # How to verify?
      - count: 1
        entries:
        - keys:
            publicKeys: |-
              -----BEGIN PUBLIC KEY-----
              MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE4ojHT6xfrO7yylmG+8xqfsu11zVp
              3oPUp1sRmScMEi7+7Y8gTzCmyQHWDizCe9BZ4BT+aM+E+uYy1hWEEuJ8Qg==
              -----END PUBLIC KEY-----
