# Environment
########################################################################
env_name       = "dev"
location       = null
cluster_number = "01"
cluster_domain = "local"
# If using this project version >= 4.0.0 with a previously provisioned cluster,
# check this setting: https://github.com/khanh-ph/proxmox-kubernetes/releases/tag/4.0.0
use_legacy_naming_convention = false

# Proxmox VE
########################################################################
# Proxmox VE API details and VM hosting configuration
# API token guide: https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
pm_api_url          = "https://ns3057801.ip-137-74-93.eu:8006/api2/json"
pm_api_token_id     = "root@pam!terraform"
pm_api_token_secret = "bcd9a93e-b48e-487a-932f-d2b198c109a7"
pm_tls_insecure     = true
pm_host             = "ns3057801"
pm_parallel         = 2
pm_timeout          = 600


# Common infrastructure configurations
########################################################################
# Kubernetes internal network
internal_net_name = "vmbr1"
# Internal network CIDR
internal_net_subnet_cidr = "10.0.1.1/24"
# Base64 encoded keys for Kubernetes admin authentication
ssh_public_keys = <<EOT
c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFDQVFDUURDdU9xUTZnSVlIa2FTS2JW
R283MUxBazhYSE96VmpFUGIzTS9qWU50amY2d2pmbzZDV1g4RHVEVk45RWsxUHVXYVVFQTRYQ0x0
WFFSVDg5b2JHam1WSHBRem0yaGhLV2YvYjNzT2dUcXdsUm9OSXJuV1ppR3ZKY25xRzQxMnB5anV3
MFAwNzNaWWlpcXR4eXB0eXpReGFqZnMraDdIMnYwY1hSVCtJQWFmZ3RNM0pvc1ZtRkZ0cE1vb3E3
eU1UOG96ckhMWjhxSFFtQVM4OVEwRms4N3dwNXFiSjB0YXQwYU9EZkNqMTVwdXV2Y21TTy9HY2dV
WDF2U1JTdSt6Y1JKMVBqRG9EVjJKdW8yYlZlRmtEQWlsbi9TWlV1UG9rTVdZS0pZaTcrYVlsOHpm
RDlIa1I0Q01FSi9KbnY4QWRqZjZUSFpST3BnemtkTTFDL0xHMXBtQXpoaXhwSXd6aXREdEFDSFlV
cXJtOXRLWjZSL3pLR3Z4RG9rNUFjTmoyRTQyQVlWNVhpdlpOd1VYUTBJL3JNSjFOMzRGSDdUekho
UWRXd1ROa0oydk41RGI5d2NSeDBzVHB0UWlrSkhEUmEwMktQdmw0K0dWUElwNXdudUI3Y0FTd1hJ
SFpXNjdOeE90QlR0elY1NlRMbHYrZlRxWkxHUG0zdFJCZEJieXVMMWJXbFEzdmtjaThmOWh3YlUx
ZWNtcitSbzNTazV0ZHp6dHNPVVRUWmxsNnBjdFplVXFkS2ZGR0gzbWlqTElPOGh0SXVIZUFydHpl
NlZybUtBVWM3ZVBEZTkwR0N4NngyanVBOVo2anVNUGVXbGtFeTdFWUttSmpWS1lpb1VwSjVGTUFz
TE5Mc281U3NxMkk0cXdsQmdQMHFGTUZnRnVDWUVjbERsZWV0N3c9PSBrOHMtYWRtaW5AY2x1c3Rl
ci5sb2NhbAo=
EOT
# Caution: In production, follow https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables
# to protect the sensitive variable `ssh_private_key` 
ssh_private_key = <<EOT
LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFB
QUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUNGd0FBQUFkemMyZ3RjbgpOaEFBQUFB
d0VBQVFBQUFnRUFrQXdyanFrT29DR0I1R2tpbTFScU85U3dKUEZ4enMxWXhEMjl6UDQyRGJZMytz
STM2T2dsCmwvQTdnMVRmUkpOVDdsbWxCQU9Gd2k3VjBFVS9QYUd4bzVsUjZVTTV0b1lTbG4vMjk3
RG9FNnNKVWFEU0s1MW1ZaHJ5WEoKNmh1TmRxY283c05EOU85MldJb3FyY2NxYmNzME1XbzM3UG9l
eDlyOUhGMFUvaUFHbjRMVE55YUxGWmhSYmFUS0tLdThqRQovS002eHkyZktoMEpnRXZQVU5CWlBP
OEtlYW15ZExXcmRHamczd285ZWFicnIzSmtqdnhuSUZGOWIwa1VydnMzRVNkVDR3CjZBMWRpYnFO
bTFYaFpBd0lwWi8wbVZMajZKREZtQ2lXSXUvbW1KZk0zdy9SNUVlQWpCQ2Z5WjcvQUhZMytreDJV
VHFZTTUKSFROUXZ5eHRhWmdNNFlzYVNNTTRyUTdRQWgyRktxNXZiU21la2Y4eWhyOFE2Sk9RSERZ
OWhPTmdHRmVWNHIyVGNGRjBOQwpQNnpDZFRkK0JSKzA4eDRVSFZzRXpaQ2RyemVRMi9jSEVjZExF
NmJVSXBDUncwV3ROaWo3NWVQaGxUeUtlY0o3Z2UzQUVzCkZ5QjJWdXV6Y1RyUVU3YzFlZWt5NWIv
bjA2bVN4ajV0N1VRWFFXOHJpOVcxcFVONzVISXZIL1ljRzFOWG5KcS9rYU4wcE8KYlhjODdiRGxF
MDJaWmVxWExXWGxLblNueFJoOTVvb3l5RHZJYlNMaDNnSzdjM3VsYTVpZ0ZITzNqdzN2ZEJnc2Vz
ZG83ZwpQV2VvN2pEM2xwWkJNdXhHQ3BpWTFTbUlxRktTZVJUQUxDelM3S09Vckt0aU9Lc0pRWUQ5
S2hUQllCYmdtQkhKUTVYbnJlCjhBQUFkUStzVnZhZnJGYjJrQUFBQUhjM05vTFhKellRQUFBZ0VB
a0F3cmpxa09vQ0dCNUdraW0xUnFPOVN3SlBGeHpzMVkKeEQyOXpQNDJEYlkzK3NJMzZPZ2xsL0E3
ZzFUZlJKTlQ3bG1sQkFPRndpN1YwRVUvUGFHeG81bFI2VU01dG9ZU2xuLzI5NwpEb0U2c0pVYURT
SzUxbVlocnlYSjZodU5kcWNvN3NORDlPOTJXSW9xcmNjcWJjczBNV28zN1BvZXg5cjlIRjBVL2lB
R240CkxUTnlhTEZaaFJiYVRLS0t1OGpFL0tNNnh5MmZLaDBKZ0V2UFVOQlpQTzhLZWFteWRMV3Jk
R2pnM3dvOWVhYnJyM0pranYKeG5JRkY5YjBrVXJ2czNFU2RUNHc2QTFkaWJxTm0xWGhaQXdJcFov
MG1WTGo2SkRGbUNpV0l1L21tSmZNM3cvUjVFZUFqQgpDZnlaNy9BSFkzK2t4MlVUcVlNNUhUTlF2
eXh0YVpnTTRZc2FTTU00clE3UUFoMkZLcTV2YlNtZWtmOHlocjhRNkpPUUhEClk5aE9OZ0dGZVY0
cjJUY0ZGME5DUDZ6Q2RUZCtCUiswOHg0VUhWc0V6WkNkcnplUTIvY0hFY2RMRTZiVUlwQ1J3MFd0
TmkKajc1ZVBobFR5S2VjSjdnZTNBRXNGeUIyVnV1emNUclFVN2MxZWVreTViL24wNm1TeGo1dDdV
UVhRVzhyaTlXMXBVTjc1SApJdkgvWWNHMU5YbkpxL2thTjBwT2JYYzg3YkRsRTAyWlplcVhMV1hs
S25TbnhSaDk1b295eUR2SWJTTGgzZ0s3YzN1bGE1CmlnRkhPM2p3M3ZkQmdzZXNkbzdnUFdlbzdq
RDNscFpCTXV4R0NwaVkxU21JcUZLU2VSVEFMQ3pTN0tPVXJLdGlPS3NKUVkKRDlLaFRCWUJiZ21C
SEpRNVhucmU4QUFBQURBUUFCQUFBQ0FBMnZnbEhuQVBNNHk4RDZOaVlBMHFrRmo0aXJBYytPbGZE
cgpGc1hMbnpJVlRtTStJWmE0dTUyZ1h0OGU2S2w0ditBazF6YzI2SFhuQWp4cjM5TElzbnBqSGpP
bHhlMXY5b01pL0VGVEp2CkY3YmdLNTMwM3lnZUF2UkRpRmY4THlnSFFLM1Nrbm5LYUhtSUF2OEly
YURKemhjbHl0TnlmZ3NwNUtOVnVxRmNSSlRTRnEKUW1QcytaN1o2WHFmZE1QYmtzK1g2SVUwOGVy
TDRITzJnQ2RpN0IrTWJIZmJwZzlObFZFVmg4dlpDcmNzb3piRGpRZEN0cgorTXpuaU12bkRUZ0V0
YWE2OW1XTm80WHEyZnBZb2ZYaDZNNW5rSk1pbTNHa2s0bGR6Y25hOWhNb1ZQZ2FaaXdrbVBOMXZ1
CkNtZ1A2M3ZLREVzL2NLdEp3dHJoM2JtVURINzN5dUhTM1h2L3ZobEE5YjdFT3JMVUs1SmpEMVpi
SFVhTkY2Y0d2K2dOdGkKY2pJSm5HMUNhdGdGTVU2amZZendUdlFSVGdNeXI5aGFUanZvcTQ3TGhY
emw0eTFYWTYwT3hwN1k4dXV2NzZuUTFHZ3lLTwp6S2pjVXJwV3pVdEcxakJxUXJ5VUlKQ1NqNkFo
dTZNOERueFR1S1ltSForc0EreEQwVmEraktwcEVIZThQNStEb056azQzClYxa3RIVW13QnhVNEFB
KzZLZ1BFQWp4eUF6NWUzWS94dTRKekdBang3a2ZQVW1pczZ0bmtOVmZWelZpQitUYTZPVGtuUWQK
RVJwVlR1RU5zM1RWWWJnejAxV2VHSERoQ29IZW5va2FpY1BKSTBtb3M4emNpYnhIblNaSWRGbnlZ
cEs5U1VuMkJpbzdDbwo3L2o4VXB0Yko3Vkl5ZnJ0WUZBQUFCQUY3aUNrWE5PZHV4ZnExMG53YnlI
ZFRxMG1pbHNVUmxpV1pSRWJzK0l1b1dhWFNRCk1POWJkdE10Vk9CRG9SZk1WcXU4Yjk5clFlQ0di
U3lLNHc1NjlYMXlEdWszL3FmNjJqUHRVckJiN0NnT0JhSHV0RHVaTDkKV2w0NW15UFZrTXRqK0Iv
a3JzdmhnMnN2bExMSkZOL1VPT2NCU014L1NaamFsR1BwVWMxZnhnT3ZBQlppRVFzMGFtaWFOSgpu
V28wRTBIK2JVRVI5N0lHLzFYSFZzTmN4SzZhVmxzM0M4VVdUNU9XNDhmaXUxNlNiUEdTZFpKTVlP
TmpObnNzZjNBaGZ4CjM4aENrVnhYOHhPTEtwMUo2TGw2U2xUYTB0SXBSOVNhM2pJUUIrWFZ0UkFh
TFhvam9vRXJnSE9qeFdhOG1renJOSkF5bUoKcnRVelV0VHZqSDlmMFJRQUFBRUJBTU9VdHkwNGJP
N3YvZ1k1cUpTT09FWVg5ZDNCMi94TmxEdlVSaHMvSTIzYzE0bnNjUQpFdlJHOHMvU281bDBOTDZn
Z3RDY2Y5c0xzRTVmV0p4VTUvSk5WSGRsbjJiV3NQMEsyclpjVzBQeDBXM253eWI5dGp4ZXdwCmk1
VmVqU0hDbjlvT1ZNQjlFZUR1RWVJZzEwbncvK1pqVjlIQ0VKWnBST3Q5d3RmbGxHNjlZSXptY3Uw
cEh0Kyt5ODcwTjQKMmtyQWd1aU9Zb2RkVFRGd3lrU3libmpZZzBTaHUyODJvZHMydFhqNDR4ZEwv
UEVNcUlaTTh3dDZ3WjdjRHhGNUl3Vm0rNApvY2pPbUQrVlhRd0VzekNlbk1RdDNCcXVPMTMrcHlJ
L2pLeTBleUplTWw3c3Jld3NMVW1KZ25MMzdRWmNMNkQzNXFXQ1EwCjNmYnRzdTEwbmRSZFVBQUFF
QkFMeUwvNTR4Z05WVURWUFR1WG9hWitYZVhGSGJESjhGaGhsUk9tbTVMMUQrTVlBeFJ6R2wKdXFE
QXJDRFN4R00vZm0yWW1aVXNBd0xVZ2JUS3gwUXZ5RUxzaWlxa0VWYzBDaURLMDJ4VStuSVIvNjJ5
WDJsUHRzWXJWNAp3K0lwYkxIRlVJOWo4ZUJKYjc4Yk1iSUJpVk92Nk9ieXBwQ01Ja1ZYSGZZMjYv
TWFDOXUrcXBxelFwZ3lsZ1llek5nTlZFCmk0cGQxVGs3Vjh5NU5jS2llNytLNEd1ZTdHVE1BcUdo
V3pnMHQ0N1FjbzM0U1NjakVFdkozWEJhTFJLRi80blRXUFpXNEEKTXlLTVBqcENzVGo1VlZqdzUw
aXUyeENIM3c4OHlRSTJ4WDhqZFFJNHI4MW8vNTk2dER3UWpTN0FTMjdVWk5RT0ZwSkpQRQpVdmJL
eHBNN2NyTUFBQUFYYXpoekxXRmtiV2x1UUdOc2RYTjBaWEl1Ykc5allXd0JBZ01FCi0tLS0tRU5E
IE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQo=
EOT

# Default disk storage for the VMs. Uncomment the following line if needed
vm_os_disk_storage = "local"

# Bastion host details. This is required for the Terraform client to 
# connect to the Kubespray VM that will be placed into the internet network
bastion_ssh_ip   = "137.74.93.251"
bastion_ssh_user = "ubuntu"
bastion_ssh_port = 22

# VM specifications
########################################################################
# Maximum cores that your Proxmox VE server can give to a VM
vm_max_vcpus = 2
# Control plane VM specifications
vm_k8s_control_plane = {
  node_count = 1
  vcpus      = 2
  memory     = 2048
  disk_size  = 20
}
# Worker nodes VM specifications
vm_k8s_worker = {
  node_count = 3
  vcpus      = 2
  memory     = 3072
  disk_size  = 20
}

# Kubernetes settings
########################################################################
kube_version               = "v1.29.5"
kube_network_plugin        = "calico"
enable_nodelocaldns        = false
podsecuritypolicy_enabled  = false
persistent_volumes_enabled = false
helm_enabled               = false
ingress_nginx_enabled      = false
argocd_enabled             = false
argocd_version             = "v2.11.4"
