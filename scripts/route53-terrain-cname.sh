#!/usr/bin/env bash
# Route 53: create CNAME terrain.castalia.institute -> InquiryInstitute.github.io
# Run with an AWS identity that has route53:ChangeResourceRecordSets and route53:ListHostedZones.
# Usage:
#   export AWS_PROFILE=custodian   # or your Route 53 profile
#   ./scripts/route53-terrain-cname.sh
# Or with zone ID known:
#   ZONE_ID=Z0123456789ABCDEF ./scripts/route53-terrain-cname.sh

set -e

TARGET="InquiryInstitute.github.io"
NAME="terrain.castalia.institute"

if [[ -z "$ZONE_ID" ]]; then
  echo "Resolving hosted zone for castalia.institute..."
  ZONE_ID=$(aws route53 list-hosted-zones --query "HostedZones[?Name=='castalia.institute.'].Id" --output text | sed 's|/hostedzone/||')
  if [[ -z "$ZONE_ID" ]]; then
    echo "No hosted zone found for castalia.institute. Create one in Route 53 or set ZONE_ID."
    exit 1
  fi
fi

echo "Using hosted zone: $ZONE_ID"
echo "Creating CNAME: $NAME -> $TARGET"

aws route53 change-resource-record-sets --hosted-zone-id "$ZONE_ID" --change-batch '{
  "Comment": "GitHub Pages custom domain for terrAIn",
  "Changes": [{
    "Action": "UPSERT",
    "ResourceRecordSet": {
      "Name": "terrain.castalia.institute",
      "Type": "CNAME",
      "TTL": 300,
      "ResourceRecords": [{ "Value": "InquiryInstitute.github.io" }]
    }
  }]
}'

echo "Done. Allow a few minutes for DNS and GitHub to verify; then https://terrain.castalia.institute will serve the repo."
