___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Text Chunker Variable",
  "description": "Takes a string as input and returns a 100-character chunk based on the specified chunk number. Useful for sending long text to GA4.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "sourceText",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "{{Form Vitals Data}}"
  },
  {
    "type": "TEXT",
    "name": "chunkNumber",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": 1
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Require the necessary GTM APIs
const log = require('logToConsole');
const makeInteger = require('makeInteger');

// Get the values from the template's UI fields
const sourceText = data.sourceText;
const chunkNumber = makeInteger(data.chunkNumber);
const chunkSize = 100;

// Basic validation
if (!sourceText || chunkNumber < 1) {
  // If there's no source text or the chunk number is invalid, return undefined.
  return undefined;
}

// Calculate the start and end positions for the substring
const start = (chunkNumber - 1) * chunkSize;
const end = start + chunkSize;

// If the start position is beyond the length of the text, there's no chunk to return.
if (start >= sourceText.length) {
  return undefined;
}

// Extract and return the chunk of text
const chunk = sourceText.substring(start, end);
log('Returning chunk ' + chunkNumber + ': ' + chunk); // Logs to GTM's preview mode console
return chunk;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 8/3/2025, 10:24:17 AM

