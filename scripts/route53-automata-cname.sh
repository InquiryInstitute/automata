#!/usr/bin/env bash
# Route 53: create CNAME automata.inquiry.institute -> InquiryInstitute.github.io
# Run with an AWS identity that has route53:ChangeResourceRecordSets and route53:ListHostedZones.
# Usage:
#   export AWS_PROFILE=your-profile   # optional
#   ./scripts/route53-automata-cname.sh
# Or with zone ID known:
#   ZONE_ID=Z0123456789ABCDEF ./scripts/route53-automata-cname.sh

set -e

TARGET="InquiryInstitute.github.io"
NAME="automata.inquiry.institute"

if [[ -z "$ZONE_ID" ]]; then
  echo "Resolving hosted zone for inquiry.institute..."
  ZONE_ID=$(aws route53 list-hosted-zones --query "HostedZones[?Name=='inquiry.institute.'].Id" --output text | sed 's|/hostedzone/||')
  if [[ -z "$ZONE_ID" ]]; then
    echo "No hosted zone found for inquiry.institute. Create one in Route 53 or set ZONE_ID."
    exit 1
  fi
fi

echo "Using hosted zone: $ZONE_ID"
echo "Creating CNAME: $NAME -> $TARGET"

aws route53 change-resource-record-sets --hosted-zone-id "$ZONE_ID" --change-batch '{
  "Comment": "GitHub Pages custom domain for Automata",
  "Changes": [{
    "Action": "UPSERT",
    "ResourceRecordSet": {
      "Name": "automata.inquiry.institute",
      "Type": "CNAME",
      "TTL": 300,
      "ResourceRecords": [{ "Value": "InquiryInstitute.github.io" }]
    }
  }]
}'

echo "Done. Allow a few minutes for DNS and GitHub to verify; then https://automata.inquiry.institute will serve the repo."
