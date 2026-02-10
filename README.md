# Ignite Prestige

Professional cleaning services website for model homes, spec homes, and commercial properties.

**Live site:** [igniteprestige.com](https://igniteprestige.com)

## Features

- Single-page responsive design
- Service showcases for model home, spec home, and commercial cleaning
- Contact form powered by [FormSubmit.co](https://formsubmit.co) — submissions are emailed to igniteprestige@gmail.com and sent via SMS to the owner
- Mobile-friendly navigation

## Architecture

- **Hosting**: AWS S3 (`igniteprestige.com` bucket, `us-west-2`)
- **CDN**: AWS CloudFront with HTTPS
- **DNS**: AWS Route 53 — `igniteprestige.com` and `www.igniteprestige.com`
- **Contact form**: FormSubmit.co AJAX endpoint

## Deployment

```bash
./deploy.sh
```

Uploads files to S3 and invalidates the CloudFront cache.
