# Route 53: automata.inquiry.institute

GitHub Pages is configured to use **automata.inquiry.institute**. To finish setup, add this DNS record in the **inquiry.institute** hosted zone in AWS Route 53.

## CNAME record

| Type  | Name                       | Value                     | TTL  |
|-------|----------------------------|---------------------------|------|
| CNAME | automata.inquiry.institute | InquiryInstitute.github.io | 300  |

## Option A: AWS CLI

Use the script (with a profile that has Route 53 access):

```bash
export AWS_PROFILE=your-route53-profile   # if needed
./scripts/route53-automata-cname.sh
```

Or with a known hosted zone ID:

```bash
ZONE_ID=Z0123456789ABCDEF ./scripts/route53-automata-cname.sh
```

## Option B: AWS Console

1. Open **Route 53** → **Hosted zones** → **inquiry.institute**.
2. **Create record**:
   - Record name: `automata`
   - Record type: `CNAME`
   - Value: `InquiryInstitute.github.io`
   - TTL: 300
3. Create the record.

After DNS propagates, GitHub will issue a certificate and https://automata.inquiry.institute will serve this repo’s Pages site.
