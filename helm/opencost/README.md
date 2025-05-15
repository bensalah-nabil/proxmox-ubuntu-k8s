# Installation

helm upgrade -i opencost opencost-charts/opencost \
	--namespace opencost \
	--create-namespace \ 
	-f helm/opencost/values.yaml
