# Ignite Prestige

```TXT
To update your site in the future:

  1. Upload changes to S3:
  aws s3 cp index.html s3://igniteprestige.com/index.html
  2. Invalidate the CloudFront cache so changes appear immediately:
  aws cloudfront create-invalidation \
      --distribution-id YOUR_DISTRIBUTION_ID \
      --paths "/*"

  You can find your distribution ID with:
  aws cloudfront list-distributions \
      --query 'DistributionList.Items[?DomainName==`d16ye83agtsdjj.cloudfront.net`].Id' \
      --output text
```