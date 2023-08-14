const config = require('haraka-config')

const externalSmtpRelay = config.get('relay_via_external.ini')

exports.hook_get_mx = function (next, hmail, domain) {
    // All relaying goes via external service
    return next(OK, externalSmtpRelay.main);
}