#!/bin/bash
for i in {0..1}
do
	export BC_NODE_ID=$i
	export VALIDATORS_CONF=tm-0-0.blockid-0,tm-1-0.blockid-1
	export SEEDS_CONF=tm-0-0.blockid-0,tm-1-0.blockid-1
	envsubst '${BC_NODE_ID},${VALIDATORS_CONF},${SEEDS_CONF}' < "blockid-full-template.yaml" > "blockid-full-${BC_NODE_ID}.yaml"
	kubectl create -f blockid-full-${BC_NODE_ID}.yaml
done