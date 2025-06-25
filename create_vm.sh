#!/bin/bash

RESOURCE_GROUP="socks5-rg"
VM_NAME="socks5-vm"
LOCATION="japaneast"
IMAGE="UbuntuLTS"
ADMIN_USER="azureuser"
VM_SIZE="Standard_B1s"
PUBLIC_IP_SKU="Basic"
PORT=1080

echo "Tạo resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Tạo VM Ubuntu (B1s)..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image $IMAGE \
  --size $VM_SIZE \
  --location $LOCATION \
  --admin-username $ADMIN_USER \
  --authentication-type password \
  --admin-password "AzureSocks5@123" \
  --public-ip-sku $PUBLIC_IP_SKU \
  --output none

echo "Mở cổng 22 (SSH) và $PORT (SOCKS5)..."
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --port 22 --priority 1001
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --port $PORT --priority 1002

echo "Lấy IP Public..."
az vm list-ip-addresses --name $VM_NAME --resource-group $RESOURCE_GROUP \
  --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv
