resource "kubernetes_config_map_v1" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = aws_iam_role.eks_node_role.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      },
      {
        rolearn  = aws_iam_role.jenkins_role.arn
        username = "jenkins"
        groups   = ["system:masters"]
      }
    ])
  }

  depends_on = [
    aws_eks_node_group.worker_nodes,
    aws_iam_role.jenkins_role
  ]
}
