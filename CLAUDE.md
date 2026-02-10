# Ignite Prestige

Single-page website hosted on AWS.

## Architecture

- **S3 bucket**: `igniteprestige.com` in `us-west-2` — static file hosting
- **CloudFront**: `d16ye83agtsdjj.cloudfront.net` — CDN with HTTPS
- **Route 53**: Hosted zone `Z053593131O2FX8W1E47U` — DNS for `igniteprestige.com` and `www.igniteprestige.com`
- **ACM certificate**: `us-east-1` — covers `igniteprestige.com` and `*.igniteprestige.com`
- **FormSubmit.co**: Contact form submissions are POSTed via AJAX to `https://formsubmit.co/ajax/igniteprestige@gmail.com` and forwarded as emails

## Deployment

```bash
./deploy.sh
```

Uploads files to S3 and invalidates the CloudFront cache.

## Manual commands

Upload a single file:
```bash
aws s3 cp index.html s3://igniteprestige.com/index.html
```

Invalidate CloudFront cache:
```bash
aws cloudfront create-invalidation --distribution-id DISTRIBUTION_ID --paths "/*"
```
