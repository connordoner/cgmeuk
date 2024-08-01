import cf from 'cloudfront';

/**
 * ID of the key-value store to retrieve redirects from.
 * 
 * @var {string}
 */
const kvStoreId = 'ad319b10-a080-4e13-af95-f1b9177fcd43';

/**
 * HTML to return to the client when a redirect is triggered.
 * 
 * @var {string}
 */
const REDIRECT_HTML = `<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>CloudFront</center>
</body>
</html>`;

/**
 * Get the HTTP status code for a given redirect type.
 * 
 * @param   {string} type The redirect type.
 * @returns {number}      The HTTP status code.
 */
function getHttpStatusCodeFromRedirectType(type) {
    switch(type) {
        case 'permanent':
            return 301;
        case 'temporary':
            return 302;
    }
}

/**
 * Get the HTTP status description for a given redirect type.
 * 
 * @param   {string} type The redirect type.
 * @returns {string}      The HTTP status description.
 */
function getHttpStatusDescriptionFromRedirectType(type) {
    switch(type) {
        case 'permanent':
            return 'Moved Permanently';
        case 'temporary':
            return 'Found';
    }
}

/**
 * Get the redirect for a given URI from the key-value store.
 * 
 * @param   {object} kv  The key-value store object.
 * @param   {string} uri The URI to check for a redirect.
 * @returns {object}     The redirect object.
 */
async function fetchRedirectByUri(kv, uri) {
    // Normalize the URI to check against the KV store
    let normalizedUri = uri.replace(/\/$/, '');

    // If a redirect exists for this URI, return it
    if(await kv.exists(normalizedUri)) {
        // Fetch the redirect from the key-value store
        let redirect = await kv.get(normalizedUri, { format: 'json' });

        // Return it
        return redirect;
    }

    // Otherwise, return null to indicate that no redirect was found
    else {
        return null;
    }
}

/**
 * This function serves as the entrypoint for CloudFront Functions.
 * 
 * @param {object} event The event object.
 */
async function handler(event) {
    // Fetch a handle to the key-value store
    const kv = cf.kvs(kvStoreId);

    // Fetch the original request
    const request = event.request;
    
    // Get the host and URI from the request
    let host = request.headers.host.value;
    let uri  = request.uri;

    // If the request is to my non-WWW host, redirect to its WWW equivalent
    if(host === 'connorgurney.me.uk') {
        // Form the WWW equivalent
        var redirectDestination = 'https://www.connorgurney.me.uk' + uri;

        // Mark the redirect as permanent
        var redirectType = 'permanent';

        // Perform the redirect
        var shouldRedirect = true;
    }

    // If not, check if the URI matches any redirect rules
    else {
        // Run that check
        let redirect = await fetchRedirectByUri(kv, uri);

        // If a redirect was returned, work out where to redirect to and on what terms
        if(redirect !== null) {
            // Set the destination
            var redirectDestination = redirect.destination;

            // Set the redirect type
            var redirectType = redirect.type;

            // Perform the redirect
            var shouldRedirect = true;
        }
    }

    // If there's a redirect, action it
    if(shouldRedirect === true) {
        // Work out the status code and description
        let statusCode        = getHttpStatusCodeFromRedirectType(redirectType);
        let statusDescription = getHttpStatusDescriptionFromRedirectType(redirectType);

        // Return it to the client
        return {
            statusCode,
            statusDescription,
            headers: {
                location: {
                    value: redirectDestination
                }
            },
            body: {
                encoding: 'text',
                data: REDIRECT_HTML
            }
        }
    }

    // Otherwise, return the original request for onward processing
    else {
        return request;
    }
}
