# Redirects on connorgurney.me.uk

My website has many URIs that are redirected to other content on my website or other locations on the Internet. This is generally either for short URLs that I'm using on print or social media, or for content that's moved.

These redirects are stored in a YAML file, deployed to [Amazon CloudFront KeyValueStore](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/kvs-with-functions.html) and served at runtime by [Amazon CloudFront Functions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cloudfront-functions.html).

## Storage

A list of all redirects on my website is stored in a YAML file at [content/redirects.yml](../content/redirects.yml).

The format of each entry is as follows:

```yaml
- source: /path-of-source
  destination: /path-of-destination
  type: permanent | temporary
  reason: friendly
```

Those redirects are then stored in Amazon CloudFront KeyValueStore to ensure that they're accessible by the function that serves them at runtime. This also has the benefit of avoiding that function having to return to the origin which reduces the time taken to serve a response.

## Deployment

At the moment, I have to manually copy the redirects from the YAML file and input them into Amazon CloudFront KeyValueStore using the AWS Console.

In future, I'm going to automate this with a script that runs as part of my continous deployment action. For more information, see [#7](https://github.com/connordoner/cgmeuk/issues/7).
