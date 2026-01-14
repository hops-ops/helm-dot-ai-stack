import models.ai.com.ops.hops.helm.v1alpha1 as helmv1alpha1
import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1

_items = [
    metav1alpha1.CompositionTest {
        metadata.name = "minimal-renders-helm-release"
        spec = {
            compositionPath = "apis/dotaistacks/composition.yaml"
            xrdPath = "apis/dotaistacks/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = helmv1alpha1.DotAIStack {
                metadata.name = "test-dotai"
                spec.clusterName = "test-cluster"
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata.name = "test-dotai"
                }
            ]
        }
    }

    metav1alpha1.CompositionTest {
        metadata.name = "custom-labels-merged"
        spec = {
            compositionPath = "apis/dotaistacks/composition.yaml"
            xrdPath = "apis/dotaistacks/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = helmv1alpha1.DotAIStack {
                metadata.name = "labeled-dotai"
                spec = {
                    clusterName = "test-cluster"
                    labels = {team = "platform"}
                }
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata = {
                        name = "labeled-dotai"
                        labels = {
                            "hops.ops.com.ai/managed" = "true"
                            "hops.ops.com.ai/dotaistack" = "labeled-dotai"
                            team = "platform"
                        }
                    }
                }
            ]
        }
    }

    metav1alpha1.CompositionTest {
        metadata.name = "override-all-values"
        spec = {
            compositionPath = "apis/dotaistacks/composition.yaml"
            xrdPath = "apis/dotaistacks/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = helmv1alpha1.DotAIStack {
                metadata.name = "override-test"
                spec = {
                    clusterName = "my-cluster"
                    overrideAllValues = {fullnameOverride = "custom-dotai"}
                }
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata.name = "override-test"
                    spec.forProvider.values = {fullnameOverride = "custom-dotai"}
                }
            ]
        }
    }
]

items = _items
