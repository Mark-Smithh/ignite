#!/bin/bash

# Ignite Prestige - AWS S3 + CloudFront Deployment Script
# Usage: ./deploy.sh

set -e

# Configuration
BUCKET_NAME="igniteprestige.com"
REGION="${AWS_REGION:-us-west-2}"
CLOUDFRONT_DOMAIN="d16ye83agtsdjj.cloudfront.net"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=========================================="
echo "  Ignite Prestige - Deployment"
echo "=========================================="
echo ""
echo "Bucket: $BUCKET_NAME"
echo "Region: $REGION"
echo ""

# Check for AWS CLI
if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI is not installed."
    echo "Install it from: https://aws.amazon.com/cli/"
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo "Error: AWS credentials not configured."
    echo "Run 'aws configure' to set up your credentials."
    exit 1
fi

echo "[1/3] Uploading website files to S3..."
aws s3 sync "$SCRIPT_DIR" "s3://$BUCKET_NAME" \
    --region "$REGION" \
    --exclude "deploy.sh" \
    --exclude ".DS_Store" \
    --exclude "*.md" \
    --exclude ".gitignore" \
    --exclude ".git/*"

echo "[2/3] Invalidating CloudFront cache..."
DISTRIBUTION_ID=$(aws cloudfront list-distributions \
    --query "DistributionList.Items[?DomainName=='$CLOUDFRONT_DOMAIN'].Id" \
    --output text)

if [ -z "$DISTRIBUTION_ID" ]; then
    echo "Error: Could not find CloudFront distribution for $CLOUDFRONT_DOMAIN"
    exit 1
fi

aws cloudfront create-invalidation \
    --distribution-id "$DISTRIBUTION_ID" \
    --paths "/*" > /dev/null

echo "       Invalidation created for distribution $DISTRIBUTION_ID"

echo "[3/3] Deployment complete!"
echo ""
echo "=========================================="
echo "  Your website is live!"
echo "=========================================="
echo ""
echo "  https://igniteprestige.com"
echo "  https://www.igniteprestige.com"
echo ""
echo "Note: CloudFront cache invalidation may take 1-2 minutes."
echo ""
