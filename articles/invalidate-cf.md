---
title: Invalidate A CloudFront Distribution By Domain Name
date: 2020-05-20
---

Hardcoded CloudFront distribution ids can be avoided by querying the
distribution list for a particular domain.

Bash example:

```
# get the CloudFront Id
CF_DISTRIBUTION_ID=$(aws cloudfront list-distributions \
  --query "DistributionList.Items[?contains(Aliases.Items[0], "example.com")] | [0].Id" \
  --output text
)

# create invalidation
aws cloudfront create-invalidation --distribution-id ${CF_DISTRIBUTION_ID} --paths "/*"
```
